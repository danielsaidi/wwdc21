//
//  ContentView.swift
//  WhatsNewInSwift
//
//  Created by Daniel Saidi on 2021-06-08.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Packages", destination: PackagesView())
                NavigationLink("Concurrency", destination: ConcurrencyView())
                NavigationLink("Misc. Improvements", destination: MiscView())
            }
            .navigationTitle("What's new in Swift")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
