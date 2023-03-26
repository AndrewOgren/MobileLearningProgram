import SwiftUI

struct PeopleList: View {
    @State var hasLoadedPeople = false
    private let apiClient = TestAPIClient(baseURL: URL(string: "https://gist.githubusercontent.com/russellbstephens/")!)

    var body: some View {
        WithViewModel(ViewModel(apiClient: apiClient)) { viewModel in
            NavigationView {
                List(viewModel.state.people ?? [], id: \.self) { person in
                    PersonRow(person: viewModel.binding(person: person))
                }.task {
                    // better way to do this?
                    if !hasLoadedPeople {
                        await viewModel.makeAPICallAsyncAwait()
                    }
                    hasLoadedPeople = true
                }
            }
        }
    }
}
