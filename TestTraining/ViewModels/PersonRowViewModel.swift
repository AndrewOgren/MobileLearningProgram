import Foundation
import SwiftUI

final class PersonRowViewModel: ObservableViewModel {
    typealias Event = PersonRowViewModel
    
    struct State: Equatable {
        var person: Person
    }
    
    init(initialState: State) {
        self.state = initialState
    }
    
    @Published private(set) var state: State
    
    func binding(person: Person) -> Binding<Person> {
        Binding(
            get: { person },
            set: { self.updatePerson($0) }
        )
    }
    
    private func updatePerson(_ person: Person) {
        self.state.person = person
    }
    
    func binding<Value>(_ keyPath: WritableKeyPath<State, Value>) -> Binding<Value> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.state[keyPath: keyPath] = $0 }
        )
    }
}
