import Foundation
import SwiftUI
import MapKit

struct SecondButtonModifier: View {
    var label: String
    var body: some View {
        Text(LocalizedStringKey(label))
            .bold()
            .buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
            .foregroundStyle(.white)
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
            .background(
                ZStack {
                    Capsule()
                        .fill(Color(.black).opacity(0.6))
                    Capsule()
                        .stroke(Color.white.opacity(1), lineWidth: 0.5)
                }
            )
    }
}
