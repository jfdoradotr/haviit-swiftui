//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct AddNewTaskView: View {
  @State private var title: String = ""
  @State private var description: String = ""

  @Environment(\.dismiss) private var dismiss

  var body: some View {
    NavigationStack {
      Form {
        TextField("Name", text: $title)
        TextEditor(text: $description)
          .frame(height: 150)
      }
      .navigationTitle("Add New Task")
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("Add") {
            print("Title: \(title)")
            print("Description: \(description)")
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
  AddNewTaskView()
}
