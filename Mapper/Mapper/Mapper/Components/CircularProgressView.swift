import SwiftUI

struct CircularProgressView: View {
    @State var percentage1: Double = 0
    var currentPercentage: Double
    var body: some View {
        ZStack {
            Ring(lineWidth: 50,
                 backgroundColor: Color("TestColor").opacity(0.2),
                 foregroundColor: Color("TestColor"),
                 percentage: percentage1
            )
            .frame(width: 300, height: 300)
            .onAppear {
                self.percentage1 = currentPercentage
            }
            Image("unicorn-avatar")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 230, height: 230)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color("TestColor"), lineWidth: 4))
        }
    }
}

struct Ring: View {
    let lineWidth: CGFloat
    let backgroundColor: Color
    let foregroundColor: Color
    let percentage: Double
    var body: some View {
        GeometryReader { _ in
            ZStack {
                RingShape()
                    .stroke(style: StrokeStyle(lineWidth: lineWidth))
                    .fill(backgroundColor)
                RingShape(percent: percentage)
                    .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .fill(foregroundColor)
            }
        }
        .animation(.easeInOut(duration: 1), value: percentage)
    }
}

struct RingShape: Shape {
    var percent: Double
    let startAngle: Double
    typealias AnimatableData = Double
    var animatableData: Double {
        get {
            return percent
        }
        set {
            percent = newValue
        }
    }
    init(
        percent: Double = 100,
        startAngle: Double = -90
    ) {
        self.percent = percent
        self.startAngle = startAngle
    }
    static func percentToAngle(percent: Double, startAngle: Double) -> Double {
        return (percent / 100 * 360 ) + startAngle
    }
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let radius = min(height, width) / 2
        let center = CGPoint(x: width/2, y: height/2)
        let endAngle = Self.percentToAngle(percent: percent, startAngle: startAngle)
        return Path { path in
            path.addArc(center: center,
                        radius: radius,
                        startAngle: Angle(degrees: startAngle),
                        endAngle: Angle(degrees: endAngle),
                        clockwise: false)
        }
    }
    
}

#Preview {
    CircularProgressView(currentPercentage: 80)
}
