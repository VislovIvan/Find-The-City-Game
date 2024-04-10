import Foundation
import GameKit

func authenticateUser() {
    GKLocalPlayer.local.authenticateHandler = { _, error in
        guard error == nil else {
            print(error?.localizedDescription ?? "")
            return
        }
    }
}
