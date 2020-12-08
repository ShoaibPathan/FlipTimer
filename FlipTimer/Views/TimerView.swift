import SwiftUI
import AVFoundation

struct TimerView: View {
    @State private var showSettingsView = false

    @StateObject var viewModel = TimerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(viewModel.timeLeft)")
                    .font(.system(size: 96, weight: .regular, design: .monospaced))
                    .padding(.bottom, 30)
                    .minimumScaleFactor(0.5)
                
                VStack {
                    if viewModel.timerMode == .initial {
                        Text("Flip your phone to start the timer")
                            .foregroundColor(Color(UIColor.systemGray))
                    }

                    if viewModel.timerMode == .paused {
                        Button(
                            action: {
                                viewModel.stop()
                            },
                            label: {
                                HStack {
                                    Spacer()
                                    Text("Stop").foregroundColor(.white)
                                    Spacer()
                                }
                                .padding()
                                .background(Color.accentColor)
                                .cornerRadius(12)
                            }
                        )
                    }
                }.padding(.horizontal)

                Spacer().frame(maxHeight: 200)
            }
            .padding()
            .navigationBarItems(
                trailing: Button(
                    action: { showSettingsView.toggle() },
                    label: { Image(systemName: "gearshape.fill").imageScale(.large) }
                )
            )
        }
        .sheet(isPresented: $showSettingsView, content: {
            SettingsView(showSettingsView: $showSettingsView)
        })
        .onAppear(perform: {
            print("onAppear")

            viewModel.activateProximitySensor()
        })
        .onDisappear(perform: {
            print("onDisappear")

            viewModel.deactivateProximitySensor()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimerView()
        }
    }
}
