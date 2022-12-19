//
//  PersonListViewModel.swift
//  Mobile Learning Program
//
//  Created by Andrew Ogren on 12/19/22.
//

import Foundation

class PersonListViewModel: ObservableObject {

    @Published var people: [Person] = []

    private let personUrlString = "https://gist.githubusercontent.com/russellbstephens/9e528b12fd1a45a7ff4e4691adcddf10/raw/5ec8ce76460e8f29c9b0f99f3bf3450b06696482/people.json"

    func fetchPeople() {
        Task {
            let result: Result<People, Error> = await fetchData(from: URL(string: personUrlString)!)
            switch result {
            case .success(let persons):
                DispatchQueue.main.async {
                    self.people = persons.people
                }
            case .failure:
                break
                /// Not handled
            }
        }
    }

    /// Should move to Networking class
    private func fetchData<Response: Codable>(from url: URL) async -> Result<Response, Error> {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let response =  try? JSONDecoder().decode(Response.self, from: data) {
                return .success(response)
            }
            return .failure(NSError())
        } catch {
            return .failure(NSError())
        }
    }
    
}
