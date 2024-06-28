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

final class TransportBusUseCaseTests {
    @Test func busLocationAPITest() async throws {
        typealias E = TransportBusUseCase.UseCaseError
        let useCase = TransportBusUseCase()
        
        // 24번 버스 위치 조회 테스트
        if case let .success(result) = await useCase.fetchResponse(routeID: "241428004") {
            XCTAssertEqual(result.msgHeader.resultCode, "0")
        }else {
            XCTFail("Failed to fetch response")
        }
        
        // 720-3번 버스 위치 조회 테스트
        if case let .success(result) = await useCase.fetchResponse(routeID: "234000068") {
            XCTAssertEqual(result.msgHeader.resultCode, "0")
        }else {
            XCTFail("Failed to fetch response")
        }
        
        // 잘못된 노선 번호 조회 테스트
        if case let .success(result) = await useCase.fetchResponse(routeID: "000000000") {
            XCTAssertEqual(result.msgHeader.resultCode, "4")
        }else {
            XCTFail("Failed to fetch response")
        }
    }
    
    @Test func stationListAPITest() async throws {
        typealias E = TransportStationUseCase.UseCaseError
        let useCase = TransportStationUseCase()
        
        // 24번 버스 정류장 조회 테스트
        if case let .success(result) = await useCase.fetchResponse(routeID: "241428004") {
            XCTAssertEqual(result.msgHeader.resultCode, "0")
        } else {
            XCTFail("Failed to fetch response")
        }
        
        // 720-3번 버스 정류장 조회 테스트
        if case let .success(result) = await useCase.fetchResponse(routeID: "234000068") {
            XCTAssertEqual(result.msgHeader.resultCode, "0")
        }else {
            XCTFail("Failed to fetch response")
        }
        
        // 잘못된 노선 번호 조회 테스트
        if case let .success(result) = await useCase.fetchResponse(routeID: "000000000") {
            XCTAssertEqual(result.msgHeader.resultCode, "4")
        }else {
            XCTFail("Failed to fetch response")
        }
    }
}
