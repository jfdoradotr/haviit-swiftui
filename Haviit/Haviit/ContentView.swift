//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct Task: Identifiable {
  let id: UUID
  let name: String
  let description: String
  let log: [Date]

  init(id: UUID = UUID(), name: String, description: String, log: [Date] = []) {
    self.id = id
    self.name = name
    self.description = description
    self.log = log
  }
}

@Observable
final class TasksStore {
  private(set) var tasks: [Task]

  init(tasks: [Task] = []) {
    self.tasks = tasks
  }

  func add(_ task: Task) {
    tasks.append(task)
  }
}

struct ContentView: View {
  @State private var addNewTask = false
  @State private var tasksStore = TasksStore()

  var body: some View {
    NavigationStack {
      List {
        ForEach(tasksStore.tasks) { task in
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
        AddNewTaskView { newTask in
          tasksStore.add(newTask)
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
