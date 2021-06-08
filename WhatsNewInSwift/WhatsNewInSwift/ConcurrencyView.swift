//
//  ConcurrencyView.swift
//  WhatsNewInSwift
//
//  Created by Daniel Saidi on 2021-06-08.
//

import SwiftUI

struct ConcurrencyView: View {
    
    @State private var date = Date()
    @State private var image = AnyView(Image(""))
    
    private let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        List {
            Section {
                Button("Test Async/Await", action: testAwait)
                Button("Test Serial Execution", action: testSerialExecution)
                Button("Test Parallel Execution", action: testParallelExecution)
            } footer: {
                Text("\(date)")
            }
            image
        }
        .navigationTitle("Concurrency")
        .onReceive(timer) { _ in date = Date() }
    }
}

private extension ConcurrencyView {
    
    func testAwait() {
        async {
            await testAwaitAsync()
        }
    }
    
    func testAwaitAsync() async {
        guard let url = URL(string: "https://www.aftonbladet.se") else { return }
        let request = URLRequest(url: url)
        do {
            let result = try await URLSession.shared.data(for: request)
            let string = String(data: result.0, encoding: .utf8)
            print(string?.prefix(100) ?? "-")
        } catch {}
    }
    
    func testSerialExecution() {
        async {
            let image1 = await getImage(400)
            let image2 = await getImage(300)
            let image3 = await getImage(200)
            let image4 = await getImage(100)
            await updateImage(VStack {
                image1
                image2
                image3
                image4
            })
            print("DONE")
        }
    }
    
    func testParallelExecution() {
        async {
            await testParallelExecutionAsync()
        }
    }
    
    func testParallelExecutionAsync() async {
        async let _ = await getImage(400)
        async let _ = await getImage(300)
        async let _ = await getImage(200)
        async let _ = await getImage(100)
        // How to??
//        await updateImage(VStack {
//            image1
//            image2
//            image3
//            image4
//        })
        print("DONE")
    }
    
    func getImage(_ size: CGFloat) async -> Image {
        guard let url = URL(string: "http://lorempixel.com/\(size)/\(size)/") else { return Image("") }
        let request = URLRequest(url: url)
        do {
            let result = try await URLSession.shared.data(for: request)
            let image = UIImage(data: result.0)
            return Image(uiImage: image ?? UIImage())
        } catch {
            return Image("")
        }
    }
    
    @MainActor
    func updateImage<Stack: View>(_ image: Stack) {
        self.image = AnyView(image)
    }
    
}

struct ConcurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        ConcurrencyView()
    }
}
