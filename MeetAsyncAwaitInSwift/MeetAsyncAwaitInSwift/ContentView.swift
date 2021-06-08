//
//  ContentView.swift
//  MeetAsyncAwaitInSwift
//
//  Created by Daniel Saidi on 2021-06-08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}



// UIImage

private extension ContentView {
    
    enum MyError: Error {
        case badResponse
        case badThumbnail
    }
    
    func loadThumbnail() async throws -> UIImage {
        let request = URLRequest(url: URL(string: "")!)
        let result = try await URLSession.shared.data(for: request)
        guard let response = result.1 as? HTTPURLResponse else { throw MyError.badResponse }
        guard response.statusCode == 200 else { throw MyError.badResponse }
        let image = UIImage(data: result.0)
        guard let thumbnail = await image?.thumbnail else { throw MyError.badThumbnail }
        return thumbnail
    }
    
    func otherWays() async {
        await withCheckedContinuation { $0.resume() }       // Call async methods inside
        do {
            try await withCheckedThrowingContinuation {     // Call throwing async methods inside
                $0.resume()
            }
        } catch {}
        // You can also store the continuation if you use delegates
    }
}

extension UIImage {
    
    var thumbnail: UIImage? {
        get async {
            let size = CGSize(width: 100, height: 100)
            return await byPreparingThumbnail(ofSize: size)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
