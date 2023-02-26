import SwiftUI

struct PersonRow: View {
    var person: Person

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                nameText
                if person.knowsLanguage {
                    languageText
                }
            }
            Spacer()
        }
    }

    // Should the whole string be formed in a view model?
    private var nameText: Text {
        Text("Name: ").bold() + Text(person.name)
    }

    private var languageText: Text {
        Text("Language: ").bold() + Text(person.language?.rawValue ?? "")
    }
}

struct PersonRow_Previews: PreviewProvider {
    static var previews: some View {
        PersonRow(
            person:
                Person(
                    name: "Andrew Ogren",
                    language: .swift
                )
        )
    }
}
