//
//  MainView.swift
//  ImageOfTheDayNasaApp
//
//  Created by Simone Samardzhiev on 21.07.24.
//

import SwiftUI

/// The main view of the app.
struct MainView: View {
    /// The manager of the data downloaded from NASA.
    @StateObject var dataManager = DataManager()
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ImageDatePicker(width: geo.size.width / 1.2)
            }
            .environmentObject(dataManager)
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    MainView()
}
