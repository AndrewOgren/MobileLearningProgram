import Foundation

struct Person: Identifiable, Hashable, Decodable {
    let id: UUID
    var name: String
    var language: String
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case language
    }
    
    init(
        id: UUID,
        name: String,
        language: String
    ) {
        self.id = UUID()
        self.name = name
        self.language = language
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.language = try container.decodeIfPresent(String.self, forKey: .language) ?? ""
        self.id = UUID()
    }
}

final class People: Decodable, ObservableObject {
    let people: [Person]
}
