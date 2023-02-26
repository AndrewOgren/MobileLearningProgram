import Foundation

// Should all of our view models be MainActors since View -> ViewModel?
@MainActor
class PersonListViewModel: ObservableObject {

    @Published var people: [Person] = []

    // Should this live in a repo?
    private let apiService: APIService

    init(apiService: APIService = DefaultAPIService()) {
        self.apiService = apiService
    }

    func fetchPeople() {
        // Any risk of memory leak?
        Task {
            let result = await apiService.request(GetPeopleRequest())
            switch result {
            case .success(let persons):
                people = persons.people
            case .failure(let error):
                print(error)
            }
        }
    }
}
