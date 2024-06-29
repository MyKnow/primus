//
//  TransportMainView.swift
//  primus
//
//  Created by 정민호 on 6/27/24.
//

import SwiftUI
import ComposableArchitecture

struct TransportMainView: View {
    let store: StoreOf<TransportAPIReducer>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack(spacing: 20) {
                    NaverMap()
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 300) // 정사각형 모양으로 크기 설정
                        .cornerRadius(20) // 코너 반경 설정
                        .padding(.top, 20) // 상단 여백 추가
                        .shadow(color: Color("ForegroundColor").opacity(0.5), radius: 10) // 그림자 추가
                    
                    ForEach(0..<3) { index in
                        BusInfoView(index: index)
                    }
                }
                .padding(.horizontal, 20) // 수평 여백 추가
                .onAppear {
                    Coordinator.shared.checkIfLocationServiceIsEnabled()
                    viewStore.send(.fetchBus24Locations) // 24번 버스 위치 fetch
                }
                Spacer(minLength: 100)
            }
        }
    }
}

struct BusInfoView: View {
    let index: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "bus.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 10)
                    .foregroundColor(busColor(for: busNames[index]))
                VStack(alignment: .leading) {
                    Text(busNames[index])
                        .font(.headline)
                        .foregroundColor(busColor(for: busNames[index]))
                    Text(busArrivals[index])
                        .font(.subheadline)
                        .foregroundColor(Color("ForegroundColor"))
                }
                
                Spacer()
            }
            BusRouteProgressView()
        }
        .padding()
        .background(Color("BackgroundColor"))
        .cornerRadius(10)
        .shadow(color: Color("ForegroundColor").opacity(0.5), radius: 3)
    }
    
    var busNames: [String] {
        ["720-3", "24", "Shuttle"]
    }
    
    var busArrivals: [String] {
        ["Arrival in 5 mins", "Arrived", "Arrival in 10 mins"]
    }
    
    func busColor(for name: String) -> Color {
        switch name {
        case "720-3":
            return .green
        case "24":
            return .yellow
        case "Shuttle":
            return .blue
        default:
            return .black
        }
    }
}

struct BusRouteProgressView: View {
    var body: some View {
        HStack {
            ForEach(0..<10) { index in
                if index == 2 {
                    Image(systemName: "bus.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                } else {
                    Circle()
                        .fill(index < 2 ? Color.blue : Color.gray)
                        .frame(width: 8, height: 8)
                }
                
                if index < 9 {
                    Rectangle()
                        .fill(index < 2 ? Color.blue : Color.gray)
                        .frame(width: 8, height: 2)
                }
            }
        }
        .padding(.top, 10)
    }
}

struct TransportMainView_Previews: PreviewProvider {
    static var previews: some View {
        TransportMainView(
            store: Store(initialState: TransportAPIReducer.State(), reducer: { TransportAPIReducer() })
        )
    }
}
