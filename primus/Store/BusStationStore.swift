//
//  BusStationStore.swift
//  primus
//
//  Created by 정민호 on 6/30/24.
//

import ComposableArchitecture

@Reducer
class BusStationStore {
    struct State: Equatable {
        var startStationList: [BusRouteStation] = []
        var turnStationList: [BusRouteStation] = []
        var isLoading: Bool = false
    }
    
    enum Action: Equatable {
        case fetchBusRouteStationList(routeID: String)
        case setBusRouteStationList([BusRouteStation])
        case setLoading(Bool)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchBusRouteStationList(let routeID):
            state.isLoading = true
            return .run { send in
                let routeStationList = await TransportStationUseCase().fetchResponse(routeID: routeID)
                switch routeStationList {
                case .success(let routeStationList):
                    let sortedBusRouteStationList = routeStationList.msgBody.busRouteStationList.sorted {
                        guard let seq1 = Int($0.stationSeq), let seq2 = Int($1.stationSeq) else {
                            return false
                        }
                        return seq1 < seq2
                    }
                    await send(.setBusRouteStationList(sortedBusRouteStationList))
                case .failure(let error):
                    print("error: \(error)")
                    await send(.setLoading(false))
                }
            }
        case .setBusRouteStationList(let stationList):
            if let turnIndex = stationList.firstIndex(
                where: { $0.turnYn == .y
                }) {
                let startStationList = Array(stationList[0..<turnIndex+1])
                let turnStationList = Array(stationList[turnIndex+1..<stationList.count])
                
                print("Start Station List: \(startStationList.count)")
                print("Turn Station List: \(turnStationList.count)")
                
                state.startStationList = startStationList
                state.turnStationList = turnStationList
            } else {
                print("No turn point found")
                state.startStationList = stationList
                state.turnStationList = []
            }
            state.isLoading = false
            return .none
        case .setLoading(let isLoading):
            state.isLoading = isLoading
            return .none
        }
    }
}

