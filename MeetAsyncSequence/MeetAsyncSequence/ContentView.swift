//
//  ContentView.swift
//  MeetAsyncSequence
//
//  Created by Daniel Saidi on 2021-06-10.
//

import SwiftUI

struct LikeEmit {
    
    let numberOfLikes: Int
}

class LikesMonitor {
    
    private var timer: Timer?
    
    var likesHandler: (LikeEmit) -> Void = { _ in }
    
    func startMonitoring() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let likes = Int.random(in: 1..<100)
            let emit = LikeEmit(numberOfLikes: likes)
            self.likesHandler(emit)
        }
    }
    
    func stopMonitoring() {
        timer?.invalidate()
        timer = nil
    }
}

class LikesStream {
    
    private init() {}
    
    + AsyncThrowingStream
    
    static let shared = AsyncStream(LikeEmit.self) { cont in
        let monitor = LikesMonitor()
        monitor.likesHandler = { emit in
            cont.yield(emit)
        }
        cont.onTermination = { _ in
            monitor.stopMonitoring()
        }
        monitor.startMonitoring()
    }
}

struct ContentView: View {
    
    @State private var likes = [LikeEmit]()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
