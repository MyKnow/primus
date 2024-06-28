//
//  TransportBusUseCase.swift
//  primus
//
//  Created by 정민호 on 6/28/24.
//

import Foundation
import ComposableArchitecture

class TransportBusUseCase {
    private let isTestable: Bool
    private var apiKey: String
    private var apiUrl: String
    
    init(isTestable: Bool = false) {
        self.isTestable = isTestable
        
        if let apiKey = Bundle.main.infoDictionary?["API_ENCODING_KEY"] as? String,
           let apiUrl = Bundle.main.infoDictionary?["BUS_LOCATION_API"] as? String {
            self.apiKey = apiKey
            self.apiUrl = apiUrl
        } else {
            // 기본값 설정 또는 에러 처리
            self.apiKey = ""
            self.apiUrl = ""
        }
        
        // URL 검증 및 재구성
        if !self.apiUrl.hasPrefix("http://") && !self.apiUrl.hasPrefix("https://") {
            self.apiUrl = "http://" + self.apiUrl
        }
    }
    
    enum UseCaseError: Error {
        case invalidAPIKey
        case invalidAPIUrl
        case invalidURL
        case requestFailed
        case decodeError
    }
    
    func fetchResponse(routeID: String) async -> Result<BusAPIResponse, UseCaseError> {
        await withCheckedContinuation { continuation in
            self.requestAPI(routeID: routeID) {
                continuation.resume(returning: $0)
            }
        }
    }
    
    private func requestAPI(routeID: String, completionHandler: @escaping (Result<BusAPIResponse, UseCaseError>) -> Void) {
        guard !apiKey.isEmpty else {
            completionHandler(.failure(.invalidAPIKey))
            return
        }
        
        guard !apiUrl.isEmpty else {
            completionHandler(.failure(.invalidAPIUrl))
            return
        }
        
        // URL 인코딩
        let encodedRouteID = routeID.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let url = URL(string: "\(apiUrl)?serviceKey=\(apiKey)&routeId=\(encodedRouteID)") else {
            print("Invalid URL")
            completionHandler(.failure(.invalidURL))
            return
        }
        
        // URL 출력
        print("Request URL: \(url)")
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(.failure(.requestFailed))
                return
            }
            
            print("Response Data: \(String(data: data, encoding: .utf8) ?? "")")
            if let parsedResponse = self.parseXML(data: data) {
                completionHandler(.success(parsedResponse))
            } else {
                completionHandler(.failure(.decodeError))
            }
        }
        task.resume()
    }


    
    func parseXML(data: Data) -> BusAPIResponse? {
        let parser = XMLParser(data: data)
        let delegate = BusAPIXMLParser()
        parser.delegate = delegate
        
        if parser.parse() {
            return delegate.apiResponse
        } else {
            return nil
        }
    }

}

extension TransportBusUseCase: DependencyKey {
    static var liveValue: TransportBusUseCase = .init()
    static var testValue: TransportBusUseCase = .init(isTestable: true)
}

extension DependencyValues {
    var apiUseCase: TransportBusUseCase {
        get { self[TransportBusUseCase.self] }
        set { self[TransportBusUseCase.self] = newValue }
    }
}
