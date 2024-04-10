import Foundation
import MapKit

struct GeoObject: Identifiable, Codable {
    var id: String
    let title: String
    let category: GeoObjectCategory
    var facts: [String]
    let latitude: Double
    let longitude: Double
    var description: String
    var isFound: Bool
    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var coordinateRegion: MKCoordinateRegion {
        MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
    }
}

enum Difficulty: Codable {
    case easy
    case medium
    case hard
}

enum GeoObjectCategory: Codable {
    case city
    case architecture
    case nature
}
