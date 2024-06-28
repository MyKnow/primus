import Foundation

class StationAPIXMLParser: NSObject, XMLParserDelegate {
    private var currentElement: String?
    private var currentBusRouteStationList: BusRouteStationList?
    private var busRouteStationList: [BusRouteStationList] = []
    
    private var queryTime: String = ""
    private var resultCode: String = ""
    private var resultMessage: String = ""
    private var comMsgHeader: String = ""
    
    var apiResponse: StationAPIResponse?
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        if elementName == "busStationList" {
            currentBusRouteStationList = BusRouteStationList(centerYn: .n, districtCD: "", mobileNo: "", regionName: .용인, stationID: "", stationName: "", x: "", y: "", stationSeq: "", turnYn: .n)
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
        case "centerYn":
            currentBusRouteStationList?.centerYn = Yn(rawValue: trimmedString) ?? .n
        case "districtCD":
            currentBusRouteStationList?.districtCD += trimmedString
        case "mobileNo":
            currentBusRouteStationList?.mobileNo += trimmedString
        case "regionName":
            currentBusRouteStationList?.regionName = RegionName(rawValue: trimmedString) ?? .용인
        case "stationID":
            currentBusRouteStationList?.stationID += trimmedString
        case "stationName":
            currentBusRouteStationList?.stationName += trimmedString
        case "x":
            currentBusRouteStationList?.x += trimmedString
        case "y":
            currentBusRouteStationList?.y += trimmedString
        case "stationSeq":
            currentBusRouteStationList?.stationSeq += trimmedString
        case "turnYn":
            currentBusRouteStationList?.turnYn = Yn(rawValue: trimmedString) ?? .n
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "busStationList", let currentBusRouteStationList = currentBusRouteStationList {
            busRouteStationList.append(currentBusRouteStationList)
        } else if elementName == "msgHeader" {
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
