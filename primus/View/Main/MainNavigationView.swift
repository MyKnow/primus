//
//  MainNavigationView.swift
//  primus
//
//  Created by 정민호 on 6/27/24.
//

import SwiftUI
import ComposableArchitecture

struct MainNavigationView: View {
    let viewStore: ViewStore<MainTabViewReducer.State, MainTabViewReducer.Action>
    
    var body: some View {
        VStack {
            Spacer() // 내용이 없는 상태에서 네비게이션 바만 표시하기 위해 Spacer 사용
        }
        .navigationBarTitle(viewStore.selected.title, displayMode: .inline)
        .navigationBarItems(leading: Button("Left") {
            // Add action for left button
        }, trailing: Button("Right") {
            // Add action for right button
        })
    }
}

struct MainNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainNavigationView(viewStore: ViewStore(Store(
                initialState: MainTabViewReducer.State(),
                reducer: { MainTabViewReducer() }
            ),
            observe: { $0 }))
        }
    }
}
