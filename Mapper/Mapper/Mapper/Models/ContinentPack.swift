import Foundation
import MapKit

enum Continents: String, Codable, Hashable {
    case asia = "Asia",
         africa = "Africa",
         northAmerica = "North America",
         southAmerica = "South America",
         antarctica = "Antarctica",
         europe = "Europe",
         australiaOceania = "Australia and Oceania"
}

struct ContinentPack: Identifiable, GeoCollection, Equatable, Codable {
    var id: String
    let title: String
    let continent: Continents
    let latitude: Double
    let longitude: Double
    var objects: [GeoObject]
    
    var titleCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(continent: Continents, titleLatitude: Double, titleLongitude: Double, objects: [GeoObject] = []) {
        self.id = continent.rawValue
        self.title = continent.rawValue
        self.continent = continent
        self.latitude = titleLatitude
        self.longitude = titleLongitude
        self.objects = objects
    }
    
    static let sample = [
        ContinentPack(continent: .africa, titleLatitude: 10.0, titleLongitude: 20.0),
        ContinentPack(continent: .europe, titleLatitude: 50.0, titleLongitude: 20.0),
        ContinentPack(
            continent: .northAmerica,
            titleLatitude: 45.0,
            titleLongitude: -100.0,
            objects: [
                GeoObject(
                    id: "New York",
                    title: "New York City",
                    category: .city,
                    facts: [],
                    latitude: 40.7128,
                    longitude: -74.0060,
                    description: "",
                    isFound: false),
                GeoObject(
                    id: "Los Angeles",
                    title: "Los Angeles",
                    category: .city,
                    facts: [],
                    latitude: 34.0522,
                    longitude: -118.2437,
                    description: "",
                    isFound: false),
                GeoObject(
                    id: "Chicago",
                    title: "Chicago",
                    category: .city,
                    facts: [],
                    latitude: 41.8781,
                    longitude: -87.6298,
                    description: "",
                    isFound: false),
                GeoObject(
                    id: "Houston",
                    title: "Houston",
                    category: .city,
                    facts: [],
                    latitude: 29.7604,
                    longitude: -95.3698,
                    description: "",
                    isFound: false),
                GeoObject(
                    id: "Phoenix",
                    title: "Phoenix",
                    category: .city,
                    facts: [],
                    latitude: 33.4484,
                    longitude: -112.0740,
                    description: "",
                    isFound: false)
            ]),
        ContinentPack(continent: .southAmerica, titleLatitude: -13.0, titleLongitude: -55.0)
    ]
    
    static func == (lhs: ContinentPack, rhs: ContinentPack) -> Bool {
        lhs.id == rhs.id
    }
}
