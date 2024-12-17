//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct Task: Identifiable {
  var id = UUID()
  let name: String
  let description: String
  let log: [Date]
}

struct ContentView: View {
  @State private var addNewTask = false

  let tasks: [Task]

  var body: some View {
    NavigationStack {
      List {
        ForEach(tasks) { task in
          Text(task.name)
        }
      }
      .navigationTitle("Haviit")
      .toolbar {
        ToolbarItem {
          Button("Add Task", systemImage: "plus") {
            addNewTask = true
          }
        }
      }
      .sheet(isPresented: $addNewTask) {
        AddNewTaskView()
      }
    }
  }
}

#Preview {
  ContentView(tasks: [
    Task(name: "Item 1", description: "Description 1", log: []),
    Task(name: "Item 2", description: "Description 2", log: []),
  ])
}
