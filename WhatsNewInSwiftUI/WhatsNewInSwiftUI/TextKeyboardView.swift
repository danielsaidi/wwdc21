//
//  TextKeyboardView.swift
//  WhatsNewInSwiftUI
//
//  Created by Daniel Saidi on 2021-06-09.
//

import SwiftUI

struct TextKeyboardView: View {
    
    @FocusState private var isFocused: Bool
    
    @State private var newPerson = PersonNameComponents()
    
    @State private var persons = [
        Person(name: "Tim Cook"),
        Person(name: "Dr. Tom Chef"),
        Person(name: "Mr. Tam Boss")]
    
    var body: some View {
        List {
            attributedText
            rainbowText
            personList
            personListAdder
            focusButton
        }
        .navigationTitle("Text & Keyboard")
#if os(macOS)
    .textSelection(.enabled)
#endif
    }
}

private struct Person {
    
    let name: String
    
    var nameComponents: PersonNameComponents {
        try! PersonNameComponents(name)
    }
}

extension TextKeyboardView {
    
    var attributedText: some View {
        Text(attributedTextString)
    }
    
    var attributedTextString: AttributedString {
        var formattedDate: AttributedString = Date()
            .formatted(Date.FormatStyle().day().month(.wide).weekday(.wide).attributed)
        let weekday = AttributeContainer.dateField(.weekday)
        let color = AttributeContainer.foregroundColor(.orange)
        formattedDate.replaceAttributes(weekday, with: color)
        return formattedDate
    }
    
    var focusButton: some View {
        Button("Focus on text field") {
            isFocused = true    // Doesn't work in List
        }
    }
    
    var personList: some View {
        Text(persons.map(\.nameComponents).formatted(
            .list(memberStyle: .name(style: .short),
                  type: .and)
        ))
    }
    
    var personListAdder: some View {
        TextField("New Attendee",
                  value: $newPerson, format: .name(style: .medium),
                  prompt: Text("Add new person"))
            .submitLabel(.done)
            .onSubmit {
                let name = newPerson.formatted(.name(style: .long))
                persons.append(Person(name: name))
                newPerson = PersonNameComponents()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Keyboard", action: {})
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Navbar", action: {})
                }
            }
            .focused($isFocused)
    }
    
    var rainbowText: some View {
        Text("""
        ^[Hello](rainbow: 'extreme'), World!
        """)
    }
}

enum RainbowAttribute: CodableAttributedStringKey, MarkdownDecodableAttributedStringKey {
    
    enum Value: String, Codable {
        case plain, extreme
    }
    
    public static var name = "rainbow"  // ??????
}

struct TextKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        TextKeyboardView()
    }
}
