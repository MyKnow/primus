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
    func testFetchBusRouteStationList() async throws {
        let mockStations: [BusRouteStation] = [
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "47962",
                regionName: .용인,
                stationID: "228001980",
                stationName: "단국대.평화의광장",
                x: "127.1287833",
                y: "37.3201333",
                stationSeq: "1",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "47900",
                regionName: .용인,
                stationID: "228001981",
                stationName: "단국대.인문관",
                x: "127.1283",
                y: "37.3222333",
                stationSeq: "2",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "47717",
                regionName: .용인,
                stationID: "228001978",
                stationName: "단국대정문",
                x: "127.12585",
                y: "37.3233333",
                stationSeq: "3",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "47439",
                regionName: .용인,
                stationID: "228001413",
                stationName: "대지고등학교.전내교차로",
                x: "127.1231667",
                y: "37.3239167",
                stationSeq: "4",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "29799",
                regionName: .용인,
                stationID: "228001006",
                stationName: "꽃메마을1단지",
                x: "127.1210333",
                y: "37.3230833",
                stationSeq: "5",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "29277",
                regionName: .용인,
                stationID: "228001005",
                stationName: "꽃메마을.새에덴교회",
                x: "127.1189833",
                y: "37.3223167",
                stationSeq: "6",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "29800",
                regionName: .용인,
                stationID: "228001004",
                stationName: "꽃메마을.현대홈타운3단지",
                x: "127.1179",
                y: "37.3217167",
                stationSeq: "7",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "56057",
                regionName: .용인,
                stationID: "228002190",
                stationName: "중앙공원",
                x: "127.1163167",
                y: "37.3206167",
                stationSeq: "8",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "29249",
                regionName: .용인,
                stationID: "228001003",
                stationName: "보정동행정복지센터",
                x: "127.1123667",
                y: "37.3206333",
                stationSeq: "9",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "47610",
                regionName: .용인,
                stationID: "228001377",
                stationName: "보정동카페거리.죽현마을",
                x: "127.1093333",
                y: "37.3206333",
                stationSeq: "10",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "56524",
                regionName: .용인,
                stationID: "228003503",
                stationName: "죽전역",
                x: "127.1069",
                y: "37.3241667",
                stationSeq: "11",
                turnYn: .y
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "29200",
                regionName: .용인,
                stationID: "228001028",
                stationName: "죽전역.수지레스피아.죽전2동행정복지센터.신세계경기점",
                x: "127.1073333",
                y: "37.3254667",
                stationSeq: "12",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "56058",
                regionName: .용인,
                stationID: "228002191",
                stationName: "보정동카페거리.죽현마을",
                x: "127.1093",
                y: "37.3203833",
                stationSeq: "13",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "29873",
                regionName: .용인,
                stationID: "228001002",
                stationName: "보정동행정복지센터",
                x: "127.11245",
                y: "37.3203667",
                stationSeq: "14",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "29796",
                regionName: .용인,
                stationID: "228001317",
                stationName: "중앙공원",
                x: "127.1165",
                y: "37.32045",
                stationSeq: "15",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "29797",
                regionName: .용인,
                stationID: "228001318",
                stationName: "꽃메마을.현대홈타운3단지",
                x: "127.1183",
                y: "37.3217167",
                stationSeq: "16",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "29282",
                regionName: .용인,
                stationID: "228001001",
                stationName: "꽃메마을2단지",
                x: "127.1202833",
                y: "37.32255",
                stationSeq: "17",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "29798",
                regionName: .용인,
                stationID: "228001000",
                stationName: "대지고등학교.전내교차로",
                x: "127.1230167",
                y: "37.32365",
                stationSeq: "18",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "47683",
                regionName: .용인,
                stationID: "228001737",
                stationName: "단국대.치과병원",
                x: "127.1253667",
                y: "37.3223667",
                stationSeq: "19",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "47899",
                regionName: .용인,
                stationID: "228001979",
                stationName: "단국대.종합실험동",
                x: "127.1256833",
                y: "37.3201667",
                stationSeq: "20",
                turnYn: .n
            ),
            BusRouteStation(
                centerYn: .n,
                districtCD: "2",
                mobileNo: "47962",
                regionName: .용인,
                stationID: "228001980",
                stationName: "단국대.평화의광장",
                x: "127.1287833",
                y: "37.3201333",
                stationSeq: "21",
                turnYn: .n
            )
        ]

        
        
        let store = TestStore(initialState: BusStationStore.State()) {
            BusStationStore()
        }

        await store.send(.fetchBusRouteStationList(routeID: "241428004")) {
            $0.isLoading = true
        }

        await store.receive(.setBusRouteStationList(mockStations)) {
            let sortedStations = mockStations.sorted {
                guard let seq1 = Int($0.stationSeq), let seq2 = Int($1.stationSeq) else {
                    return false
                }
                return seq1 < seq2
            }
            if let turnIndex = sortedStations.firstIndex(
                where: { $0.turnYn == .y
                }) {
                let startStationList = Array(sortedStations[0...turnIndex])
                let turnStationList = Array(sortedStations[(turnIndex + 1)...])
                $0.startStationList = startStationList
                $0.turnStationList = turnStationList
            } else {
                $0.startStationList = sortedStations
                $0.turnStationList = []
            }
            $0.isLoading = false
        }

        await store.finish()

        XCTAssertEqual(
            store.state.startStationList,
            Array(mockStations[..<11])
        )
        
        XCTAssertEqual(
            store.state.turnStationList,
            Array(mockStations[11...])
        )
        
        XCTAssertEqual(store.state.isLoading, false)
    }
}
