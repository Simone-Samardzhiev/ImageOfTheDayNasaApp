//
//  ImageView.swift
//  ImageOfTheDayNasaApp
//
//  Created by Simone Samardzhiev on 21.07.24.
//

import SwiftUI


struct ImageView: View {
    /// The manager of the data downloaded from NASA.
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        if let response = dataManager.response {
            VStack {
                Text(response.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                AsyncImage(url: URL(string: response.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
}
