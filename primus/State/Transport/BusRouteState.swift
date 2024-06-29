//
//  BusRouteState.swift
//  primus
//
//  Created by 정민호 on 6/30/24.
//

// MARK: - BusStartRouteStation
struct BusStartRouteStation: Equatable {
    var stations: [BusRouteStation]
}

// MARK: - BusTurnRouteStation
struct BusTurnRouteStation: Equatable {
    var stations: [BusRouteStation]
}
