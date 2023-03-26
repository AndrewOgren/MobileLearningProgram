import Foundation
import SwiftUI

final class ViewModel: ObservableViewModel {
    typealias Event = ViewModel

    struct State: Equatable {
        static func == (lhs: ViewModel.State, rhs: ViewModel.State) -> Bool {
            return lhs.people?.hashValue == rhs.people?.hashValue
        }

        let apiCallPath = "9e528b12fd1a45a7ff4e4691adcddf10/raw/5ec8ce76460e8f29c9b0f99f3bf3450b06696482/people.json"
        var apiClient: APIClient
        var people: [Person]?
        var error: Error?
    }

    @Published private(set) var state: State

    init(apiClient: APIClient) {
        state = State(apiClient: apiClient)
    }
    
    func binding(person: Person) -> Binding<Person> {
        Binding(
            get: { person },
            set: { self.updatePeople($0) }
        )
    }

    func binding<Value>(_ keyPath: WritableKeyPath<State, Value>) -> Binding<Value> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.state[keyPath: keyPath] = $0 }
        )
    }

    @MainActor
    func makeAPICallAsyncAwait() async {
        do {
            let people: People = try await self.state.apiClient.perform(request: .get,
                                                                        path: self.state.apiCallPath,
                                                                        properties: nil)
            self.state.people = people.people
        } catch {
            self.state.error = error
        }
    }
    
    private func updatePeople(_ person: Person) {
        guard let index = state.people?.firstIndex(where: { $0.id == person.id })
        else { return }
        
        state.people?[index] = person
    }
}
