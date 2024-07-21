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

class DataManager: ObservableObject {
    
}
