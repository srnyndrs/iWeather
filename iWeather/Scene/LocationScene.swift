//
//  LocationScene.swift
//  iWeather
//
//  Created by Suranyi on 06/11/2023.
//

import SwiftUI

struct LocationScene: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var locationHolder: LocationHolder
    
    var body: some View {
        LocationListView()
            .environment(\.managedObjectContext, viewContext)
            .environmentObject(locationHolder)
    }
}

#Preview {
    LocationScene()
}
