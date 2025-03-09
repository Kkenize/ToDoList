//
//  ToDo.swift
//  ToDoList
//
//  Created by Zhejun Zhang on 3/8/25.
//

import Foundation
import SwiftData

@Model
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

