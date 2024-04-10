import SwiftUI
import MapKit

struct ObjectType: Hashable {
    let typeName: String
    var isActive: Bool
}

struct ContinentPackView: View {
    @State var gameStarted = false
    @Environment (PackDataManager.self) var packDataManager
    @Binding var isPackSelected: Bool

    var continentPack: ContinentPack
    var progress: Double    
    
    let typesOfObjects = [
        ObjectType(typeName: "Cities", isActive: true),
        ObjectType(typeName: "Nature (Soon)", isActive: false)
    ]
    
    var body: some View {
        ZStack {
            Color(.black.opacity(0.6))
                .ignoresSafeArea()
            VStack {
                Spacer()
                CircularProgressView(currentPercentage: progress)
                    .scaleEffect(CGSize(width: 0.7, height: 0.7))
                Text(LocalizedStringKey(continentPack.title))
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                Spacer()
                ForEach(typesOfObjects, id: \.self) { type in
                    Button(action: {
                        
                    }, label: {
                        Text(LocalizedStringKey(type.typeName))
                            .font(.title)
                            .opacity(type.isActive ? 1 : 0.3)
                            .bold()
                            .frame(width: 250)
                            .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing:0))
                            .foregroundStyle(.white)
                            .background(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color("ButtonGray").opacity(0.1))
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color(.white).opacity(0.2))
                                })
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(LinearGradient(colors: [.white.opacity(0.5), .clear], startPoint: .top, endPoint: .bottom), lineWidth: 2)
                            )
                    })
                    .disabled(true)
                }
                Spacer()
                Button(action: {
                    packDataManager.currentGeoCollection = packDataManager.continents.first(where: {
                        $0.continent == continentPack.continent
                    })
                    gameStarted = true
                }, label: {
                    ActionButtonView(label: "Start Game", textOpacity: 1)
                })
                Button(action: {
                    isPackSelected = false
                }, label: {
                    ActionButtonView(label: "Close", textOpacity: 1)
                })
                Spacer()
            }
            
            .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $gameStarted, content: {
            if let geoCollection = packDataManager.currentGeoCollection {
                if let geoObject = packDataManager.currentGeoObject {
                    ActionView(actionViewModel: ActionViewModel(
                        geoCollection: geoCollection,
                        geoObject: geoObject,
                        startPosition: geoCollection.startPosition,
                        findAndSaveObject: packDataManager.saveGeoCollectionProgress,
                        nextGeoObject: packDataManager.nextGeoObject))
                } else {
                    Text("ok")
                }
            }
        })
    }
}
