//
//  MainTabBarView.swift
//  primus
//
//  Created by 정민호 on 6/27/24.
//

import SwiftUI
import ComposableArchitecture

struct TabBarView: View {
    let viewStore: ViewStore<MainTabViewReducer.State, MainTabViewReducer.Action>
    
    var body: some View {
        HStack {
            Spacer()
            ForEach(MainTabViewReducer.State.Tab.allCases, id: \.self) { tab in
                Button {
                    viewStore.send(.selectTab(tab))
                } label: {
                    VStack(alignment: .center) {
                        tab.image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        if viewStore.selected == tab {
                            Text(tab.title)
                                .font(.system(size: 11))
                        }
                    }
                }
                .foregroundStyle(viewStore.selected == tab ? Color.accentColor : Color.primary)
                Spacer()
            }
        }
        .padding()
        .frame(height: 72)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color("BackgroundColor"))
                .shadow(color: Color("ForegroundColor").opacity(0.15), radius: 8, y: 2)
        }
        .padding(.horizontal)
    }
}

#Preview {
    TabBarView(
        viewStore: ViewStore(
            Store(
                initialState: .init(selected: .Transport),
                reducer: { MainTabViewReducer() }
            ),
            observe: { $0 }
        )
    )
}
