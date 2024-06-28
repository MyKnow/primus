//
//  TransportAPIStore.swift
//  primus
//
//  Created by 정민호 on 6/28/24.
//
import Foundation
import ComposableArchitecture
import SwiftUI

@Reducer
struct TransportAPIReducer {
    struct State: Equatable {
        var resultCode: String = ""
        var resultMessage: String = ""
        var routeId: String = ""
        var stationId: String = ""
        var stationSeq: String = ""
        var endBus: String = ""
        var lowPlate: String = ""
        var plateNo: String = ""
        var plateType: String = ""
        var remainSeatCnt: String = ""
    }
    
    enum Action {
        case fetchResponse
        case responseReceived(Result<State, APIError>)
    }
    
    
    enum APIError: Error, Equatable {
        case requestFailed
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchResponse:
                return .none
            case let .responseReceived(.success(response)):
                state = response
                return .none
            case .responseReceived(.failure):
                return .none
            }
        }
    }
}
