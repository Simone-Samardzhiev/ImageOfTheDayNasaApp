//
//  GetImageButton.swift
//  ImageOfTheDayNasaApp
//
//  Created by Simone Samardzhiev on 21.07.24.
//

import SwiftUI


/// Button used to get the image form NASA.
struct GetImageButton: View {
    /// The manager of the data downloaded from NASA.
    @EnvironmentObject var dataManager: DataManager
    /// The width of the button.
    let width: CGFloat
    /// The height  of the button.
    let height: CGFloat
    
    /// Initializer of the GetImageButton.
    /// - Parameters:
    ///   - width: The width of the button.
    ///   - height: The height of the button.
    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
    
    var body: some View {
        Button {
            
        } label: {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.blue)
                .frame(width: width, height: height)
                .overlay(alignment: .center) {
                    Text("Get the image")
                        .foregroundStyle(Color.primary)
                        .font(Font.system(size: height / 1.5))
                }
        }

    }
}
