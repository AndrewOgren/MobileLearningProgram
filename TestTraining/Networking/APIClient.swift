import Foundation

protocol APIClient {
    var baseURL: URL { get }
    func perform<T: Decodable>(request: RequestType,
                               path: String,
                               properties: [String: Any]?,
                               completion: @escaping (Result<T,Error>) -> Void)
    func perform<T: Decodable>(request: RequestType,
                               path: String,
                               properties: [String : Any]?) async throws -> T
}
