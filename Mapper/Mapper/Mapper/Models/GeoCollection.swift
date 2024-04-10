import Foundation
import SwiftUI
import MapKit

protocol GeoCollection {
    var id: String { get set }
    var title: String { get }
    var objects: [GeoObject] { get set }
    var latitude: Double { get }
    var longitude: Double { get }
}

extension GeoCollection {
    
    var progress: Double {
        Double(self.objects.filter({ $0.isFound == true }).count) / Double(self.objects.count)
    }
    
    var startPosition: MapCameraPosition {
        MapCameraPosition.camera(MapCamera(
            centerCoordinate: CLLocationCoordinate2D(
                latitude: self.latitude,
                longitude: self.longitude),
            distance: 12_000_000))
    }
}
