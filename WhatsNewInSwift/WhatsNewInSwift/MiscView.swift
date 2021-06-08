//
//  MiscView.swift
//  WhatsNewInSwift
//
//  Created by Daniel Saidi on 2021-06-08.
//

import SwiftUI

struct MiscView: View {
    
    @State var values = [0, 1, 2]
    
    var body: some View {
        VStack {
            List {
                Button("Flexible Static Member Lookup", action: testFlexibleStaticMemberLookup)
                Button("Property Wrappers", action: testPropertyWrappers)
                Button("Formatting", action: testFormatting)
                
            }
            List($values) { $val in
                Text("Value \(val)")
            }
        }
        .navigationTitle("Misc. Improvements")
    }
}

extension Int: Identifiable {
    
    public var id: Int { self}
}


// Flexible Static Member Lookup

private protocol Coffee {
    var name: String { get }
}

private struct Latte: Coffee {
    var name: String { "Latte" }
}

private extension MiscView {
    
    func brew<CoffeeType: Coffee>(_ type: CoffeeType) {
        print(type.name)
    }
    
    func testFlexibleStaticMemberLookup() {
        brew(.latte)
    }
}

extension Coffee where Self == Latte {
    static var latte: Latte { Latte() }
}


// Property Wrappers

@propertyWrapper
struct NonEmpty<Value: Collection> {
    
    init(wrappedValue: Value) {
        precondition(!wrappedValue.isEmpty)
        self.wrappedValue = wrappedValue
    }
    
    var wrappedValue: Value {
        willSet { precondition(!newValue.isEmpty) }
    }
}

private extension MiscView {
    
    func testPropertyWrappers() {
        testNonEmpty("Non-empty")
        testNonEmpty("")
    }
    
    func testNonEmpty(@NonEmpty _ value: String) {
        print("\(value) is not empty 👍")
    }
}


// Formatting

private extension MiscView {
    
    func testFormatting() {
        print(Date().formatted(date: .abbreviated, time: .omitted))
        print(Date().formatted(date: .complete, time: .shortened))
    }
}


struct MiscView_Previews: PreviewProvider {
    static var previews: some View {
        MiscView()
    }
}
