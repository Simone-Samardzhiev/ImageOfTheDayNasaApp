//
//  DataManager.swift
//  ImageOfTheDayNasaApp
//
//  Created by Simone Samardzhiev on 21.07.24.
//

import Foundation

/// Struct that will hold the data form the response.
struct ResponseData: Decodable {
    /// The title of the image.
    let title: String
    /// The explanation of the image.
    let explanation: String
    /// The URL of the image that is send.
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case explanation
        case imageURL = "hdurl"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.explanation = try container.decode(String.self, forKey: .explanation)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
    }
}

/// Manager that will manage the data of the app.
class DataManager: ObservableObject {
    /// Variable keeping the response.
    @Published var response: ResponseData?
    /// Variable keeping the date.
    @Published var date: Date
    /// Variable holding the url.
    var urlComponents: URLComponents?
    
    /// Default initialiser.
    init() {
        self.response = nil
        self.date = Date()
        self.urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")
    }
    
    /// Method that will format and set the query items.
    private func setQueryItems() {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormater.string(from: date)
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "date", value: dateString),
            URLQueryItem(name: "api_key", value: "Rc8mcmK1Xov6YPxnRIbxnFVeey3TeCTaBAMQSFdv")
        ]
    }
    
}
