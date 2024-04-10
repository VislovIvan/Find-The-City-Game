import SwiftUI

@main
struct MapperApp: App {
	var mainVM = PackDataManager()

    var body: some Scene {
        WindowGroup {
			SinglePlayerMenuView()
				.environment(mainVM)
        }
    }
}
