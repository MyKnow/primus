//
//  XMLParserDelegate.swift
//  primus
//
//  Created by 정민호 on 6/28/24.
//

import Foundation

class BusAPIXMLParser: NSObject, XMLParserDelegate {
    private var currentElement: String?
    private var currentBusLocationList: BusLocationList?
    private var busLocationList: [BusLocationList] = []
    
    private var queryTime: String = ""
    private var resultCode: String = ""
    private var resultMessage: String = ""
    private var comMsgHeader: String = ""
    
    var apiResponse: BusAPIResponse?
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        if elementName == "busLocationList" {
            currentBusLocationList = BusLocationList(endBus: "", lowPlate: "", plateNo: "", plateType: "", remainSeatCnt: "", routeID: "", stationID: "", stationSeq: "")
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard let currentElement = currentElement else { return }
        
        switch currentElement {
        case "comMsgHeader":
            comMsgHeader += trimmedString
        case "queryTime":
            queryTime += trimmedString
        case "resultCode":
            resultCode += trimmedString
        case "resultMessage":
            resultMessage += trimmedString
        case "endBus":
            currentBusLocationList?.endBus += trimmedString
        case "lowPlate":
            currentBusLocationList?.lowPlate += trimmedString
        case "plateNo":
            currentBusLocationList?.plateNo += trimmedString
        case "plateType":
            currentBusLocationList?.plateType += trimmedString
        case "remainSeatCnt":
            currentBusLocationList?.remainSeatCnt += trimmedString
        case "routeId":
            currentBusLocationList?.routeID += trimmedString
        case "stationId":
            currentBusLocationList?.stationID += trimmedString
        case "stationSeq":
            currentBusLocationList?.stationSeq += trimmedString
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "busLocationList", let currentBusLocationList = currentBusLocationList {
            busLocationList.append(currentBusLocationList)
        } else if elementName == "msgHeader" {
            let msgHeader = MsgHeader(queryTime: queryTime, resultCode: resultCode, resultMessage: resultMessage)
            let msgBody = BusMsgBody(busLocationList: busLocationList)
            apiResponse = BusAPIResponse(comMsgHeader: comMsgHeader, msgHeader: msgHeader, msgBody: msgBody)
        }
        currentElement = nil
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        // 파싱이 끝난 후의 처리
        if let apiResponse = apiResponse {
            print("comMsgHeader: \(apiResponse.comMsgHeader)")
            print("queryTime: \(apiResponse.msgHeader.queryTime)")
            print("resultCode: \(apiResponse.msgHeader.resultCode)")
            print("resultMessage: \(apiResponse.msgHeader.resultMessage)")
            for busLocation in apiResponse.msgBody.busLocationList {
                print("endBus: \(busLocation.endBus)")
                print("lowPlate: \(busLocation.lowPlate)")
                print("plateNo: \(busLocation.plateNo)")
                print("plateType: \(busLocation.plateType)")
                print("remainSeatCnt: \(busLocation.remainSeatCnt)")
                print("routeID: \(busLocation.routeID)")
                print("stationID: \(busLocation.stationID)")
                print("stationSeq: \(busLocation.stationSeq)")
            }
        }
    }
}
