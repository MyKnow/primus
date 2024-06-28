//
//  TransportStationUseCase.swift
//  primus
//
//  Created by 정민호 on 6/28/24.
//

import Foundation
import ComposableArchitecture

class TransportStationUseCase {
    private let isTestable: Bool
    private var apiKey: String
    private var apiUrl: String
    
    init(isTestable: Bool = false) {
        self.isTestable = isTestable
        
        if let apiKey = Bundle.main.infoDictionary?["API_ENCODING_KEY"] as? String,
           let apiUrl = Bundle.main.infoDictionary?["BUS_ROUTE_API"] as? String {
            self.apiKey = apiKey
            self.apiUrl = apiUrl
        } else {
            // 기본값 설정 또는 에러 처리
            self.apiKey = ""
            self.apiUrl = ""
        }
        
        // URL 검증 및 재구성
        if !self.apiUrl.hasPrefix("http://") && !self.apiUrl.hasPrefix("https://") {
            self.apiUrl = "https://" + self.apiUrl
        }
    }
    
    enum UseCaseError: Error {
        case invalidAPIKey
        case invalidAPIUrl
        case invalidURL
        case requestFailed
        case decodeError
    }
    
    func fetchResponse(routeID: String) async -> Result<StationAPIResponse, UseCaseError> {
        await withCheckedContinuation { continuation in
            self.requestAPI(routeID: routeID) {
                continuation.resume(returning: $0)
            }
        }
    }
    
    private func requestAPI(routeID: String, completionHandler: @escaping (Result<StationAPIResponse, UseCaseError>) -> Void) {
        guard !apiKey.isEmpty else {
            completionHandler(.failure(.invalidAPIKey))
            return
        }
        
        guard !apiUrl.isEmpty else {
            completionHandler(.failure(.invalidAPIUrl))
            return
        }
        
        // URL 인코딩 (API 키는 인코딩하지 않음)
        let encodedRouteID = routeID.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let url = URL(string: "\(apiUrl)?serviceKey=\(apiKey)&routeId=\(encodedRouteID)") else {
            print("Invalid URL")
            completionHandler(.failure(.invalidURL))
            return
        }
        
        // URL 출력
        print("Request URL: \(url)")
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Request Error: \(error)")
                completionHandler(.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.requestFailed))
                return
            }
            
            print("Response Data: \(String(data: data, encoding: .utf8) ?? "")")
            if let parsedResponse = self.parseXML(data: data) {
                print("success!!")
                completionHandler(.success(parsedResponse))
            }  else {
                completionHandler(.failure(.decodeError))
            }
        }
        task.resume()
    }
    
    private func parseXML(data: Data) -> StationAPIResponse? {
        let parser = XMLParser(data: data)
        let delegate = StationAPIXMLParser()
        parser.delegate = delegate
        
        if parser.parse() {
            return delegate.apiResponse
        } else {
            return nil
        }
    }
}

extension TransportStationUseCase: DependencyKey {
    static var liveValue: TransportStationUseCase = .init()
    static var testValue: TransportStationUseCase = .init(isTestable: true)
}

extension DependencyValues {
    var stationAPIUseCase: TransportStationUseCase {
        get { self[TransportStationUseCase.self] }
        set { self[TransportStationUseCase.self] = newValue }
    }
}
