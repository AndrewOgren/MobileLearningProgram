//
//  Mobile_Learning_ProgramApp.swift
//  Mobile Learning Program
//
//  Created by Andrew Ogren on 12/16/22.
//

import SwiftUI

@main
struct Mobile_Learning_ProgramApp: App {
    var body: some Scene {
        WindowGroup {
            PersonList(viewModel: PersonListViewModel())
        }
    }
}
