//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct AddNewTaskView: View {
  @State private var name: String = ""
  @State private var description: String = ""

  @Environment(\.dismiss) private var dismiss

  let onAdd: ((Task) -> Void)?
  let onEdit: ((Task) -> Void)?

  private var isEdit: Bool {
    onEdit != nil
  }

  init(
    name: String = "",
    description: String? = nil,
    onAdd: ((Task) -> Void)? = nil,
    onEdit: ((Task) -> Void)? = nil
  ) {
    self._name = .init(initialValue: name)
    self._description = .init(initialValue: description ?? "")
    self.onAdd = onAdd
    self.onEdit = onEdit
  }

  var body: some View {
    NavigationStack {
      Form {
        TextField("Name", text: $name)
        Section(header: Text("Description").font(.subheadline)) {
          TextEditor(text: $description)
            .frame(height: 150)
        }
      }
      .navigationTitle(isEdit ? "Update Task" : "Add Task")
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button(isEdit ? "Update" : "Add") {
            let task = Task(
              name: name,
              description: description.isEmpty ? nil : description
            )

            let action = onEdit ?? onAdd
            action?(task)
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
  AddNewTaskView(onAdd: { _ in }, onEdit: { _ in })
}
