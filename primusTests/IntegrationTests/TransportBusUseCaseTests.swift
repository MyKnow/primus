//
//  TransportBusUseCaseTests.swift
//  primusTests
//
//  Created by MyKnow on 2024/06/228.
//

import XCTest
import Testing
import ComposableArchitecture

@testable import primus

final class TransportBusUseCaseTests: XCTestCase {
    func testBusLocationAPITest() async throws {
        typealias E = TransportBusUseCase.UseCaseError
        let useCase = TransportBusUseCase()
        
        // 24번 버스 위치 조회 테스트
        let result1 = await useCase.fetchResponse(routeID: "241428004")
        switch result1 {
        case let .success(result):
            XCTAssertTrue(result.msgHeader.resultCode == "0" || result.msgHeader.resultCode == "4", "24번 버스 위치 조회 실패")
        case let .failure(error):
            XCTFail("Failed to fetch response: \(error)")
        }
        
        // 720-3번 버스 위치 조회 테스트
        let result2 = await useCase.fetchResponse(routeID: "234000068")
        switch result2 {
        case let .success(result):
            XCTAssertTrue(result.msgHeader.resultCode == "0" || result.msgHeader.resultCode == "4", "720-3번 버스 위치 조회 실패")
        case let .failure(error):
            XCTFail("Failed to fetch response: \(error)")
        }
        
        // 잘못된 노선 번호 조회 테스트
        let result3 = await useCase.fetchResponse(routeID: "000000000")
        switch result3 {
        case let .success(result):
            XCTAssertEqual(result.msgHeader.resultCode, "4", "잘못된 노선 번호 조회 실패")
        case let .failure(error):
            XCTFail("Failed to fetch response: \(error)")
        }
    }
    
    func testStationListAPITest() async throws {
        typealias E = TransportStationUseCase.UseCaseError
        let useCase = TransportStationUseCase()
        
        // 24번 버스 정류장 조회 테스트
        let result1 = await useCase.fetchResponse(routeID: "241428004")
        switch result1 {
        case let .success(result):
            XCTAssertEqual(result.msgHeader.resultCode, "0", "24번 버스 정류장 조회 실패")
        case let .failure(error):
            XCTFail("Failed to fetch response: \(error)")
        }
        
        // 720-3번 버스 정류장 조회 테스트
        let result2 = await useCase.fetchResponse(routeID: "234000068")
        switch result2 {
        case let .success(result):
            XCTAssertEqual(result.msgHeader.resultCode, "0", "720-3번 버스 정류장 조회 실패")
        case let .failure(error):
            XCTFail("Failed to fetch response: \(error)")
        }
        
        // 잘못된 노선 번호 조회 테스트
        let result3 = await useCase.fetchResponse(routeID: "000000000")
        switch result3 {
        case let .success(result):
            XCTAssertEqual(result.msgHeader.resultCode, "4", "잘못된 노선 번호 조회 실패")
        case let .failure(error):
            XCTFail("Failed to fetch response: \(error)")
        }
    }
}
