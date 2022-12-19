//
//  ContentView.swift
//  Mobile Learning Program
//
//  Created by Andrew Ogren on 12/16/22.
//

import SwiftUI

struct PersonList: View {
    @ObservedObject var viewModel: PersonListViewModel

    init(viewModel: PersonListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            ForEach(viewModel.people, id: \.name) { person in
                PersonRow(person: person)
            }
        }
        .onAppear {
            viewModel.fetchPeople()
        }
    }
}

struct PersonList_Previews: PreviewProvider {
    static var previews: some View {
        PersonList(viewModel: PersonListViewModel())
    }
}
