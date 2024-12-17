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
    List {
      Section(header: Text("Description")) {
        Text(task.description)
      }

      Section(header: Text("Log")) {
        ForEach(task.log, id: \.self) { item in
          Text(item.formatted(date: .long, time: .shortened))
        }
      }

      VStack {
        Button("Mark as completed") {

        }
        .buttonStyle(.borderedProminent)
        .tint(.green)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)

        Button("Edit") {

        }
        .buttonStyle(.borderedProminent)
        .tint(.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)

        Button("Delete") {

        }
        .buttonStyle(.borderedProminent)
        .tint(.red)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
      }

    }
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle(task.name)

  }

//  var body: some View {
//    VStack {
//      HStack {
//        VStack(alignment: .leading)  {
//          Text("Description")
//            .font(.footnote)
//            .foregroundStyle(.secondary)
//          Text(task.description)
//        }
//        Spacer()
//      }
//      Spacer()
//      Button("Mark as completed") {
//
//      }
//      .buttonStyle(.borderedProminent)
//      .tint(.green)
//      Spacer()
//    }
//    .padding()
//    .navigationBarTitleDisplayMode(.inline)
//    .navigationTitle(task.name)
//    .toolbar {
//      ToolbarItem {
//        Button("Edit", systemImage: "pencil") {
//          // move to add task to edit
//        }
//      }
//    }
//  }
}

#Preview {
  NavigationStack {
    TaskDetailView(task: Task(name: "Task 1", description: "Nothing to add", log: [Date.now, Date.now.addingTimeInterval(-86400)]))
  }
}
