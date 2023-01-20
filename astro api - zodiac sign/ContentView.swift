//
//  ContentView.swift
//  astro api - zodiac sign
//
//  Created by Sarayu Yenumula on 1/17/23.
//


import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.white, .yellow, .purple]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Text("Your Prediction ✨")
                    .font(.largeTitle)
                    .bold()
                Text("Find out your future prediction based on your sign!")
                    .font(.headline)
                    .padding()
                
                buttonView //button view for today, tomorrow, or yesterday
                
                let sign = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio", "Sagittarius", "Capricornus", "Aquarius", "Pisces"  ]
                VStack {
                    Picker("Please choose your sign", selection: $viewModel.horoscope) {
                        ForEach(sign, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Button(action: {
                    self.viewModel.getPrediction()
                }) {
                    Text("Get Prediction")
                }
                .buttonStyle(.borderedProminent)
                .tint(.purple)
                Text(viewModel.prediction)
                    .padding()
                Spacer()
            }
        }
        .environmentObject(viewModel)
    }
    
    
    private var buttonView: some View {
        HStack{
            
            Button(action: {
                viewModel.day = "Yesterday"
            }) {
                Text("Yesterday")
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)
            
            Button(action: {
                viewModel.day = "Today"
            }) {
                Text("Today")
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)
            
            Button(action: {
                viewModel.day = "Tomorrow"
            })
            {
                Text("Tomorrow")
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)
            
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
}
