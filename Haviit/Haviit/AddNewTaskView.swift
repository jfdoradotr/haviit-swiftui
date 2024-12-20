//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct AddNewTaskView: View {
  @State private var name: String = ""
  @State private var description: String = ""

  @Binding var tasks: [Task]

  @Environment(\.dismiss) private var dismiss

  var body: some View {
    NavigationStack {
      Form {
        TextField("Name", text: $name)
        TextEditor(text: $description)
          .frame(height: 150)
      }
      .navigationTitle("Add New Task")
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("Add") {
            let task = Task(name: name, description: description)
            tasks.append(task)
            dismiss()
          }
        }
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") {
            print("Cancelled")
            dismiss()
          }
        }
      }
    }
  }
}

#Preview {
  AddNewTaskView(tasks: .constant([]))
}
