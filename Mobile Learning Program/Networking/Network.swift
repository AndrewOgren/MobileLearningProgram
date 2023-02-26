import Foundation

enum HTTPMethod: String {
    case get, put, post, delete
}

protocol NetworkRequest {
    associatedtype Response
    // skip params, headers, etc
    var url: String { get }
    var httpMethod: HTTPMethod { get }
    func decode(_ data: Data) throws -> Response
}

extension NetworkRequest where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}

protocol APIService {
    func request<Request: NetworkRequest>(_ request: Request) async -> Result<Request.Response, Error>
}

final class DefaultAPIService: APIService {
    func request<Request>(_ request: Request) async -> Result<Request.Response, Error> where Request : NetworkRequest {
        do {
            guard let url = URL(string: request.url) else {
                return .failure(NSError(domain: "invalid url", code: 404))
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.httpMethod.rawValue
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            return try .success(request.decode(data))
        } catch {
            return .failure(error)
        }
    }
}




