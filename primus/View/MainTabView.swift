import SwiftUI
import ComposableArchitecture

struct MainTabView: View {
    typealias Feat = MainTabViewReducer
    let store: StoreOf<Feat>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                TabView(selection: viewStore.binding(
                    get: \.selected,
                    send: Feat.Action.selectTab
                )) {
                    ForEach(Feat.State.Tab.allCases, id: \.self) { tab in
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

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainTabView(
                store: Store(initialState: .init(selected: .Transport), reducer: { MainTabViewReducer() })
            )
        }
    }
}
