//
//  BusAPIState.swift
//  primus
//
//  Created by 정민호 on 6/28/24.
//

import Foundation

// MARK: - BusAPIResponse
struct BusAPI {
    var response: BusAPIResponse
}

// MARK: - APIResponse
struct BusAPIResponse {
    var comMsgHeader: String
    var msgHeader: MsgHeader
    var msgBody: BusMsgBody
}

// MARK: - MsgBody
struct BusMsgBody {
    var busLocationList: [BusLocationList]
}

// MARK: - BusLocationList
struct BusLocationList {
    var endBus, lowPlate, plateNo, plateType: String
    var remainSeatCnt, routeID, stationID, stationSeq: String
}
