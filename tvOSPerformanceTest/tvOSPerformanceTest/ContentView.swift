//
//  ContentView.swift
//  tvOSPerformanceTest
//
//  Created by Daniel Saidi on 2021-06-08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(0..<20) { _ in
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<20) { index in
                                Button(action: {}) {
                                    [Color.red, Color.green, Color.orange].randomElement().frame(width: 150, height: 250)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
