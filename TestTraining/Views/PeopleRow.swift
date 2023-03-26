import SwiftUI

struct PersonRow: View {
    @Binding var person: Person
    
    var body: some View {
        WithViewModel(PersonRowViewModel(initialState: .init(person: person))) { viewModel in
            NavigationLink(destination: PersonView(person: viewModel.binding(\.person))) {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Name: ").fontWeight(.bold) + Text(person.name)
                    HStack{
                      Text("Favorite Language:")
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .fixedSize()
                      TextField(
                        "Enter Language..",
                        text: viewModel.binding(\.person.language)
                      )
                    }
                }
            }
        }
        .bind(\.person, to: $person)
    }
}
