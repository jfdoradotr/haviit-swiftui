//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct TaskDetailView: View {
  @Environment(\.dismiss) private var dismiss

  @State var task: Task

  let onUpdate: (Task) -> Void
  let onDelete: (Task) -> Void

  init(task: Task, onDelete: @escaping (Task) -> Void, onUpdate: @escaping (Task) -> Void) {
    self._task = .init(initialValue: task)
    self.onDelete = onDelete
    self.onUpdate = onUpdate
  }

  private var isCompletedToday: Bool {
    task.sortedLog.last?.formatted(date: .long, time: .omitted) == Date().formatted(date: .long, time: .omitted)
  }

  var body: some View {
    List {
      // Description Section
      Section(header: Text("Task Details").font(.headline)) {
        Text(task.description ?? "No Description")
          .font(.body)
          .foregroundStyle(.secondary)
      }

      // Log Section
      if !task.log.isEmpty {
        Section(header: Text("Activity Log").font(.headline)) {
          ForEach(task.log, id: \.self) { item in
            HStack {
              Text(item.formatted(date: .long, time: .shortened))
                .font(.subheadline)
              Spacer()
              Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
            }
            .padding(.vertical, 4)
          }
        }
      }

      // Action Buttons Section
      Section {
        Button(action: {
          withAnimation {
            toggleTaskCompletion()
          }
        }) {
          HStack {
            Image(systemName: isCompletedToday ? "checkmark.circle" : "checkmark.circle.fill")
            Text(isCompletedToday ? "Unmark as Completed" : "Mark as Completed")
          }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .cornerRadius(8)
        }
        .buttonStyle(.bordered)
        .tint((isCompletedToday ? Color.brown : Color.green))
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)

        Button(action: {
          withAnimation {
            // edit task
          }
        }) {
          HStack {
            Image(systemName: "pencil")
            Text("Edit")
          }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .cornerRadius(8)
        }
        .buttonStyle(.bordered)
        .tint(Color.gray)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)

        Button(action: {
          onDelete(task)
          dismiss()
        }) {
          HStack {
            Image(systemName: "trash")
            Text("Delete")
          }
          .frame(maxWidth: .infinity)
          .frame(height: 50)
          .cornerRadius(8)
        }
        .buttonStyle(.bordered)
        .tint(.red)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
      }
    }
    .buttonStyle(.borderless)
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle(task.name)
  }

  private func toggleTaskCompletion() {
    if isCompletedToday {
      if let index = task.sortedLog.lastIndex(of: task.log.last!) {
        task.log.remove(at: index)
      }
    } else {
      task.log.append(Date())
    }
    onUpdate(task)
  }
}

#Preview {
  NavigationStack {
    TaskDetailView(
      task: Task(
        name: "Task 1",
        description: "Nothing to add",
        log: [Date.now, Date.now.addingTimeInterval(-86400)]
      ),
      onDelete: { _ in },
      onUpdate: { _ in }
    )
  }
}
