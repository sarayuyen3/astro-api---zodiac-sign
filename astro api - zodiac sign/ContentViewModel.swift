//
//  ContentViewModel.swift
//  astro api - zodiac sign
//
//  Created by Sarayu Yenumula on 1/18/23.
//

import Foundation
import Combine //process values over time

class ContentViewModel: ObservableObject { //classes are observed for changes by SwiftUI view
    @Published var day = ""
    @Published var prediction = ""
    @Published var errorMessage = ""
    @Published var apiUrl = "https://aztro.sameerkumar.website?sign="
    @Published var apiDayUrl = "&day="
    @Published var horoscope = "Aries"
    
    //published variables that change as the view changes

    
    func getPrediction() {
        let url = apiUrl + horoscope + apiDayUrl + day
        var request = URLRequest(url: URL(string: url)!) //creates a new URLRequest object using URL string passed in url variable
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in //fetches data from the specified URL
            if let data = data { //optional binding statement and checks if not nil
                do {
                    let json = try JSONDecoder().decode(Prediction.self, from: data) //uses JSONDecoder class to convert data into Prediction obj
                    DispatchQueue.main.async { //runs the code
                        self.prediction = "Your prediction for " + json.current_date + ":\n" + json.description + "\n \n Your color: " + json.color + "\n Your sign compatibility: " + json.compatibility + "\n Your mood: " + json.mood + "\n Your lucky time: " + json.lucky_time
                    }
                } catch { //handles errors
                    print("Please enter a value!")
                }
            }
        }.resume() //starts the data task
    }
}

struct Prediction: Codable { //Codable allows class to be encoded and decoded by JSONEncoder and Decoder classes
    let description: String
    let color: String
    let compatibility: String
    let mood: String
    let lucky_time: String
    let current_date: String
}
