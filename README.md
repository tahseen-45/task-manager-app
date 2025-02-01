# Task Management App

A comprehensive task management application that allows users to manage their tasks effectively. The app includes user authentication, profile management, task creation with various settings like priority and task type, and task management features such as marking tasks as completed, editing, and deleting.

## Features

- **Splash Screen:** Displays for 4 seconds and checks if the user is already logged in then goto home screen else goto login screen.
- **Login/Sign-Up Flow:** Users can log in, or if they are new, they can sign up and create an account.
- **Profile Management:** Users can view and update their profile details and upload a profile image.
- **Task Creation:** Users can create tasks with a title, description, category, priority (with a slider and visual feedback), and task type (Everyday or Today).
- **Task Management:** Tasks can be viewed, edited, marked as completed, or deleted.
- **UI Components:**
  - **Priority Slider** for task priority (Low, Medium, High with color-coded feedback).
  - **Switch Boxes** for task type selection.
  - **Task Cards** with visual indicators (priority, task type).
  - **Task Lists** for Everyday and Today tasks.
- **Real-time Updates:** Uses `StreamBuilder` to immediately reflect changes in the task list.
- **State Management:** Managed using Provider for efficient state handling.
- **Data Storage:** Firebase Firestore for storing user and task data.

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/task-management-app.git
    ```

2. Navigate to the project directory:
    ```bash
    cd task-management-app
    ```

3. Install dependencies:
    ```bash
    flutter pub get
    ```

4. Set up Firebase Firestore:
    - Follow the [Firebase Flutter Setup Guide](https://firebase.flutter.dev/docs/overview) to configure Firebase for your project.
    - Ensure that Firestore is enabled in your Firebase console.

5. Run the app:
    ```bash
    flutter run
    ```

## Usage

Once the app is set up, you can launch it and navigate through the following features:

- **Login/Sign-Up Screen:** Login if you already have an account or sign up if you are a new user.
- **Profile Screen:** View and edit your profile details, including uploading a profile image.
- **Task Management:** Create tasks by selecting a priority using a slider, task type (Everyday or Today), and entering the task title,description and category.
- **Task List:** View tasks priority Visually, edit task details, mark tasks as completed, or delete them.

## Task Priority & Slider

- The task priority is visually represented using a slider with three priority levels: **Low (green)**, **Medium (yellow)**, and **High (red)**.
- The slider's color and label change dynamically as the user adjusts the priority.

## Task Types

- **Everyday:** These tasks are for everyday.
- **Today:** These tasks are specific to the current day.

The task list is separated into two screens, **Everyday Tasks** and **Today Tasks**, each showing tasks based on their type.

## Architecture

This app follows the **MVVM (Model-View-ViewModel)** architecture to ensure separation of concerns and maintainability:

- **Model**: Custom classes represent the data for users and tasks.
- **View**: The UI, which responds to state changes.
- **ViewModel**: Contains the business logic and manages the app's state using `Provider`.
