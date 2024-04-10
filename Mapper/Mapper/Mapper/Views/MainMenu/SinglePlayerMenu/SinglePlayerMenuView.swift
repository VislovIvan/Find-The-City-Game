import SwiftUI

struct SinglePlayerMenuView: View {
    
    var packDataManager = PackDataManager()
    
    @State private var dragAmount: CGSize = .zero
    @State private var finalOffset: CGSize = .zero
    @State var isSelected = false
    
    let packViewHeight: CGFloat = UIScreen.main.bounds.height * 2.8
    let screenHeight = UIScreen.main.bounds.height
    let snapDistance: CGFloat = 230
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            PlanetView(isPackSelected: $isSelected).environment(packDataManager)
        }
    }
    
    private func adjustedOffset() -> CGSize {
        var newHeight = dragAmount.height + finalOffset.height
        let maxOffset = packViewHeight > screenHeight ? -(packViewHeight - screenHeight) : 0
        newHeight = max(min(newHeight, 0), maxOffset)
        return CGSize(width: 0, height: newHeight)
    }
    
    private func adjustFinalOffset(finalOffset: CGSize) -> CGSize {
        var newHeight = finalOffset.height
        let maxOffset = packViewHeight > screenHeight ? -(packViewHeight - screenHeight) : 0
        newHeight = max(min(newHeight, 0), maxOffset)
        return CGSize(width: finalOffset.width, height: newHeight)
    }
    
    private func totalDragHeight() -> CGFloat {
        return dragAmount.height + finalOffset.height
    }
    
    private func darknessOpacity(for dragHeight: CGFloat) -> CGFloat {
        let maxOpacity: CGFloat = 0.5
        if dragHeight < 0 {
            let opacity = abs(dragHeight / 90) * maxOpacity
            return min(opacity, maxOpacity)
        } else {
            return 0
        }
    }
    
    private func blurRadius(for dragHeight: CGFloat) -> CGFloat {
        let maxBlur: CGFloat = 20
        if dragHeight < 0 {
            let blur = abs(dragHeight / 190) * maxBlur
            return min(blur, maxBlur)
        } else {
            return 0
        }
    }
    
}

#Preview {
    SinglePlayerMenuView()
}

struct PackView: View {
    var packs: [Pack]
    var body: some View {
        VStack(spacing: 12) {
            Text("Special Packs")
                .font(.title)
                .bold()
                .foregroundStyle(.white)
            ForEach(packs.indices, id: \.self) { index in
                ZStack {
                    Image(packs[index].imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .shadow(radius: 10)
                        .frame(height: 300)
                        .cornerRadius(30)
                        .clipped()
                        .overlay(alignment: .bottom, content: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Text 1")
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.white.opacity(0.9))
                                        .foregroundStyle(.ultraThinMaterial)
                                        .blendMode(.plusLighter)
                                    
                                    Text((packs[index].title))
                                        .font(.title)
                                        .bold()
                                        .foregroundColor(.white.opacity(0.9))
                                        .foregroundStyle(.ultraThinMaterial)
                                        .blendMode(.plusLighter)
                                        .multilineTextAlignment(.leading)
                                    
                                    Text("Text 3")
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.white.opacity(0.9))
                                        .foregroundStyle(.ultraThinMaterial)
                                        .blendMode(.plusLighter)
                                }
                                .padding(.horizontal)
                                .padding(.bottom)
                                Spacer()
                            }
                        })
                        .padding(.horizontal, 30)
                }
            }
        }
        .offset(y: UIScreen.main.bounds.height / 0.76)
    }
}
