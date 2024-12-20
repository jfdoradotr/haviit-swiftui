//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct Task: Identifiable, Hashable {
  let id: UUID
  let name: String
  let description: String
  var log: [Date]

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

  func delete(_ task: Task) {
    tasks.removeAll(where: { $0.id == task.id })
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
        TaskDetailView(
          task: task,
          onDelete: { tasksStore.delete($0) }
        )
      }
    }
  }
}

#Preview {
  ContentView()
}
