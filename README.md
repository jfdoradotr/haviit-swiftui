# Haviit

Haviit is a simple habit-tracking app designed to help users track and manage their habits effectively. This project was built as a challenge in the **100 Days of SwiftUI** course to solidify knowledge in SwiftUI and practice building a complete app from scratch.

---

## Challenge Overview

The challenge provided three levels of difficulty:

1. **Basic**: Create a list of activities with an option to add new ones. Each activity includes a title and description.
2. **Intermediate**: Add a detail view for each activity, displaying its description.
3. **Advanced**: Allow users to track the completion count of each activity and save progress using `Codable` and `UserDefaults`.

---

## Features

- **Add Tasks**: Create tasks with a title and optional description.
- **Track Progress**: View a log of completed activities with timestamps.
- **Task Management**: Edit or delete tasks as needed.
- **Daily Tracking**: Mark tasks as completed for the day with a single tap.
- **Persistent Storage**: Data is saved locally using `Codable` and `UserDefaults`.

---

## Screenshots

| Demo                          |
| ----------------------------- |
| ![demo](screenshots/demo.gif) |

---

## Implementation Details

### Core Data Models

- **Task**:
  - A `struct` conforming to `Identifiable`, `Hashable`, and `Codable`.
  - Fields: `id`, `name`, `description`, and `log` (an array of completion timestamps).

- **TasksStore**:
  - An `@Observable` class holding an array of tasks.
  - Implements methods for adding, updating, and deleting tasks.
  - Uses `UserDefaults` to save and load tasks persistently.

### Views

1. **ContentView**:
   - Displays the list of tasks.
   - Provides navigation to the `TaskDetailView`.
   - Presents the `AddNewTaskView` for creating new tasks.

2. **AddNewTaskView**:
   - A form for creating or editing tasks.
   - Includes text fields for the task name and description.

3. **TaskDetailView**:
   - Shows detailed information about a task.
   - Displays the task's description and a log of completed dates.
   - Allows marking tasks as completed, editing, or deleting them.

---

## Development Highlights

- **SwiftUI Navigation**:
  - Used `NavigationStack` and `NavigationLink` for seamless transitions between views.
  - Presented modal views with `sheet()`.

- **Data Persistence**:
  - Leveraged `Codable` for serializing tasks.
  - Integrated `UserDefaults` for data storage.

- **State Management**:
  - Adopted `@Observable` for monitoring and updating task data across views.

---

## Lessons Learned

This challenge reinforced key concepts in SwiftUI, including:

1. Building dynamic views using state and observable objects.
2. Managing navigation and modal presentations.
3. Implementing local data persistence with `Codable` and `UserDefaults`.
4. Designing scalable and maintainable data models.

---

## Future Enhancements

1. **Custom Notifications**: Notify users to complete habits at specific times.
2. **Themes**: Add customization options for the app's appearance.
3. **Statistics**: Display progress charts for better visualization.
4. **Cloud Sync**: Enable cross-device data synchronization using iCloud.

---

## Getting Started

1. Clone the repository from GitHub:
   ```bash
   git clone https://github.com/jfdoradotr/haviit.git
   cd haviit
   ```
2. Open the project in Xcode 16.1 or later.
3. Run the app on a simulator or device.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Feel free to adjust this README as needed. Let me know if you'd like help refining it further!