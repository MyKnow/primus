//
//  MainTabView.swift
//  primus
//
//  Created by 정민호 on 6/27/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MainTabViewReducer {
    struct State: Equatable {
        var selected: MainTabView.Tab = .a
    }
    
    enum Action {
        case selectTab(MainTabView.Tab)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .selectTab(tab):
                state.selected = tab
                return .none
            }
        }
    }
}
