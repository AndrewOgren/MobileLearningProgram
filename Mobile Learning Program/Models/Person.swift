import Foundation

struct People: Codable {
    let people: [Person]
}

struct Person: Identifiable, Codable {
    // Had to add id to make it identifiable
    let id: UUID
    let name: String
    let language: ProgrammingLanguage?

    init(
        id: UUID = UUID(),
        name: String,
        language: ProgrammingLanguage?
    ) {
        self.id = id
        self.name = name
        self.language = language
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        name = try container.decode(String.self, forKey: .name)
        language = try container.decodeIfPresent(ProgrammingLanguage.self, forKey: .language)
    }
}

extension Person {
    var knowsLanguage: Bool {
        return language != nil
    }
}

enum ProgrammingLanguage: String, Codable {
    case swift = "swift", kotlin = "kotlin", dart = "dart"
}
