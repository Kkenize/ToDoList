//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Zhejun Zhang on 3/7/25.
//

import SwiftUI
import SwiftData

enum SortOption: String, CaseIterable {
    case asEntered = "As Enter"
//    case alphabetical = "Z-A"
    case alphabetical = "A-Z"
    case chronological = "Date"
    case completed = "Not Done"
}

struct SortedToDoList: View {
    @Query var ToDos: [ToDo]
    @Environment(\.modelContext) var modelContext
    let sortSelection: SortOption
    
    init(sortSelection: SortOption) {
        self.sortSelection = sortSelection
        switch self.sortSelection {
        case .asEntered:
            _ToDos = Query()
        case .alphabetical:
//            _ToDos = Query(sort: \.item, order: .reverse)
            _ToDos = Query(sort: \.item)
        case .chronological:
            _ToDos = Query(sort: \.dueDate)
        case .completed:
            _ToDos = Query(filter: #Predicate {$0.isCompleted == false})
        }
    }
    
    var body: some View {
        List {
            ForEach(ToDos, id: \.self) { toDo in
                VStack {
                    HStack {
                        Image(systemName: toDo.isCompleted ? "checkmark.rectangle" : "rectangle")
                            .onTapGesture {
                                toDo.isCompleted.toggle()
                                guard let _ = try? modelContext.save() else {
                                    print("Error Saving After .toggle")
                                    return
                                }
                            }
                        
                        NavigationLink {
                            DetailedView(ToDo: ToDo())
                        } label: {
                            Text(toDo.item)
                        }
                        //                        .swipeActions {
                        //                        Button("Delete", role: .destructive) {
                        //                            modelContext.delete(toDo)
                        //                            guard let _ = try? modelContext.save() else {
                        //                                print("Error Saving After .delete")
                        //                                return
                        //                            }
                        //                        }
                        //                        }
                    }
                    .font(.title2)
                    
                    HStack {
                        Text(toDo.dueDate.formatted(date:.abbreviated, time: .shortened))
                            .foregroundStyle(.secondary)
                        
                        if toDo.reminderIsOn {
                            Image(systemName: "calender.badge.clock")
                                .symbolRenderingMode(.multicolor)
                        }
                    }
                }
            }
            .onDelete { indexSet in
                indexSet.forEach({modelContext.delete(ToDos[$0])})
                guard let _ = try? modelContext.save() else {
                    print("Error Saving After .delete")
                    return
                }
            }
            
            
            //                ForEach (0..<100, id: \.self) { number in
            //                    NavigationLink {
            //                        DetailedView(passedValue: "Item \(number)")
            //                    } label: {
            //                        Text("Item \(number + 1)")
            //                    }
            //                }
        }
        .listStyle(.plain)
    }
}

struct ToDoListView: View {
    @State private var sheetPresented = false
    @State private var sortSelection: SortOption = .asEntered
    var body: some View {
        NavigationStack {
            //            Notes For 5.2
            //            List {
            //                Section {
            //                    NavigationLink {
            //                        DetailedView()
            //                    } label: {
            //                        Text("Winter")
            //                    }
            //
            //                    Text("Summer")
            //                } header: {
            //                    Text("Breaks")
            //                }
            //
            //                Section {
            //                    Text("Spring")
            //                    Text("Fall")
            //                } header: {
            //                    Text("Semesters")
            //                }
            //            }
            
            //Notes For 5.1
            //            NavigationLink {
            //                DetailedView()
            //            } label: {
            //                Image(systemName: "eye")
            //                Text("Show the new view!")
            //            }
            //            .buttonStyle(.borderedProminent)
            //            .padding()
            //        }
            
            SortedToDoList(sortSelection: sortSelection)
                .navigationTitle("To Do List")
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            sheetPresented.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Picker("",selection: $sortSelection) {
                            ForEach(SortOption.allCases, id:\.self) { sortOrder in
                                Text(sortOrder.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                .fullScreenCover(isPresented: $sheetPresented) {
                    NavigationStack {
                        DetailedView(ToDo: ToDo())
                    }
                }
        }
    }
}

#Preview {
    ToDoListView()
        .modelContainer(ToDo.preview)
}
