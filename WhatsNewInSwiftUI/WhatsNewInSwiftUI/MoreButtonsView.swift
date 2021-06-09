//
//  MoreButtonsView.swift
//  WhatsNewInSwiftUI
//
//  Created by Daniel Saidi on 2021-06-09.
//

import SwiftUI

struct MoreButtonsView: View {
    
    @State private var isOn = false
    
    var body: some View {
        List {
            Button("Add") {}
                .buttonStyle(.bordered)
                .tint(.green)
            
            Button("Add") {}
                .buttonStyle(.bordered)
                .tint(.mint)
                .controlSize(.large)
            
            Button("Add") {}
                .buttonStyle(.bordered)
                .tint(.indigo)
                .controlProminence(.increased)
                .keyboardShortcut(.defaultAction)
            
            Menu("Add") {
                ForEach(1..<5) { jar in
                  Button("Add to jar #\(jar)") {
                     print(jar)
                  }.buttonStyle(.bordered)
               }
            } primaryAction: {
                print("Default")
            }
            .menuStyle(.automatic)  // More on macOS
            .menuIndicator(.hidden)
            .scenePadding()
            .buttonStyle(.bordered)
            .tint(.teal)
            
            Toggle(isOn: $isOn) {
                Label("Do it", systemImage: "globe")
            }
            .toggleStyle(.button)
            .tint(.teal)
        }
        .navigationTitle("More Buttons")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                ControlGroup {
                    Button("1") {}
                    Button("2") {}
                }
                ControlGroup {
                    Button("1") {}
                    Button("2") {}
                }
            }
            
            
        }
    }
}

struct MoreButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreButtonsView()
    }
}
