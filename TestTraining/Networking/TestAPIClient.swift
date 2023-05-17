import Foundation

final class TestAPIClient: APIClient {
    private lazy var urlSession: URLSession =  {
        let urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.urlCache = cache
        return URLSession(configuration: urlSessionConfiguration)
    }()
        
    private lazy var documentURL: URL = {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }()
    
    private lazy var cache: URLCache = {
        let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let diskCacheURL = cachesURL.appendingPathComponent("NetworkCache")
        let cache = URLCache(memoryCapacity: 100_000_000, diskCapacity: 1_000_000_000, directory: diskCacheURL)
        return cache
    }()

    let baseURL: URL

    init(
        baseURL: URL
    ) {
        self.baseURL = baseURL
    }

    func perform<T>(
        request: RequestType,
        path: String,
        properties: [String : Any]?
    ) async -> Result<T, Error> where T: Decodable {
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(path), cachePolicy: .returnCacheDataElseLoad)
        
        guard let (data, response) = try? await urlSession.data(for: urlRequest) else {
            return .failure(NetworkingError.noData)
        }
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            return .failure(NetworkingError.failureResponse)
        }
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            if self.cache.cachedResponse(for: urlRequest) == nil {
                self.cache.storeCachedResponse(CachedURLResponse(response: response, data: data), for: urlRequest)
            }
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
