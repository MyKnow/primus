//
//  MainTabView.swift
//  primus
//
//  Created by 정민호 on 6/27/24.
//

import Foundation
import ComposableArchitecture
import SwiftUI

@Reducer
struct MainTabViewReducer {
    struct State: Equatable {
        enum Tab: Equatable, CaseIterable {
            case Status, Transport, Community
            
            var title: String {
                switch self {
                case .Status:
                    return "현황"
                case .Transport:
                    return "교통"
                case .Community:
                    return "커뮤니티"
                }
            }
            
            var image: Image {
                switch self {
                case .Status:
                    return Image(systemName: "chart.bar.fill")
                case .Transport:
                    return Image(systemName: "tram.fill")
                case .Community:
                    return Image(systemName: "person.2.fill")
                }
            }
            
            @ViewBuilder
            var view: some View {
                switch self {
                case .Status:
                    StatusCheckMainView()
                case .Transport:
                    TransportMainView(store: Store(
                        initialState: .init(),
                        reducer: { TransportAPIReducer() }
                    ))
                case .Community:
                    CommunityMainView()
                }
            }
        }
        
        var selected: Tab = .Transport
    }
    
    enum Action {
        case selectTab(State.Tab)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .selectTab(tab):
            state.selected = tab
            return .none
        }
    }
}
