//
//  AdditionalInfoView.swift
//  iWeather
//
//  Created by Suranyi on 24/11/2023.
//

import SwiftUI

struct AdditionalInfoView: View {
    var wind: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "wind")
                    .font(.title)
                Text(wind)
                    .font(.title)
            }
        }
    }
}

#Preview {
    AdditionalInfoView(wind: "5")
}
