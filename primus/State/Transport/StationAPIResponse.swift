//
//  StationAPIResponse.swift
//  primus
//
//  Created by 정민호 on 6/28/24.
//


import Foundation

// MARK: - Welcome8
struct StationAPI {
    var response: StationAPIResponse
}

// MARK: - Response
struct StationAPIResponse {
    var comMsgHeader: String
    var msgHeader: MsgHeader
    var msgBody: StationMsgBody
}

// MARK: - MsgBody
struct StationMsgBody {
    var busRouteStationList: [BusRouteStationList]
}

// MARK: - BusRouteStationList
struct BusRouteStationList {
    var centerYn: Yn
    var districtCD, mobileNo: String
    var regionName: RegionName
    var stationID, stationName, x, y: String
    var stationSeq: String
    var turnYn: Yn
}

enum Yn: String {
    case n = "N"
    case y = "Y"
}

enum RegionName: String {
    case 용인 = "용인"
    case 수원 = "수원"
    case 화성 = "화성"
}
