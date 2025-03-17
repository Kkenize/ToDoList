//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Zhejun Zhang on 3/7/25.
//

import SwiftUI
import SwiftData

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ToDoListView()
                .modelContainer(for: ToDo.self)
        }
    }
    
    //Will allow us to find where the simulator data is saved
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
