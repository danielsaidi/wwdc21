//
//  PackagesView.swift
//  WhatsNewInSwift
//
//  Created by Daniel Saidi on 2021-06-08.
//

import SwiftUI
import Algorithms
import Collections
import Numerics

struct PackagesView: View {
    var body: some View {
        List {
            Button("Test Collections", action: testCollections)
            Button("Test Algorithms", action: testAlgorithms)
            Button("Test Numerics", action: testNumerics)
        }.navigationTitle("Packages")
    }
}


// Swift Collections

extension PackagesView {
    
    func testCollections() {
        testDeque()
        testOrderedDictionary()
        testOrderedSet()
    }
    
    func testDeque() {
        var deque = Deque(["b", "c", "d"])
        deque.prepend("a")
        deque.append("e")
        print("Deque: \(deque)")
        _ = deque.popFirst()
        _ = deque.popLast()
        print("Deque: \(deque)")
    }
    
    func testOrderedDictionary() {
        var dict: OrderedDictionary = [200: "OK", 400: "Bad Request", 500: "Server Error"]
        dict[404] = "Not Found"
        dict[404] = "Not Found"
        print("Ordered set: \(dict)")
    }
    
    func testOrderedSet() {
        var set = OrderedSet(["b", "c", "d"])
        set.insert("a", at: 0)
        set.insert("b", at: 0)
        print("Ordered set: \(set)")
    }
}


// Swift Algorithms

extension PackagesView {
    
    func testAlgorithms() {
        let array = 0..<100
        array.chunks(ofCount: 10).forEach { print($0.first ?? -1) }
        print(array.min(count: 5))
        print(array.max(count: 5))
        print(array.randomSample(count: 5))
        print(array.uniquePermutations(ofCount: 10))
    }
}


// Swift Numerics

extension PackagesView {
    
    func testNumerics() {
        let z = Complex(0, Float16.pi)
        print(z)
        print(Complex.exp(z))
    }
}

struct PackagesView_Previews: PreviewProvider {
    static var previews: some View {
        PackagesView()
    }
}
