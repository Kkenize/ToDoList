//
//  DetailedView.swift
//  ToDoList
//
//  Created by Zhejun Zhang on 3/7/25.
//

import SwiftUI
import SwiftData

struct DetailedView: View {
    @State var ToDo: ToDo
    @State private var item = ""
    @State private var reminderIsOn = false
    @State private var isCompleted = false
//    @State private var dueDate = Date.now + 60*60*24
    @State private var dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
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
            
            Toggle("Completed:", isOn: $isCompleted)
                .padding(.top)
        }
        .listStyle(.plain)
        .onAppear() {
            item = ToDo.item
            reminderIsOn = ToDo.reminderIsOn
            dueDate = ToDo.dueDate
            notes = ToDo.notes
            isCompleted = ToDo.isCompleted
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    ToDo.item = item
                    ToDo.reminderIsOn = reminderIsOn
                    ToDo.dueDate = dueDate
                    ToDo.notes = notes
                    ToDo.isCompleted = isCompleted
                    modelContext.insert(ToDo)
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
        DetailedView(ToDo: ToDo())
            .modelContainer(for: ToDo.self,
                            inMemory: true)
    }
}
