import SwiftUI

struct MainMenuView: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                SinglePlayerMenuView()
            } label: {
                Text("Single Player")
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(.ultraThickMaterial)
                            .shadow(radius: 8)
                    }
            }
            .buttonStyle(.plain)
            NavigationLink {
                MultiplayerMenuView()
            } label: {
                Text("Multiplayer")
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(.ultraThickMaterial)
                            .shadow(radius: 8)
                    }
            }
            .buttonStyle(.plain)
        }
        .background(.thinMaterial)
    }
}

#Preview {
    MainMenuView()
}
