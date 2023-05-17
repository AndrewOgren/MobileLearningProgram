import SwiftUI

struct PersonView: View {
    @Binding var person: Person
    
    var body: some View {
        WithViewModel(PersonViewViewModel(person: person)) { viewModel in
            VStack(alignment: .leading, spacing: 8) {
                HStack{
                  Text("Name:")
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .fixedSize()
                  TextField(
                    "Enter Language..",
                    text: viewModel.binding(\.name)
                  )
                }
                HStack{
                  Text("Favorite Language:")
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .fixedSize()
                  TextField(
                    "Enter Language..",
                    text: viewModel.binding(\.language)
                  )
                }
                Button("Save", action: {
                    viewModel.save()
                })
                .alert(viewModel.error ?? "", isPresented: viewModel.binding(\.showingAlert)) {
                    Button("OK", role: .cancel) { }
                }
                Spacer()
            }
            .padding(16)
        }
        .bind(\.source, to: $person)
    }
}
