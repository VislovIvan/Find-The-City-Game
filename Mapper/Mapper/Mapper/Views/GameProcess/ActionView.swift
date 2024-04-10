import SwiftUI
import MapKit

struct ActionView: View {
    @Environment (\.dismiss) var dismiss
    
    var actionViewModel: ActionViewModel
    
    var body: some View {
        ZStack {
            MapReader { proxy in
                Map(initialPosition: actionViewModel.startPosition) {
                    if let selectedPlace = actionViewModel.selectedPlace {
                        Marker("Place", coordinate: selectedPlace.coordinate)
                    }
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        actionViewModel.selectedPlace = MKMapPoint(
                            CLLocationCoordinate2D(
                                latitude: coordinate.latitude,
                                longitude: coordinate.longitude))
                    }
                }
                .mapStyle(.hybrid(elevation: .realistic))
            }
            
            VStack {
                ZStack(alignment: .topLeading) {
                    VStack {
                        Text("Find the city")
                            .padding(.top)
                        Text(LocalizedStringKey(actionViewModel.geoObject.title))
                            .font(.title)
                        Text("\(actionViewModel.timeString(time: actionViewModel.timeRemaining))")
                            .onReceive(actionViewModel.timer) { _ in
                                if actionViewModel.timeRemaining > 0 {
                                    actionViewModel.timeRemaining -= 1
                                }
                            }
                    }
                    .bold()
                    .foregroundStyle(.white)
                    .opacity(1)
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(
                            colors: [Color.black.opacity(0.7), Color.clear.opacity(0.5)],
                            startPoint: .top,
                            endPoint: .bottom)
                    )
                    
                    Button("Close") {
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .foregroundStyle(.white)
                    .tint(Color.black.opacity(0.4))
                    .controlSize(.small)
                    .overlay(
                        Capsule()
                            .stroke(Color.white.opacity(0.5), lineWidth: 0.5)
                    )
                    .padding(.horizontal)
                }
                
                Spacer()
                
                if actionViewModel.showResult == .win {
                    VStack {
                        HStack(spacing: 4) {
                            Text(LocalizedStringKey("You have found"))
                            Text(LocalizedStringKey(actionViewModel.geoObject.title))
                        }
                        .bold()
                        Text(actionViewModel.geoObject.description)
                        ForEach(actionViewModel.geoObject.facts, id: \.self) { fact in
                            Text(fact)
                        }
                        Button(action: {
                            actionViewModel.saveAndContinue()
                        }, label: {
                            SecondButtonModifier(label: "Continue")
                        })
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(.thinMaterial)
                            .shadow(radius: 10)
                    }
                } else if actionViewModel.showResult == .lose {
                    VStack {
                        Text("It is not a right place!")
                            .bold()
                        Button(action: {
                            actionViewModel.tryAgain()
                        }, label: {
                            SecondButtonModifier(label: "Try again")
                        })
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(.thinMaterial)
                            .shadow(radius: 10)
                    }
                } else if actionViewModel.showResult == .tooLate {
                    VStack {
                        Text("The time is up!")
                        Button(action: {
                            actionViewModel.newRound()
                        }, label: {
                            SecondButtonModifier(label: "Try again")
                        })
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(.thinMaterial)
                            .shadow(radius: 10)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    actionViewModel.compareSelection()
                }, label: {
                    ActionButtonView(label: ("Confirm"), textOpacity: actionViewModel.selectedPlace == nil || actionViewModel.showResult == .tooLate ? 0.2 : 1)
                })
                .disabled(actionViewModel.selectedPlace == nil || actionViewModel.showResult == .tooLate)
            }
            Spacer()
        }
    }
}
