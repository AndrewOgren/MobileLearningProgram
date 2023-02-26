import Foundation

struct GetPeopleRequest: NetworkRequest {
    typealias Response = People
    var url = "https://gist.githubusercontent.com/russellbstephens/9e528b12fd1a45a7ff4e4691adcddf10/raw/5ec8ce76460e8f29c9b0f99f3bf3450b06696482/people.json"
    var httpMethod: HTTPMethod = .get
}
