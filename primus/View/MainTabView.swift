import SwiftUI

struct MainTabView: View {
    enum Tab {
        case a, b, c
    }
    
    @State private var selected: Tab = .a
    
    var body: some View {
        ZStack {
            TabView(selection: $selected) {
                Group {
                    NavigationStack {
                        AView()
                    }
                    .tag(Tab.a)
                    
                    NavigationStack {
                        BView()
                    }
                    .tag(Tab.b)
                    
                    NavigationStack {
                        CView()
                    }
                    .tag(Tab.c)
                }
                .toolbar(.hidden, for: .tabBar)
            }
            
            VStack {
                Spacer()
                tabBar
            }
        }
    }
    
    var tabBar: some View {
        HStack {
            Spacer()
            Button {
                selected = .a
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    if selected == .a {
                        Text("View A")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .a ? Color.accentColor : Color.primary)
            Spacer()
            Button {
                selected = .b
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "gauge.with.dots.needle.bottom.0percent")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    if selected == .b {
                        Text("View B")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .b ? Color.accentColor : Color.primary)
            Spacer()
            Button {
                selected = .c
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "fuelpump")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    if selected == .c {
                        Text("View C")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .c ? Color.accentColor : Color.primary)
            Spacer()
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

struct AView: View {
    var body: some View {
        Text("View A")
    }
}

struct BView: View {
    var body: some View {
        Text("View B")
    }
}

struct CView: View {
    var body: some View {
        Text("View C")
    }
}

#Preview {
    MainTabView()
}
