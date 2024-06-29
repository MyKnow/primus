import Foundation

class StationAPIXMLParser: NSObject, XMLParserDelegate {
    private var currentElement: String?
    private var currentBusRouteStation: BusRouteStation?
    private var busRouteStationList: [BusRouteStation] = []
    
    private var queryTime: String = ""
    private var resultCode: String = ""
    private var resultMessage: String = ""
    private var comMsgHeader: String = ""
    
    var apiResponse: StationAPIResponse?
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        if elementName == "busRouteStationList" {
            currentBusRouteStation = BusRouteStation(centerYn: .n, districtCD: "", mobileNo: "", regionName: .용인, stationID: "", stationName: "", x: "", y: "", stationSeq: "", turnYn: .n)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard let currentElement = currentElement else { return }
        
        switch currentElement {
        case "centerYn":
            currentBusRouteStation?.centerYn = Yn(rawValue: trimmedString) ?? .n
        case "districtCd":
            currentBusRouteStation?.districtCD += trimmedString
        case "mobileNo":
            currentBusRouteStation?.mobileNo += trimmedString
        case "regionName":
            currentBusRouteStation?.regionName = RegionName(rawValue: trimmedString) ?? .용인
        case "stationId":
            currentBusRouteStation?.stationID += trimmedString
        case "stationName":
            currentBusRouteStation?.stationName += trimmedString
        case "x":
            currentBusRouteStation?.x += trimmedString
        case "y":
            currentBusRouteStation?.y += trimmedString
        case "stationSeq":
            currentBusRouteStation?.stationSeq += trimmedString
        case "turnYn":
            currentBusRouteStation?.turnYn = Yn(rawValue: trimmedString) ?? .n
        case "queryTime":
            queryTime += trimmedString
        case "resultCode":
            resultCode += trimmedString
        case "resultMessage":
            resultMessage += trimmedString
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "busRouteStationList", let currentBusRouteStation = currentBusRouteStation {
            busRouteStationList.append(currentBusRouteStation)
            self.currentBusRouteStation = nil
        } else if elementName == "msgBody" {
            let msgHeader = MsgHeader(queryTime: queryTime, resultCode: resultCode, resultMessage: resultMessage)
            let msgBody = StationMsgBody(busRouteStationList: busRouteStationList)
            apiResponse = StationAPIResponse(comMsgHeader: comMsgHeader, msgHeader: msgHeader, msgBody: msgBody)
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
            for busRouteStation in apiResponse.msgBody.busRouteStationList {
                print("centerYn: \(busRouteStation.centerYn)")
                print("districtCD: \(busRouteStation.districtCD)")
                print("mobileNo: \(busRouteStation.mobileNo)")
                print("regionName: \(busRouteStation.regionName)")
                print("stationID: \(busRouteStation.stationID)")
                print("stationName: \(busRouteStation.stationName)")
                print("x: \(busRouteStation.x)")
                print("y: \(busRouteStation.y)")
                print("stationSeq: \(busRouteStation.stationSeq)")
                print("turnYn: \(busRouteStation.turnYn)")
            }
        }
    }
}
