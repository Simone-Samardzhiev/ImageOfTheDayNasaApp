//
//  DataManager.swift
//  ImageOfTheDayNasaApp
//
//  Created by Simone Samardzhiev on 21.07.24.
//

import Foundation
import Combine

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
    /// Variable keeping the cancellable.
    private var cancellable: Set<AnyCancellable>
    
    /// Default initialiser.
    init() {
        self.response = nil
        self.date = Date()
        self.urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")
        self.cancellable = Set<AnyCancellable>()
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
    
    /// Method that will get the response.
    private func getResponse() {
        guard let url = urlComponents?.url else {
            return
        }
        
        setQueryItems()
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleData)
            .decode(type: ResponseData.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] responseData in
                self?.response = responseData
            }
            .store(in: &cancellable)

    }
    
    /// Method that will handle the data form the subscriber.
    /// - Parameter output: The output of the subscriber.
    /// - Returns: The data.
    private func handleData(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let httpResponse = output.response as? HTTPURLResponse,
            httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        
        return output.data
    }
}
