//
//  ContentView.swift
//  ExploreStructuredConcurrencyInSwift
//
//  Created by Daniel Saidi on 2021-06-11.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sequentialImages: [Image] = []
    @State private var concurrentImages: [Image] = []
    @State private var taskGroupImages: [Image] = []
    
    private let urlSession = URLSession.shared
    
    var body: some View {
        VStack {
            imageList("sequential", for: sequentialImages)
            imageList("concurrent", for: concurrentImages)
            imageList("taskGroup", for: taskGroupImages)
        }.task { try? await fetchImages() }
    }
}

extension ContentView {
    
    func imageList(_ title: String, for images: [Image]) -> some View {
        VStack {
            HStack {
                Text(title).font(.footnote)
                Spacer()
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(images.enumerated()), id: \.offset) {
                        imageListItem(for: $0.element)
                    }
                }
            }
        }
    }
    
    func imageListItem(for image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50)
    }
}

enum TestError: Error {
    
    case cancelled
    case invalidImage
}

extension ContentView {
    
    func fetchImages() async throws {
        // Or, you can use async {
        try await withThrowingTaskGroup(of: Image.self) { group in
            // Async let will allow them to run in parallel instead of awaiting on each row
            async let sequentialImages = fetchImagesSequentially(10)
            async let concurrentImages = fetchImagesConcurrently(10)
            async let taskGroupImages = fetchImagesWithTaskGroup(10)
            self.sequentialImages = try await sequentialImages
            self.concurrentImages = try await concurrentImages
            self.taskGroupImages = try await taskGroupImages
        }
    }
    
    func fetchImagesSequentially(_ count: Int) async throws -> [Image] {
        print("fetchImagesSequentially started")
        var images = [Image]()
        for index in 0...count {
            let image = try await fetchImage(at: index)
            images.append(image)
        }
        print("fetchImagesSequentially ended")
        return images
    }
    
    func fetchImagesConcurrently(_ count: Int) async throws -> [Image] {
        print("fetchImagesConcurrently started")
        var images = [Image]()
        for index in 0...count {
            if Task.isCancelled { throw(TestError.cancelled) }  // Can check bool
            try Task.checkCancellation()                        // Will throw if the task is cancelled
            images.append(try await fetchImage(at: index))
        }
        print("fetchImagesConcurrently ended")
        return images
    }
    
    func fetchImagesWithTaskGroup(_ count: Int) async throws -> [Image] {
        print("fetchImagesWithTaskGroup started")
        var images = [Image]()
        try await withThrowingTaskGroup(of: Image.self) { group in
            for index in 0...count {
                group.async {
                    return try await fetchImage(at: index)
                }
            }
            for try await image in group {
                images.append(image)
            }
        }
        print("fetchImagesWithTaskGroup ended")
        return images
    }
    
    func fetchImage(at index: Int) async throws -> Image {
        let req = URLRequest(url: fetchImageUrl(at: index))
        let result = try await urlSession.data(for: req)
        asyncDetached(priority: .background) {
            await withTaskGroup(of: Void.self) { group in
                group.async { print("1) Detached print that can happen at random") }
                group.async { print("2) Detached print that can happen at random") }
            }
        }
        guard let image = UIImage(data: result.0) else { throw(TestError.invalidImage) }
        return Image(uiImage: image)
    }
    
    func fetchImageUrl(at index: Int) -> URL {
        let size = Int.random(in: 150...500)
        return URL(string: "http://lorempixel.com/\(size)/\(size)/")!
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
