//
//  ContentView.swift
//  WhatsNewInWatchOS8 WatchKit Extension
//
//  Created by Daniel Saidi on 2021-06-09.
//

import SwiftUI
import CoreLocationUI

struct ContentView: View {
    
    @Environment(\.isLuminanceReduced) private var isLuminanceReduced
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Bright in Always On")
                Text("Dimmed in Always On")
                    .opacity(isLuminanceReduced ?  0.5 : 1)
                Text("Redacted in Always On")
                    .isRedacted(isLuminanceReduced)
                
                LocationButton(.currentLocation) {
                    // Do something
                }
                .foregroundColor(.white)
                .labelStyle(.iconOnly)
                .symbolVariant(.fill)
                .tint(.blue)
                .frame(width: 50, height: 50)
                .cornerRadius(25)
                .shadow(color: .white, radius: 1, x: 0, y: 3)
                
            }.padding()
        }
    }
}

public extension View {
    
    @ViewBuilder
    func isRedacted(_ value: Bool) -> some View {
        if value {
            self.redacted(reason: .placeholder)
        } else {
            self
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.isLuminanceReduced, false)
        ContentView().environment(\.isLuminanceReduced, true)
    }
}
