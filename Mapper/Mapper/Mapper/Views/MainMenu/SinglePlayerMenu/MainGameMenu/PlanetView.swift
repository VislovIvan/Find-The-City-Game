import SwiftUI
import MapKit

struct PlanetView: View {
    @Environment (PackDataManager.self) private var packDataManager
    @State var selectedContinent: ContinentPack?
    @Binding var isPackSelected: Bool
    @State var position: MapCameraPosition = .camera(
        MapCamera(
            centerCoordinate: CLLocationCoordinate2D(
                latitude: 0.0,
                longitude: 0.0),
            distance: 50000000.0)
    )
    var body: some View {
        ZStack {
            Map(position: $position, bounds: MapCameraBounds(
                minimumDistance: 20000000,
                maximumDistance: 100000000)) {
                    ForEach(packDataManager.continents) { pack in
                        Annotation(pack.title, coordinate: pack.titleCoordinates) {
                            Button(action: {
                                withAnimation {
                                    position = .camera(MapCamera(
                                        centerCoordinate: pack.titleCoordinates,
                                        distance: 20000000.0))
                                    selectedContinent = pack
                                    isPackSelected = true
                                }
                            }, label: {
                                CircularProgressView(currentPercentage: pack.progress)
                                    .scaleEffect(CGSize(width: 0.2, height: 0.2))
                            })
                        }
                        .annotationTitles(.hidden)
                    }
                }
                .mapStyle(.imagery(elevation: .realistic))
                .blur(radius: isPackSelected ? 20 : 0)
                .ignoresSafeArea()
            
            if isPackSelected {
                if let selectedContinent {
                    ContinentPackView(continentPack:
                                        selectedContinent,
                                      progress: selectedContinent.progress,
                                      isPackSelected: $isPackSelected)
                }
            }
        }
    }
}
#Preview {
    let mainVM = PackDataManager()
    return PlanetView(isPackSelected: .constant(false))
        .environment(mainVM)
}
