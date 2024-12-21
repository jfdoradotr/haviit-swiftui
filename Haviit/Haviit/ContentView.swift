//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct Task: Identifiable, Hashable, Codable {
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

  init() {
    self.tasks = TasksStore.load()
  }

  func add(_ task: Task) {
    tasks.append(task)
    save()
  }

  func delete(_ task: Task) {
    tasks.removeAll(where: { $0.id == task.id })
    save()
  }

  func update(_ task: Task) {
    guard let sourceTask = tasks.filter({ $0.id == task.id }).first,
          let index = tasks.firstIndex(of: sourceTask) else {
      print("Task doesn't exist")
      return
    }
    tasks[index] = task
    save()
  }

  private func save() {
    let userDefaults = UserDefaults.standard
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted]
    
    do {
      let data = try encoder.encode(tasks)
      userDefaults.set(data, forKey: "tasks")
    } catch {
      print("Error saving tasks: \(error)")
    }
  }

  private static func load() -> [Task] {
    let userDefaults = UserDefaults.standard
    let decoder = JSONDecoder()

    guard let data = userDefaults.data(forKey: "tasks"), let tasks = try? decoder.decode([Task].self, from: data) else { return [] }
    return tasks
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
