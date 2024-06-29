//
//  TransportAPIStore.swift
//  primus
//
//  Created by 정민호 on 6/28/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct TransportAPIReducer {
    typealias BusUseCase = TransportBusUseCase
    @Dependency(\.busAPIUseCase) var busUseCase: BusUseCase
    
    typealias StationUseCase = TransportStationUseCase
    @Dependency(\.stationAPIUseCase) var stationUseCase: StationUseCase
    
    struct State: Equatable {
        var bus24Locations: [BusLocation] = []
        var bus7203Locations: [BusLocation] = []
        var bus24Stations: [BusRouteStation] = []
        var bus7203Stations: [BusRouteStation] = []
        var localBusError: BusUseCase.UseCaseError?
        var localStationError: StationUseCase.UseCaseError?
        
        
        static func == (lhs: State, rhs: State) -> Bool {
            return lhs.bus24Locations == rhs.bus24Locations &&
                   lhs.bus7203Locations == rhs.bus7203Locations &&
                   lhs.bus24Stations == rhs.bus24Stations &&
                   lhs.bus7203Stations == rhs.bus7203Stations
        }
    }
    
    enum Action: Equatable {
        case fetchBus24Locations
        case fetchBus7203Locations
        case fetchBus24Stations
        case fetchBus7203Stations
        case bus24LocationsResponse(Result<[BusLocation], TransportBusUseCase.UseCaseError>)
        case bus7203LocationsResponse(Result<[BusLocation], TransportBusUseCase.UseCaseError>)
        case bus24StationsResponse(Result<[BusRouteStation], TransportStationUseCase.UseCaseError>)
        case bus7203StationsResponse(Result<[BusRouteStation], TransportStationUseCase.UseCaseError>)
        case setBusError(BusUseCase.UseCaseError)
        case setStationError(StationUseCase.UseCaseError)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchBus24Locations:
                return .run { send in
                    let result = await busUseCase.fetchResponse(routeID: "241428004")
                    
                    switch result {
                    case .success(let data):
                        print("data: \(data)")
                        await send(.bus24LocationsResponse(.success(data.msgBody.busLocationList)))
                    case .failure(let error):
                        print("error: \(error)")
                        await send(.setBusError(error))
                    }
                }
            case .fetchBus7203Locations:
                return .run { send in
                    let result = await busUseCase.fetchResponse(routeID: "234000068")
                    
                    switch result {
                    case .success(let data):
                        print("data: \(data)")
                        await send(.bus24LocationsResponse(.success(data.msgBody.busLocationList)))
                    case .failure(let error):
                        print("error: \(error)")
                        await send(.setBusError(error))
                    }
                }
            case .fetchBus24Stations:
                return .run { send in
                    let result = await stationUseCase.fetchResponse(routeID: "241428004")
                    
                    switch result {
                    case .success(let data):
                        print("data: \(data)")
                        await send(.bus24StationsResponse(.success(data.msgBody.busRouteStationList)))
                    case .failure(let error):
                        print("error: \(error)")
                        await send(.setStationError(error))
                    }
                }
            case .fetchBus7203Stations:
                return .run { send in
                    let result = await stationUseCase.fetchResponse(routeID: "234000068")
                    
                    switch result {
                    case .success(let data):
                        print("data: \(data)")
                        await send(.bus24StationsResponse(.success(data.msgBody.busRouteStationList)))
                    case .failure(let error):
                        print("error: \(error)")
                        await send(.setStationError(error))
                    }
                }
            case let .bus24LocationsResponse(.success(busLocations)):
                state.bus24Locations = busLocations
                return .none
                
            case let .bus7203LocationsResponse(.success(busLocations)):
                state.bus7203Locations = busLocations
                return .none
                
            case let .bus24StationsResponse(.success(busStations)):
                state.bus24Stations = busStations
                return .none
                
            case let .bus7203StationsResponse(.success(busStations)):
                state.bus7203Stations = busStations
                return .none
                
            case .bus24LocationsResponse(.failure),
                    .bus7203LocationsResponse(.failure),
                    .bus24StationsResponse(.failure),
                    .bus7203StationsResponse(.failure):
                return .none
                
            case .setBusError(let error):
                state.localBusError = error
                return .none
                
            case .setStationError(let error):
                state.localStationError = error
                return .none
            }
        }
    }
}
