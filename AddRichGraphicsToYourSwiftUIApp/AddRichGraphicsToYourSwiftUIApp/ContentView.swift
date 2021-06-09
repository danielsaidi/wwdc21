//
//  ContentView.swift
//  AddRichGraphicsToYourSwiftUIApp
//
//  Created by Daniel Saidi on 2021-06-09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.yellow.ignoresSafeArea()
            List {
                ForEach(0..<50) {
                    Text("Item #\($0)")
                }
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    Text("Foo")
                    Spacer()
                    Text("Bar")
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(.thinMaterial)
            }
            TimelineView(.periodic(from: Date(), by: 5)) { timeline in
                Text("\(timeline.date)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
