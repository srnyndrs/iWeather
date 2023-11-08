//
//  FloatingButton.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import SwiftUI

struct FloatingButton: View {
    @EnvironmentObject var locationHolder: LocationHolder
    var body: some View {
        Spacer()
        HStack {
            NavigationLink(destination: LocationEditView(passedLocation: nil).environmentObject(locationHolder))
            {
                Text("New location")
                    .font(.headline)
            }
            .padding(15)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(30)
            .padding(30)
            .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
        }

    }
}

#Preview {
    FloatingButton()
}
