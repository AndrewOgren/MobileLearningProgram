import XCTest

@testable import LearningProgram

final class PersonViewViewModelTests: XCTestCase {
    func testSave() {
        let person = Person(id: UUID(), name: "Andrew", language: "Swift")
        let viewModel = PersonViewViewModel(person: person)
        viewModel.assert(viewModel.save()) {
            $0.name = "Andrew"
            $0.language = "Swift"
            
        }
    }

    func testShouldNotSaveIfInputContainsErrors() {
        let person = Person(id: UUID(), name: "Andrew", language: "")
        let viewModel = PersonViewViewModel(person: person)
        viewModel.assert(viewModel.save()) {
            $0.showingAlert = true
            $0.error = "Not allowed!"
            
        }
    }
}
