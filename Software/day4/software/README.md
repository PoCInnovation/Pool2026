# ⚙️ Day 04 - Software Track: GUI with Rust

Welcome to Day 4 of the Software Pool 2026! 🚀

Today, you'll create graphical interfaces with Rust! You'll discover Tauri (modern and lightweight) and/or Iced (native Rust framework).

## Day Purposes

✔️ Understand different GUI frameworks for Rust

✔️ Create a desktop application with Tauri

✔️ Create an interface with Iced (optional)

✔️ Handle user events

✔️ Create reusable components

✔️ Integrate Rust backend with frontend

## Introduction

### Why GUI Development?

Graphical user interfaces make applications accessible to non-technical users:
- **User-friendly** - Visual interaction instead of command line
- **Professional** - Modern desktop applications
- **Cross-platform** - Run on Windows, macOS, Linux
- **Rich interactions** - Buttons, forms, graphics

### Tauri vs Iced

**Tauri**:
- Rust backend + Web frontend (HTML/CSS/JS)
- Small binary size
- Use web technologies you know
- Great for web developers

**Iced**:
- Pure Rust framework
- No web technologies needed
- More control over rendering
- Great for Rust-native apps

## Warm Up

Before starting, familiarize yourself with:

1. **Web Technologies** (for Tauri):
   - HTML, CSS, JavaScript basics
   - React/Vue/Svelte (optional)

2. **Tauri Basics**:
   - Project structure
   - Commands (Rust functions callable from frontend)
   - IPC communication

3. **Frontend Frameworks** (optional):
   - React, Vue, or Svelte basics

Here are useful links:

- [Tauri Documentation](https://v2.tauri.app/fr/start/)
- [Tauri API Reference](https://v2.tauri.app/fr/reference/)
- [Iced Documentation](https://iced.rs/)

## Step 0 - Setup

📑 **Description:**

Set up your Tauri development environment.

📌 **Tasks:**

1. Install prerequisites:
```bash
# Install Node.js and npm
# Install Rust (if not already installed)
```

2. Create a Tauri project:
```bash
npm create tauri-app@latest
# Or use cargo
cargo install create-tauri-app --locked
cargo create-tauri-app
```

3. Install dependencies:
```bash
cd your-app
npm install
```

📚 **Documentation:**

- [Tauri Getting Started](https://v2.tauri.app/fr/start/prerequisites/)

✔️ **Validation:**

Run `npm run tauri dev` and you should see a window open.

## Step 1 - Hello World Application

📑 **Description:**

In this exercise, you'll create your first Tauri application. Tauri allows you to create desktop applications with a Rust backend and a web frontend (HTML/CSS/JavaScript). This is the perfect opportunity to understand Tauri's architecture and communication between frontend and backend.

📌 **What you need to do:**

### Step 1.1 - Install prerequisites

Before starting, make sure you have installed:
- Node.js (version 18 or higher)
- Rust (already installed normally)
- System dependencies for Tauri

Verify with:
```bash
node --version
npm --version
rustc --version
```

### Step 1.2 - Create a Tauri project

Create a new Tauri project:

```bash
npm create tauri-app@latest hello-tauri
cd hello-tauri
npm install
```

Or with Cargo:
```bash
cargo install create-tauri-app --locked
cargo create-tauri-app
```

**Created project structure:**
```
hello-tauri/
├── src-tauri/          # Rust code (backend)
│   ├── src/
│   │   └── main.rs
│   └── Cargo.toml
├── src/                # Frontend code (HTML/CSS/JS)
│   ├── index.html
│   └── main.js
└── package.json
```

**Why this structure?** Tauri clearly separates the Rust backend (`src-tauri`) from the web frontend (`src`).

### Step 1.3 - Create a Rust command (backend)

In `src-tauri/src/main.rs`, create a `greet` function marked with `#[tauri::command]` that takes a name parameter and returns a formatted greeting. This function will be callable from the frontend.

In the `run` function, use `invoke_handler` with `tauri::generate_handler![greet]` to register your command. This allows the frontend to call this function securely.

**Why do this?** Tauri commands allow the frontend to call Rust functions securely, with automatic parameter validation.

### Step 1.4 - Create the frontend interface

In `src/index.html`, create a simple interface with:
- A title "Hello Tauri!"
- A button with id `greet-button`
- A div with id `message` to display the result

In the JavaScript script, use `window.__TAURI__.tauri.invoke()` to call your Rust command. When the user clicks the button, call `invoke('greet', { name: 'World' })` asynchronously with `await`. Display the result in the `message` div and handle errors with `try/catch`.

**Detailed instructions:**
- `invoke('greet', { name: 'World' })` calls the `greet` function with the `name` parameter
- The result is returned asynchronously (use `await`)
- Handle errors with `try/catch` to display an error message if the call fails

**Expected result:**
- A window opens with title "Hello Tauri!"
- A "Click me!" button is visible
- When you click, the message "Hello, World! This message comes from Rust!" displays in the message div

### Step 1.5 - Launch the application

Launch the application in development mode with `npm run tauri dev`. Tauri will compile the Rust backend, launch a development server for the frontend, and open a window with your application.

### Step 1.6 - Bonus: Add a counter

For the bonus, add a counter that increments on each click.

**Backend:** Create an `AppState` structure with a `Mutex<u32>` to store the counter. Create two Tauri commands: `increment_counter` that increments and returns the value, and `get_counter` that returns the current value. Use `manage()` in the builder to register the state.

**Frontend:** Add a button with a span to display the counter. On page load, call `get_counter` to display the initial value. When the user clicks, call `increment_counter` and update the display with the new value.

**Detailed instructions for bonus:**
- Use `tauri::State<AppState>` in your commands to access the shared state
- `Mutex` protects concurrent access to the counter
- `manage()` registers the state in Tauri so it's accessible to commands

**Constraints to follow:**
- Create at least one Tauri command
- Communicate between frontend and backend
- Create a modern and attractive interface
- Handle errors in the frontend

📚 **Documentation:**

- [Tauri Commands](https://v2.tauri.app/fr/develop/command/)
- [Tauri Frontend API](https://v2.tauri.app/fr/reference/frontend/)
- [Tauri State Management](https://v2.tauri.app/fr/develop/state/)

✔️ **Validation:**

Votre application doit :
- ✅ S'ouvrir dans une fenêtre desktop
- ✅ Afficher une interface avec un bouton
- ✅ Appeler une commande Rust depuis le frontend
- ✅ Afficher le message retourné par Rust
- ✅ Avoir un design moderne et attrayant
- ✅ Avoir un compteur fonctionnel (bonus)

**Exemple d'utilisation complète :**
```bash
# Développement
npm run tauri dev

# Build de production
npm run tauri build
# Le binaire sera dans src-tauri/target/release/
```

## Step 2 - Simple Text Editor

📑 **Description:**

In this exercise, you'll create a text editor with file operations using Tauri. This will teach you how to work with the file system API, dialogs, and create a more complex GUI application.

📌 **What you need to do:**

### Step 2.1 - Create the editor interface

In your frontend, create a text editor interface with:
- A large textarea or contenteditable div for editing text
- A toolbar with buttons for New, Open, Save, Save As
- A status bar showing character count
- A menu bar (optional, can use Tauri's menu API)

Style the interface to look like a modern text editor.

### Step 2.2 - Implement file operations in Rust

Create Tauri commands for file operations:
- `read_file(path: String)` - Read file content and return as string
- `write_file(path: String, content: String)` - Write content to a file
- `get_file_path()` - Open a file dialog to select a file for opening
- `save_file_dialog()` - Open a save dialog to choose where to save

Use Tauri's file system plugin and dialog plugin. Handle errors gracefully and return proper error messages to the frontend.

### Step 2.3 - Implement New functionality

When the user clicks "New":
- Clear the text area
- Reset the current file path (if any)
- Update the window title

### Step 2.4 - Implement Open functionality

When the user clicks "Open":
- Call a Tauri command that opens a file dialog
- Get the selected file path
- Read the file content using another Tauri command
- Display the content in the text area
- Update the window title with the file name
- Handle errors (file not found, permissions, etc.)

### Step 2.5 - Implement Save functionality

When the user clicks "Save":
- If a file path is already set, save to that path
- If no path is set, call "Save As" instead
- Get the current text area content
- Call a Tauri command to write the file
- Handle errors gracefully

### Step 2.6 - Implement Save As functionality

When the user clicks "Save As":
- Open a save dialog to choose the file location
- Get the selected path
- Save the content to that path
- Update the current file path
- Update the window title

### Step 2.7 - Add character count

Create a Tauri command or calculate in the frontend to count characters in the text. Update the character count display in real-time as the user types. You can also add word count and line count.

**Constraints to follow:**
- Use Tauri's file system API for file operations
- Use Tauri's dialog API for file selection
- Handle all error cases (file not found, permissions, etc.)
- Update UI state appropriately (file path, unsaved changes indicator)
- Display character count

📚 **Documentation:**

- [Tauri File System API](https://v2.tauri.app/fr/plugin/fs/)
- [Tauri Dialog API](https://v2.tauri.app/fr/plugin/dialog/)

✔️ **Validation:**

Your editor must:
- ✅ Create new files
- ✅ Open existing files
- ✅ Save files
- ✅ Save files with a new name/path
- ✅ Display character count
- ✅ Handle file errors gracefully

## Step 3 - Password Manager GUI

📑 **Description:**

In this exercise, you'll create a GUI version of your password manager from Day 3. This will teach you how to integrate existing Rust backend code with a Tauri frontend and work with the clipboard API.

📌 **What you need to do:**

### Step 3.1 - Reuse your password manager backend

Import or adapt your password manager code from Day 3. Create Tauri commands that wrap your existing functionality:
- `add_password(service, username, password)` - Add a new password entry
- `get_password(service)` - Retrieve a password
- `list_services()` - Get list of all services
- `delete_service(service)` - Delete a service
- `generate_password(length)` - Generate a strong password

These commands should use your existing encryption and storage logic.

### Step 3.2 - Create the main interface

Design a modern interface with:
- A sidebar or list showing all services
- A main area with a form to add/edit entries
- A search field to filter services
- Password display area with show/hide toggle
- Copy to clipboard button

Use modern CSS styling to make it look professional and secure (dark theme works well for password managers).

### Step 3.3 - Implement service list

Display all services in a scrollable list. When a service is clicked:
- Load its details (username, password)
- Display them in the form area
- Allow editing

Highlight the selected service in the list.

### Step 3.4 - Implement add/edit form

Create a form with fields for:
- Service name
- Username/email
- Password (with show/hide toggle)
- Buttons: Save, Cancel, Delete

When saving, check if it's a new entry or editing an existing one, then call the appropriate Tauri command.

### Step 3.5 - Implement search functionality

Add a search field that filters the service list in real-time as the user types. Filter by service name (case-insensitive). Update the list display dynamically.

### Step 3.6 - Implement password visibility toggle

Add a button to show/hide the password. When hidden, display asterisks or dots. When shown, display the actual password. Toggle between states when the button is clicked.

### Step 3.7 - Implement copy to clipboard

Use Tauri's clipboard API to copy the password to the clipboard when the user clicks the copy button. Show a brief notification or visual feedback that the password was copied. Optionally, clear the clipboard after a timeout for security.

### Step 3.8 - Bonus: Integrated password generator

Add a password generator section:
- Input field for password length
- Button to generate password
- Display the generated password
- Option to automatically fill the password field with the generated password

Use your existing password generation logic from Day 3.

**Constraints to follow:**
- Reuse your Day 3 password manager backend code
- Use Tauri commands for all operations
- Use Tauri clipboard API for copying passwords
- Implement search functionality
- Handle errors gracefully
- Create a modern, secure-looking interface

📚 **Documentation:**

- [Tauri Clipboard API](https://v2.tauri.app/fr/plugin/clipboard/)
- [Tauri Store](https://v2.tauri.app/fr/plugin/store) (for data persistence)

✔️ **Validation:**

Your password manager GUI must:
- ✅ Display list of services
- ✅ Add new password entries
- ✅ Edit existing entries
- ✅ Delete entries
- ✅ Search/filter services
- ✅ Show/hide passwords
- ✅ Copy passwords to clipboard
- ✅ Generate passwords (bonus)

## Step 4 - File Reader

📑 **Description:**

In this exercise, you'll create a simple file explorer that allows browsing directories and viewing file contents. This will teach you how to work with Tauri's file system and path APIs.

📌 **What you need to do:**

### Step 4.1 - Create the explorer interface

Design an interface with:
- A sidebar showing a file tree or directory list
- Main area displaying the current directory's files
- An address bar showing the current path
- Navigation buttons (previous, next, up)
- A content area to display selected file contents

### Step 4.2 - Implement directory reading

Create Tauri commands:
- `list_directory(path: String)` - Lists files and directories in a given path
- `get_file_info(path: String)` - Gets file metadata (size, type, etc.)

Return file information including name, type (file/directory), and size. Handle errors for inaccessible directories.

### Step 4.3 - Build file tree

In the frontend, create a file tree component:
- Display directories and files hierarchically
- Show folder icons for directories
- Allow expanding/collapsing directories
- Click on a directory to navigate into it

You can build this recursively or use a tree component library. Update the tree when navigating to a new directory.

### Step 4.4 - Implement navigation

Implement navigation functionality:
- **Address bar**: Allow users to type a path and navigate to it. Validate the path before navigating.
- **Previous button**: Navigate to the previously visited directory (maintain history)
- **Next button**: Navigate forward in history
- **Up button**: Navigate to the parent directory
- **Click on directory**: Navigate into that directory

Maintain a history stack to enable back/forward navigation. Update the address bar when navigating.

### Step 4.5 - Display file content

When a file is selected:
- Determine the file type (text, image, etc.)
- Read the file content using a Tauri command
- Display the content in the content area
- Handle large files appropriately (show a message or limit display)

For text files, display the content in a readable format. Consider syntax highlighting for code files.

### Step 4.6 - Bonus: Preview images and text files

For the bonus, enhance file preview:
- **Images**: Display image previews directly in the content area
- **Text files**: Show formatted text with proper line breaks
- **Other files**: Show file information or a message that preview is not available

Use appropriate HTML elements (`<img>` for images, `<pre>` or code editor for text).

**Constraints to follow:**
- Use Tauri's file system API for reading directories
- Use Tauri's path API for path manipulation
- Support directory navigation
- Display file tree
- Show file contents
- Handle errors gracefully

📚 **Documentation:**

- [Tauri Path API](https://v2.tauri.app/fr/plugin/path/)
- [File Reading](https://v2.tauri.app/fr/plugin/fs/)

✔️ **Validation:**

Your file explorer must:
- ✅ Display file tree
- ✅ Navigate directories
- ✅ Show current path in address bar
- ✅ Support previous/next navigation
- ✅ Display file contents
- ✅ Preview images and text files (bonus)

## Step 5 - Scientific Calculator

📑 **Description:**

In this exercise, you'll create a scientific calculator with a graphical interface. This will teach you how to implement calculation logic in Rust and create an interactive UI with Tauri.

📌 **What you need to do:**

### Step 5.1 - Design the calculator interface

Create a calculator interface with:
- A display area showing the current number and expression
- Number buttons (0-9)
- Basic operator buttons (+, -, *, /, =)
- Scientific function buttons (sin, cos, tan, log, ln, sqrt, etc.)
- Special buttons (clear, backspace, parentheses)
- A history panel showing previous calculations

Style it to look like a modern scientific calculator with a clean, organized layout.

### Step 5.2 - Implement calculation logic in Rust

Create Tauri commands for calculations:
- `calculate(expression: String)` - Evaluates a mathematical expression
- `scientific_function(function: String, value: f64)` - Applies scientific functions (sin, cos, etc.)

Implement expression parsing and evaluation. You can use a simple recursive descent parser or use a library. Handle operator precedence correctly (multiplication before addition, etc.).

### Step 5.3 - Handle number input

In the frontend, manage calculator state:
- Current number being entered
- Current expression
- Whether a new number should start

When a number button is clicked, append the digit to the current number. When an operator is clicked, add it to the expression.

### Step 5.4 - Implement basic operations

Handle basic arithmetic operations:
- When an operator button is clicked, add it to the expression
- When equals is clicked, send the expression to Rust for evaluation
- Display the result
- Allow chaining operations (e.g., 5 + 3 * 2)

### Step 5.5 - Implement scientific functions

For scientific functions:
- When a function button is clicked (e.g., "sin"), apply it to the current number
- Display the result immediately
- Functions can work on the current number or be part of an expression

Implement functions like: sin, cos, tan, asin, acos, atan, log (base 10), ln (natural log), sqrt, power (x^y), etc.

### Step 5.6 - Implement calculation history

Maintain a history of calculations:
- Store each calculation as: expression = result
- Display history in a scrollable panel
- Allow clicking on history items to reuse them
- Limit history size (e.g., last 50 calculations)

Store history in the frontend (localStorage) or send to Rust for persistence.

### Step 5.7 - Handle errors

Implement error handling:
- Division by zero: Show an error message
- Invalid expressions: Show "Error" or "Invalid input"
- Overflow/underflow: Handle large numbers appropriately
- Invalid function inputs (e.g., sqrt of negative number): Show appropriate error

Display errors clearly in the calculator display.

### Step 5.8 - Add special features

Implement additional features:
- **Clear**: Reset calculator to initial state
- **Backspace**: Remove last entered digit
- **Parentheses**: Support nested parentheses in expressions
- **Decimal point**: Handle decimal numbers correctly
- **Negative numbers**: Support negative number input

**Constraints to follow:**
- Implement calculation logic in Rust (backend)
- Create a responsive, modern interface
- Handle all error cases (division by zero, invalid input, etc.)
- Support basic and scientific operations
- Maintain calculation history

📚 **Documentation:**

- [Rust Math](https://doc.rust-lang.org/std/primitive.f64.html#method.sin)
- [Expression Parsing](https://en.wikipedia.org/wiki/Shunting_yard_algorithm)

✔️ **Validation:**

Your calculator must:
- ✅ Perform basic arithmetic operations correctly
- ✅ Support scientific functions (sin, cos, log, etc.)
- ✅ Display calculation history
- ✅ Handle errors gracefully
- ✅ Have a modern, responsive interface

## Step 6 - System Monitor GUI

📑 **Description:**

In this exercise, you'll create a system monitoring application with Tauri that displays real-time system metrics with graphs. This will teach you how to collect system data in Rust and visualize it in a web frontend.

📌 **What you need to do:**

### Step 6.1 - Set up system information collection

In Rust, use the `sysinfo` crate to collect system metrics. Create Tauri commands:
- `get_cpu_usage()` - Returns current CPU usage percentage
- `get_memory_info()` - Returns used and total memory
- `get_disk_info()` - Returns disk usage information
- `get_processes()` - Returns list of processes with CPU and memory usage

Refresh system information before returning data. Use `sysinfo::System::refresh_all()` or refresh specific components.

### Step 6.2 - Design the monitoring interface

Create a dashboard interface with:
- CPU usage graph/chart
- Memory usage graph/chart
- Disk usage display
- Process list table
- System information summary (OS, uptime, etc.)

Use a modern dashboard design with cards/sections for each metric.

### Step 6.3 - Implement real-time graphs

Set up graphs using a charting library (Chart.js, Recharts, or similar):
- **CPU graph**: Line chart showing CPU usage over time
- **Memory graph**: Line chart showing memory usage over time
- Update graphs every second with new data points
- Keep a rolling history (e.g., last 60 data points)

In the frontend, set up an interval that calls Tauri commands every second to get updated metrics. Add new data points to the charts.

### Step 6.4 - Display process list

Create a process list table showing:
- Process name
- CPU usage percentage
- Memory usage
- Process ID
- Sort by CPU or memory usage (highest first)

Update the process list periodically. Allow sorting by different columns.

### Step 6.5 - Add system information

Display general system information:
- Operating system name and version
- CPU model and cores
- Total memory
- System uptime
- Current time

Create a Tauri command to get this information using `sysinfo`.

### Step 6.6 - Implement auto-refresh

Set up automatic refresh:
- Update all metrics every second
- Use `setInterval` in JavaScript to call Tauri commands
- Update graphs, process list, and system info
- Handle errors gracefully (don't stop refreshing on errors)

Consider pausing refresh when the window is minimized to save resources.

### Step 6.7 - Style the interface

Create a modern, professional monitoring interface:
- Use a dark theme (common for system monitors)
- Make graphs visually appealing with colors
- Use icons for different metrics
- Make the layout responsive
- Add hover effects and animations

**Constraints to follow:**
- Use `sysinfo` crate for system data
- Display real-time graphs for CPU and memory
- Show process list with usage
- Update every second automatically
- Use a charting library for graphs
- Handle errors gracefully

📚 **Documentation:**

- [sysinfo](https://docs.rs/sysinfo/)
- [Chart.js](https://www.chartjs.org/) or [Recharts](https://recharts.org/)

✔️ **Validation:**

Your monitor must:
- ✅ Display CPU usage in real-time graph
- ✅ Display memory usage in real-time graph
- ✅ Show disk usage information
- ✅ List processes with CPU and memory usage
- ✅ Update automatically every second
- ✅ Have a modern, professional design

## Step 7 - Markdown Notes Application

📑 **Description:**

In this exercise, you'll create a comprehensive markdown notes application with Tauri. This combines file management, markdown parsing, search, and export functionality.

📌 **What you need to do:**

### Step 7.1 - Set up note storage

Create Tauri commands for note management:
- `create_note(title, content)` - Create a new note file
- `save_note(path, content)` - Save note content to file
- `load_note(path)` - Load note content from file
- `list_notes()` - Get list of all note files
- `delete_note(path)` - Delete a note file
- `search_notes(query)` - Search notes by content or title

Store notes as markdown files in a notes directory. Use Tauri's file system API.

### Step 7.2 - Create the notes interface

Design an interface with:
- Sidebar showing note list
- Main editor area with markdown editing
- Preview pane showing rendered markdown
- Search bar at the top
- Tags section in sidebar

Use a split-pane layout or toggle between edit and preview modes.

### Step 7.3 - Implement markdown editor

Set up markdown editing:
- Use a markdown editor library (like CodeMirror with markdown mode)
- Or create a textarea with syntax highlighting
- Support markdown shortcuts
- Show line numbers

Handle large files appropriately (virtual scrolling or pagination).

### Step 7.4 - Implement markdown preview

Add markdown rendering:
- Use a markdown parser (frontend library like `marked` or Rust crate like `pulldown-cmark`)
- Convert markdown to HTML
- Style the rendered HTML to look like a document
- Update preview in real-time (debounce for performance)

If using Rust for parsing, create a Tauri command that takes markdown and returns HTML.

### Step 7.5 - Implement search

Add search functionality:
- Search bar that filters notes by title
- Full-text search within note content
- Highlight search results
- Show matching notes in the sidebar

Implement search in Rust for better performance, or in frontend for instant results.

### Step 7.6 - Add tags and categories

Implement tagging system:
- Allow adding tags to notes (store in frontmatter or metadata)
- Display tags on each note
- Filter notes by tag in sidebar
- Show tag list/cloud

Parse YAML frontmatter in markdown files to store tags, or use a separate metadata file.

### Step 7.7 - Implement export

Add export functionality:
- **Export to HTML**: Convert markdown to HTML and save
- **Export to PDF**: Use a library or service to convert HTML to PDF

Create Tauri commands for export. Generate properly formatted documents with styling.

### Step 7.8 - Implement auto-save

Add auto-save functionality:
- Save note content periodically (e.g., every 30 seconds)
- Or save on content change (debounced)
- Show save indicator
- Handle save errors gracefully

Track unsaved changes and warn before closing if there are unsaved changes.

### Step 7.9 - Bonus: Cloud synchronization

For the bonus, add cloud sync:
- Support syncing to cloud storage
- Or implement sync to a server
- Handle conflicts
- Sync automatically or on demand

**Constraints to follow:**
- Store notes as markdown files
- Support markdown editing and preview
- Implement search functionality
- Support tags/categories
- Export to HTML and PDF
- Auto-save notes
- Handle file errors gracefully

📚 **Documentation:**

- [Markdown Parsing](https://docs.rs/pulldown-cmark/) or frontend library
- [Tauri File System](https://v2.tauri.app/fr/plugin/fs/)

✔️ **Validation:**

Your notes app must:
- ✅ Create, edit, and delete notes
- ✅ Edit markdown with live preview
- ✅ Search notes by content
- ✅ Support tags and categories
- ✅ Export to HTML and PDF
- ✅ Auto-save notes
- ✅ Sync to cloud (bonus)

## Step 8 - Make it the Cutest Code You've Ever Seen

📑 **Description:**

Polish your GUI application with good UX and error handling.

📌 **Tasks:**

1. Add loading states
2. Handle errors gracefully
3. Add animations/transitions
4. Improve responsive design
5. Add keyboard shortcuts
6. Test on different window sizes

📚 **Documentation:**

- [Tauri Best Practices](https://v2.tauri.app/fr/develop/)
- [Error Handling](https://tauritutorials.com/blog/handling-errors-in-tauri)

✔️ **Validation:**

Your application should have a polished, professional feel.

## Bonus Challenge

📑 **Description:**

Create a **desktop chat application**.

📌 **Tasks:**

Create a desktop chat application with:
- Modern chat interface
- Connect to a server (WebSocket or HTTP)
- Contact list
- Message history
- System notifications
- Tray icon with new message indicator
- Dark/light theme

**Estimated time**: 4-5 hours

📚 **Documentation:**

- [Tauri Tray](https://v2.tauri.app/fr/learn/system-tray/)
- [Tauri Notifications](https://v2.tauri.app/fr/plugin/notification/)

## 📚 Additional Resources

- [Tauri Examples](https://github.com/tauri-apps/tauri/tree/dev/examples)
- [Iced Examples](https://github.com/iced-rs/iced/tree/master/examples)
- [Desktop App Design](https://www.figma.com/community)

## ✅ End of Day Checklist

- [ ] I've created a functional Tauri application
- [ ] I've implemented frontend-backend communication
- [ ] I've created multiple Tauri commands
- [ ] My application has a modern interface
- [ ] I've handled errors properly
- [ ] My application is packaged and executable
- [ ] I've used system APIs (files, etc.)

## 💡 Tips

- Use `tauri dev` for development
- `tauri build` to create the executable
- Organize your Rust code into modules
- Use a modern frontend framework (React/Vue/Svelte)
- Test on different window sizes
- Think about user experience
- Keep the backend logic in Rust, UI in frontend

---

<h2 align=center>
Organization
</h2>
<br/>
<p align='center'>
    <a href="https://www.linkedin.com/company/pocinnovation/mycompany/">
        <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn logo">
    </a>
    <a href="https://www.instagram.com/pocinnovation/">
        <img src="https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white" alt="Instagram logo">
    </a>
    <a href="https://twitter.com/PoCInnovation">
        <img src="https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white" alt="Twitter logo">
    </a>
    <a href="https://discord.com/invite/Yqq2ADGDS7">
        <img src="https://img.shields.io/badge/Discord-7289DA?style=for-the-badge&logo=discord&logoColor=white" alt="Discord logo">
    </a>
</p>
<p align=center>
    <a href="https://www.poc-innovation.fr/">
        <img src="https://img.shields.io/badge/WebSite-1a2b6d?style=for-the-badge&logo=GitHub Sponsors&logoColor=white" alt="Website logo">
    </a>
</p>

> 🚀 Don't hesitate to follow us on our different networks, and put a star 🌟 on `PoC's` repositories.

---

**Good luck and happy coding! 💪**
