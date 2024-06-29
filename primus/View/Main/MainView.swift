//
//  MainView.swift
//  primus
//
//  Created by 정민호 on 6/27/24.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    let store: StoreOf<MainTabViewReducer>
    
    var body: some View {
        NavigationView {
            WithViewStore(store, observe: { $0 }) { viewStore in
                VStack {
                    MainNavigationView(viewStore: viewStore)
                    
                    ZStack {
                        TabView(selection: viewStore.binding(
                            get: \.selected,
                            send: MainTabViewReducer.Action.selectTab
                        )) {
                            ForEach(MainTabViewReducer.State.Tab.allCases, id: \.self) { tab in
                                NavigationStack {
                                    tab.view
                                }
                                .tag(tab)
                            }
                            .toolbar(.hidden, for: .tabBar)
                        }
                        
                        VStack {
                            Spacer()
                            TabBarView(viewStore: viewStore)
                        }
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            store: Store(initialState: .init(selected: .Transport), reducer: { MainTabViewReducer() })
        )
    }
}
