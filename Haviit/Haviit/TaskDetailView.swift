//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct TaskDetailView: View {
  var task: Task

  @State private var name: String
  @State private var description: String

  init(task: Task) {
    self.task = task
    _name = .init(initialValue: task.name)
    _description = .init(initialValue: task.description)
  }

  var body: some View {
    Form {
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
        VStack(spacing: 20.0) {
          Button(action: {
            // Implement Mark as Completed functionality
          }) {
            Text("Mark as Completed")
              .frame(maxWidth: .infinity)
              .padding()
              .background(Color.green)
              .foregroundColor(.white)
              .cornerRadius(8)
          }

          Button(action: {
            // Implement Edit functionality (perhaps a new view/modal for editing)
          }) {
            Text("Edit")
              .frame(maxWidth: .infinity)
              .padding()
              .background(Color.gray.opacity(0.2))
              .foregroundColor(.primary)
              .cornerRadius(8)
          }

          Button(action: {
            // Implement Delete functionality
          }) {
            Text("Delete")
              .frame(maxWidth: .infinity)
              .padding()
              .background(Color.red)
              .foregroundColor(.white)
              .cornerRadius(8)
          }
        }
      }
    }
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle(task.name)
  }
}

#Preview {
  NavigationStack {
    TaskDetailView(task: Task(name: "Task 1", description: "Nothing to add", log: [Date.now, Date.now.addingTimeInterval(-86400)]))
  }
}
