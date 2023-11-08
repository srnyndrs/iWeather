//
//  LocationDetailsView.swift
//  iWeather
//
//  Created by Suranyi on 04/11/2023.
//

import SwiftUI
import MapKit

struct LocationDetailsView: View {
    @Binding var selection: MKMapItem?
    @Binding var show: Bool
    var body: some View {
        VStack {
            HStack{
                VStack(alignment: .leading){
                    Text(selection?.placemark.name ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(selection?.placemark.title ?? "")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .padding(.trailing)
                }
                Spacer()
                Button {
                    show.toggle()
                    selection = nil
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24,height: 24)
                        .foregroundStyle(.gray, Color(.systemGray6))
                }
            }
        }
    }
}

#Preview {
    LocationDetailsView(selection: .constant(MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: Constants.defaultLocation.latitude, longitude: Constants.defaultLocation.longitude)))), show: .constant(false))
}