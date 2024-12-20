//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct Task: Identifiable, Hashable {
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

  var sortedLog: [Date] { log.sorted() }
}

@Observable
final class TasksStore {
  var tasks: [Task]

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
          NavigationLink(value: task) {
            Text(task.name)
          }
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
        AddNewTaskView(tasks: $tasksStore.tasks)
      }
      .navigationDestination(for: Task.self) { task in
        TaskDetailView(tasks: $tasksStore.tasks, task: task)
      }
    }
  }
}

#Preview {
  ContentView()
}
