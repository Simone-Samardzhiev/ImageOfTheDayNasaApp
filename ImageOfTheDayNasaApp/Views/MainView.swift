//
//  MainView.swift
//  ImageOfTheDayNasaApp
//
//  Created by Simone Samardzhiev on 21.07.24.
//

import SwiftUI

/// The main view of the app.
struct MainView: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    MainView()
}
