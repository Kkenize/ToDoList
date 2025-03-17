//
//  ToDo.swift
//  ToDoList
//
//  Created by Zhejun Zhang on 3/8/25.
//

import Foundation
import SwiftData

@Model
@MainActor
class ToDo {
    var item: String = ""
    var reminderIsOn = false
    var isCompleted = false
    var dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
    var notes = ""
    
    init(item: String = "", reminderIsOn: Bool = false, isCompleted: Bool = false, dueDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!, notes: String = "") {
        self.item = item
        self.reminderIsOn = reminderIsOn
        self.isCompleted = isCompleted
        self.dueDate = dueDate
        self.notes = notes
    }
}

extension ToDo {
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: ToDo.self, configurations: ModelConfiguration(isStoredInMemoryOnly:true))
        
        //add mock data
        container.mainContext.insert(ToDo(item:"Create SwiftData Lessons", reminderIsOn: true, isCompleted: false, dueDate: Date.now + 60*60*24, notes: "Now with IOS 16 & Xcode 18"))
        container.mainContext.insert(ToDo(item:"Education Talks", reminderIsOn: true, isCompleted: false, dueDate: Date.now + 60*60*44, notes: "They want to learn about entrepreneurship"))
        container.mainContext.insert(ToDo(item:"Post Flyers For Swift", reminderIsOn: true, isCompleted: false, dueDate: Date.now + 60*60*72, notes: "To be held at UAH circle"))
        container.mainContext.insert(ToDo(item:"Prepare old iphone for Lily", reminderIsOn: true, isCompleted: false, dueDate: Date.now + 60*60*12, notes: "She gets my old pro"))
        
        return container
    }
}

