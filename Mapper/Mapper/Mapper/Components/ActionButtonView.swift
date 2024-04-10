import SwiftUI
import MapKit

struct ActionButtonView: View {
    var label: String
    var textOpacity: Double
    var body: some View {
        Text(LocalizedStringKey(label))
            .font(.title2)
            .bold()
            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
            .foregroundStyle(.white.opacity(textOpacity))
            .background(
                ZStack {
                    Capsule()
                        .fill(Color(.black).opacity(0.6))
                    Capsule()
                        .stroke(.white.opacity(0.5), lineWidth: 1)
                        .fill(Color(.white).opacity(0.1))
                })
    }
}

#Preview {
    ZStack {
        Map()
            .mapStyle(.imagery)
        ActionButtonView(label: "Quick Play", textOpacity: 1)
    }
}
