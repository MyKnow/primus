//
//  PrimusTests.swift
//  PrimusTests
//
//  Created by MyKnow on 2024/06/29.
//

import XCTest
import ComposableArchitecture

@testable import primus

final class PrimusTests: XCTestCase {
    @MainActor
    func testExample() async throws {
        let store = TestStore(initialState: TransportAPIReducer.State()) {
            TransportAPIReducer()
        }
        
        await store.send(.fetchBus24Locations)
        
    }
}
