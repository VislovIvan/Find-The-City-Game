import Foundation
import SwiftUI
import Observation
import MapKit

@Observable
class ActionViewModel {
	var gameStage: GameStages = .action
	var geoObject: GeoObject
	var findAndSaveObject: (GeoObject) -> Void
	var nextGeoObject: () -> GameStages
	var startPosition: MapCameraPosition
	var selectedPlace: MKMapPoint?
	var showResult: ShowResultOfGame? = nil
    
	var timeRemaining = 30 {
		didSet {
			if  timeRemaining == 0 {
				showResult = .tooLate
				}
			}
		}
    
	var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
	enum ShowResultOfGame {
		case win
		case lose
		case tooLate
	}

	init(
		geoCollection: GeoCollection,
		geoObject: GeoObject,
		startPosition: MapCameraPosition,
		findAndSaveObject: @escaping (GeoObject) -> Void,
		nextGeoObject: @escaping () -> GameStages) {
			self.geoObject = geoObject
			self.findAndSaveObject = findAndSaveObject
			self.startPosition = startPosition
			self.nextGeoObject = nextGeoObject
		}
	
	func compareSelection() {
		let center = geoObject.coordinates
		if let selectedPlace {
			let distance = selectedPlace.distance(to: MKMapPoint(center))
			if distance <= 50000.0 {
				print("\(geoObject.title) is guessed!")
				self.showResult = .win
				timer.upstream.connect().cancel()
			} else {
				print("You are wrong. Distance is \(distance)")
				self.showResult = .lose
			}
		}
	}

	func saveAndContinue() {
		self.findAndSaveObject(geoObject)
		self.gameStage = self.nextGeoObject()
		self.showResult = nil
	}
	
	func tryAgain() {
		self.showResult = nil
	}
	
	func newRound() {
		self.showResult = nil
		self.timeRemaining = 10
	}
	
	func timeString(time: Int) -> String {
			let formatter = DateComponentsFormatter()
			formatter.allowedUnits = [.minute, .second]
			formatter.unitsStyle = .positional
			formatter.zeroFormattingBehavior = .pad
			return formatter.string(from: TimeInterval(time)) ?? "00:00"
		}

	//	func saveResult() {
	//		print("Saved")
	//		if let geoObject {
	//			findAndSaveObject(geoObject)
	//			if let index = self.geoCollection.objects.firstIndex(where: {$0.id == geoObject.id}) {
	//				print("CERF")
	//				self.geoCollection.objects[index].isFound = true
	//			}
	//
	//			self.showResult = false
	//			self.geoObject = self.geoCollection.objects.filter({$0.isFound == false}).randomElement()
	//		}
	//	}
}

enum ActionStages: Int, CaseIterable {
	case challenge = 0, exploration, result
}

enum GameStages: Int, CaseIterable {
 case action = 0, results
}
