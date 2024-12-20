//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct Task: Identifiable, Hashable {
  let id: UUID
  var name: String
  var description: String?
  var log: [Date]

  init(id: UUID = UUID(), name: String, description: String?, log: [Date] = []) {
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

  func update(_ task: Task) {
    guard let sourceTask = tasks.filter({ $0.id == task.id }).first,
          let index = tasks.firstIndex(of: sourceTask) else {
      print("Task doesn't exist")
      return
    }
    tasks[index] = task
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
        AddNewTaskView(onAdd: tasksStore.add)
      }
      .navigationDestination(for: Task.self) { task in
        TaskDetailView(
          task: task,
          onDelete: { tasksStore.delete($0) },
          onUpdate: { tasksStore.update($0) }
        )
      }
    }
  }
}

#Preview {
  ContentView()
}
