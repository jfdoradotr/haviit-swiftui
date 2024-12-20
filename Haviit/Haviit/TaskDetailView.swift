//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct TaskDetailView: View {
  @Environment(\.dismiss) private var dismiss

  @Binding var tasks: [Task]

  let task: Task

  private var isCompletedToday: Bool {
    task.sortedLog.last?.formatted(date: .long, time: .omitted) == Date().formatted(date: .long, time: .omitted)
  }

  var body: some View {
    List {
      // Description Section
      Section(header: Text("Task Details").font(.headline)) {
        Text(task.description)
          .font(.body)
          .foregroundStyle(.secondary)
      }

      // Log Section
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

      // Action Buttons Section
      Section {
        Button(action: {
          if isCompletedToday {

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
          if let index = tasks.firstIndex(of: task) {
            tasks.remove(at: index)
            dismiss()
          }
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
}

#Preview {
  NavigationStack {
    TaskDetailView(
      tasks: .constant([]),
      task: Task(
        name: "Task 1",
        description: "Nothing to add",
        log: [Date.now, Date.now.addingTimeInterval(-86400)]
      )
    )
  }
}
