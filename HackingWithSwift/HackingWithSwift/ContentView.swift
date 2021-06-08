//
//  ContentView.swift
//  HackingWithSwift
//
//  Created by Daniel Saidi on 2021-06-08.
//

import SwiftUI

struct ContentView: View {
    
    enum FocusedField {
       case first, last
    }
    
    @State private var data = [String]()
    @State private var date = Date()
    @State private var query = ""
    @State private var text1 = ""
    @State private var text2 = ""
    
    @State private var isAlertActive = false
    @State private var isConfirmationDialogActive = false
    
    @FocusState private var focusedField: FocusedField?
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("First input", text: $text1)
                        .submitLabel(.next)
                        .textContentType(.URL)
                        .focused($focusedField, equals: .first)
                    TextField("Second input", text: $text2)
                        .submitLabel(.done)
                        .textContentType(.addressCity)
                        .focused($focusedField, equals: .last)
                    
                    resultList
                    asyncImage
                    markdown
                    alertButton
                    confirmationButton
                    menuButton
                } footer: {
                    Text("\(date)")
                }
            }
            .navigationTitle("Hacking w. Swift")
            .listStyle(.insetGrouped)
            .refreshable(action: refresh)
            .searchable("Query", text: $query) {
                ForEach(["a", "b", "c"], id: \.self) {
                    Color.red
                        .frame(width: 100, height: 50)
                        .cornerRadius(10)
                        .overlay(Label($0, systemImage: "globe").searchCompletion($0))
                }
            }
            .onReceive(timer) { _ in date = Date() }
            .onChange(of: query, perform: search)
            .onSubmit {     // Does not work in List or Form
                switch focusedField {
                case .first: focusedField = .last
                case .last: focusedField = nil
                case .none: break
                }
            }
            .alert("Actions!", isPresented: $isAlertActive) { menuOptions }
            .confirmationDialog("Options!", isPresented: $isConfirmationDialogActive) { menuOptions  }
        }.interactiveDismissDisabled()
    }
}

private extension ContentView {
    
    var alertButton: some View {
        Button("Show alert") {
            isAlertActive = true
        }
    }
    
    var asyncImage: some View {
        AsyncImage(url: URL(string: "https://lorempixel.com/400/400")!) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Color.red
        }
        .frame(width: 200, height: 200)
        .clipShape(Circle())
        .overlay(asyncImageOverlay)
        .foregroundStyle(.linearGradient(colors: [.red, .black], startPoint: .top, endPoint: .bottom))
    }
    
    var asyncImageOverlay: some View {
        VStack {
            Text("Title")
                .font(.title)
            Text("Subtitle")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Material.ultraThin)
        .cornerRadius(10)
    }
    
    var confirmationButton: some View {
        Button("Show confirmation dialog") {
            isConfirmationDialogActive = true
        }
    }
    
    var markdown: some View {
        Text("""
        Oh my *God*, Markdown support!
        Does [this link](https://danielsaidi.com) work?
        """)
    }
    
    var menuButton: some View {
        Menu("Menu") {
            menuOptions
        } primaryAction: {
            print("Quick")
        }
    }
    
    @ViewBuilder
    var menuOptions: some View {
        Button(action: {}) {
            Label("Refresh", systemImage: "globe")
        }
        Button("Print") { print("Hello, you!") }
        Button("Delete", role: .destructive) { print("Deleted something") }
        Button("Cancel", role: .cancel) {}
    }
    
    var resultList: some View {
        ForEach(data, id: \.self) { item in
            Text(item)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button("Add") { print("Print1 - \(item)") }
                    Button("Remove", role: .destructive) { print("Print2 - \(item)") }
                }
        }
    }
}

private extension ContentView {
    
    func refresh() async {
        data = await simulateFetchingData()
    }
    
    func search(_ query: String) {
        data = ["Searched", "for", query]
    }
    
    func simulateFetchingData() async -> [String] {
        return await withCheckedContinuation { cont in
            print("Refreshing")
            DispatchQueue.global(qos: .userInitiated).async {
                Thread.sleep(forTimeInterval: 2)
                cont.resume(returning: ["Fake", "data", "loaded"])
                print("Refreshed")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
