import Foundation

protocol APIClient {
    var baseURL: URL { get }
    func perform<T>(
        request: RequestType,
        path: String,
        properties: [String : Any]?
    ) async -> Result<T, Error> where T: Decodable
}
