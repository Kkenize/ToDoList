//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Zhejun Zhang on 3/7/25.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
    @Query var ToDos: [ToDo]
    @State private var sheetPresented = false
    @Environment(\.modelContext) var modelContext
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
            
            List {
                ForEach(ToDos, id: \.self) { toDo in
                    NavigationLink {
                        DetailedView(ToDo: ToDo())
                    } label: {
                        Text(toDo.item)
                    }
                    .font(.title2)
                }
                
//                ForEach (0..<100, id: \.self) { number in
//                    NavigationLink {
//                        DetailedView(passedValue: "Item \(number)")
//                    } label: {
//                        Text("Item \(number + 1)")
//                    }
//                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
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
        .modelContainer(for: ToDo.self, inMemory: true)
}
