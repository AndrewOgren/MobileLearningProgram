import SwiftUI

struct PersonList: View {
    @ObservedObject var viewModel: PersonListViewModel

    init(viewModel: PersonListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List(viewModel.people) { person in
                PersonRow(person: person)
        }
        .onAppear {
            // is onAppear the appropriate place to make this call?
            // Does this scale? What if we have to make multiple calls?
            viewModel.fetchPeople()
        }
    }
}

struct PersonList_Previews: PreviewProvider {
    static var previews: some View {
        PersonList(viewModel: PersonListViewModel())
    }
}
