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
                Image(systemName: systemName)
                    .font(.title)
                Text(text)
                    .font(.title3)
                HStack {
                    Text(value)
                        .font(.title)
                }.padding(2)
            }.padding()
        }
        .frame(width: 120, height: 150)
        .foregroundColor(.white).background(color)
    }
}

#Preview {
    AdditionalCardView(systemName: "wind", text: "wind", value: "5 m/s", color: Color.blue)
}
