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
            LazyVStack {
                ForEach(0..<100) { _ in
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(0..<100) { index in
                                Button("\(index)") {
                                    print(index)
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
