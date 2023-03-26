import Foundation

public protocol ObservableViewModel: ViewModelProtocol {
    associatedtype Event
}

extension ObservableViewModel {
    func send(_ event: Event) {
        EventManager.shared.notify(viewModel: self, event: event)
    }
}
