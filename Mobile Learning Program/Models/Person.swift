//
//  Person.swift
//  Mobile Learning Program
//
//  Created by Andrew Ogren on 12/16/22.
//

import Foundation

struct People: Codable {
    let people: [Person]
}

struct Person: Codable {
    let name: String
    let language: ProgrammingLanguage?
}

extension Person {
    var knowsLanguage: Bool {
        return language != nil
    }
}

enum ProgrammingLanguage: String, Codable {
    case swift = "swift", kotlin = "kotlin", dart = "dart"
}
