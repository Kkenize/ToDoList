//
//  DetailedView.swift
//  ToDoList
//
//  Created by Zhejun Zhang on 3/7/25.
//

import SwiftUI
import SwiftData

struct DetailedView: View {
//    @Bindable var ToDo: ToDo
    @State var toDo: ToDo
    @State private var item = ""
    @State private var reminderIsOn = false
    @State private var isCompleted = false
    @State private var dueDate = Date.now + 60*60*24
//    @State private var dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
    @State private var notes = ""
//    var passedValue: String //Don't initialize it, it will be passed from the parent view
    @Environment(\.modelContext) var modelContext
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        List {
            TextField("Enter To Do Here", text: $item)
                .font(.title)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
                .listRowSeparator(.hidden)
            
            Toggle("Set Reminder:", isOn: $reminderIsOn)
                .padding(.top)
            
            DatePicker("Date:", selection: $dueDate)
                .padding(.bottom)
                .disabled(!reminderIsOn)
            
            TextField("Notes", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .listRowSeparator(.hidden)
            
            Toggle("Completed:", isOn: $isCompleted) .padding(.top)
        }
        .listStyle(.plain)
        .onAppear() {
            item = toDo.item
            reminderIsOn = toDo.reminderIsOn
            dueDate = toDo.dueDate
            notes = toDo.notes
            isCompleted = toDo.isCompleted
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    toDo.item = item
                    toDo.reminderIsOn = reminderIsOn
                    toDo.dueDate = dueDate
                    toDo.notes = notes
                    toDo.isCompleted = isCompleted
                    modelContext.insert(toDo)
                    guard let _ = try? modelContext.save() else {
                        print("Error")
                        return
                    }
                    dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden()
        
//        VStack {
//            Image(systemName: "swift")
//                .resizable()
//                .scaledToFit()
//                .foregroundStyle(.orange)
//            
//            Text("You are a swift legend!\n And you passed over the value \(passedValue)")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .multilineTextAlignment(.center)
//                .minimumScaleFactor(0.5)
//            
//            Spacer()
//            
//            Button("Get back!") {
//                dismiss()
//            }
//            .buttonStyle(.borderedProminent)
//        }
//        .padding()
//        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack {
        DetailedView(toDo: ToDo())
            .modelContainer(for: ToDo.self,
                            inMemory: true)
    }
}
