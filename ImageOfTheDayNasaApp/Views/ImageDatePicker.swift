//
//  ImageDatePicker.swift
//  ImageOfTheDayNasaApp
//
//  Created by Simone Samardzhiev on 21.07.24.
//

import SwiftUI


/// DatePicker used to select from which date the image should be shown.
struct ImageDatePicker: View {
    /// The manager of the data downloaded from NASA.
    @EnvironmentObject var dataManager: DataManager
    /// The date when the first photo was send.
    var startDate: Date {
        var components = DateComponents()
        components.day = 16
        components.month = 6
        components.year = 1995
        return Calendar.current.date(from: components)!
    }
    /// The width of the date picker.
    let width: CGFloat
    
    init(width: CGFloat) {
        self.width = width
    }
    
    var body: some View {
        DatePicker("Select a date:", selection: $dataManager.date, in: startDate...Date(), displayedComponents: [.date])
            .frame(width: width)
    }
}
