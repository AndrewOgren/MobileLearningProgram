import Foundation

public protocol ViewModelObserver: AnyObject { }

public extension ViewModelObserver {
    var objectIdentifier: ObjectIdentifier {
        ObjectIdentifier(self)
    }
}
