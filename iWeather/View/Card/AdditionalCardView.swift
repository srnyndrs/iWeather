//
//  AdditionalCardView.swift
//  iWeather
//
//  Created by Suranyi on 25/11/2023.
//

import SwiftUI

struct AdditionalCardView: View {
    let systemName: String
    let text: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack {
            VStack {
                Spacer()
                Spacer()
                Image(systemName: systemName)
                    .font(.title)
                Spacer()
                Text(text)
                    .font(.title2)
                Spacer()
                Text(value)
                    .font(.title)
                Spacer()
                Spacer()
            }
        }
        .frame(maxWidth: 175, maxHeight: 150)
        .background(color).foregroundColor(.white)
    }
}

#Preview {
    AdditionalCardView(systemName: "wind", text: "wind", value: "5 m/s", color: Color.blue)
}
