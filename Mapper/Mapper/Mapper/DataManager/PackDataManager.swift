import Foundation
import Observation

@Observable
class PackDataManager {
    var continents: [ContinentPack] {
        didSet {
            do {
                let data = try JSONEncoder().encode(continents)
                try data.write(to: continentsPath, options: [.atomic])
            } catch {
                print("Unable to save data.")
                print(error.localizedDescription)
            }
        }
    }
    
    private let continentsPath = URL.documentsDirectory.appending(path: "Continents")
    
    var currentGeoCollection: GeoCollection? {
        didSet {
            if let currentGeoCollection {
                if let continent = currentGeoCollection as? ContinentPack {
                    self.currentGeoObject = self.continents
                        .first(where: {$0.id == continent.id})?.objects
                        .filter({$0.isFound == false})
                        .randomElement()
                }
            }
        }
    }
    
    var currentGeoObject: GeoObject?
    
    init() {
        do {
            let data = try Data(contentsOf: continentsPath)
            self.continents = try JSONDecoder().decode([ContinentPack].self, from: data)
        } catch {
            print(error.localizedDescription)
            self.continents = Bundle.main.decode("Continents.json")
        }
    }
    
    func saveGeoCollectionProgress(for geoObject: GeoObject) {
        if let continent = currentGeoCollection as? ContinentPack {
            if let packIndex = self.continents.firstIndex(where: {$0.id == continent.id}) {
                if let geoObjectIndex = self.continents[packIndex].objects.firstIndex(where: {$0.id == geoObject.id}) {
                    self.continents[packIndex].objects[geoObjectIndex].isFound = true
                }
            }
        }
    }
    
    func nextGeoObject() -> GameStages {
        if let currentGeoCollection {
            if let continent = currentGeoCollection as? ContinentPack {
                self.currentGeoObject = self.continents
                    .first(where: {$0.id == continent.id})?.objects
                    .filter({$0.isFound == false})
                    .randomElement()
            }
            if self.currentGeoObject != nil {
                return .action
            } else {
                return .results
            }
        } else {
            return .results
        }
    }
}

enum MainStages {
    case menu, game
}
