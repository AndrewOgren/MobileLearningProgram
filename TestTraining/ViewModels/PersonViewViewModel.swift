import SwiftUI

class PersonViewViewModel: ObservableViewModel {
    typealias Event = State
    
    struct State: Equatable {
        var name: String
        var language: String
        var error: String?
        var showingAlert: Bool = false
        
        fileprivate var source: Person
        
        init(person: Person) {
            name = person.name
            language = person.language
            source = person
        }
    }
    
    var source: Person {
        get { state.source }
        set { state.source = newValue }
    }
    
    @Published private(set) var state: State

    init(person: Person) {
        self.state = .init(person: person)
    }
    
    func save() {
        guard !state.language.isEmpty && !(state.language.lowercased() == "python") else {
            state.showingAlert = true
            state.error = "Not allowed!"
            return
        }
        state.source = Person(id: source.id, name: state.name, language: state.language)
    }
    
    func binding<Value>(_ keyPath: WritableKeyPath<State, Value>) -> Binding<Value> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.state[keyPath: keyPath] = $0 }
        )
    }
}
