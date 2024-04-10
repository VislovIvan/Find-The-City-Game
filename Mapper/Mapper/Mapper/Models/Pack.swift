import Foundation
import MapKit

struct Pack: GeoCollection, Identifiable, Codable {
    var latitude: Double
    var longitude: Double
    var id = UUID().uuidString
    let title: String
    var description: String = ""
    var difficulty: Difficulty
    var objects: [GeoObject]
    var imageURL: String
}
