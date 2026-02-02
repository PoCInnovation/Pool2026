# ⚙️ Day 05 - Software Track: Electron

Welcome to Day 5 of the Software Pool 2026! 🚀

Last day before the rush! Today, you'll discover Electron to create cross-platform desktop applications with web technologies.

## Day Purposes

✔️ Understand Electron architecture

✔️ Create an Electron application

✔️ Manage main and renderer processes

✔️ Use Electron APIs (files, notifications, etc.)

✔️ Package an application

✔️ Create a complete application

## Introduction

### Why Electron?

Electron enables you to build desktop apps with web technologies:
- **Web technologies** - Use HTML, CSS, JavaScript you already know
- **Cross-platform** - One codebase for Windows, macOS, Linux
- **Rich ecosystem** - Access to npm packages
- **Native features** - File system, notifications, menus
- **Popular apps** - VS Code, Discord, Slack use Electron

### Electron Architecture

- **Main Process** - Node.js process that controls app lifecycle
- **Renderer Process** - Chromium process that displays UI
- **IPC** - Inter-process communication between main and renderer
- **Preload Scripts** - Secure bridge between processes

## Warm Up

Before starting, familiarize yourself with:

1. **Node.js Basics**:
   - Modules and require
   - File system operations
   - Events

2. **Electron Concepts**:
   - Main vs Renderer process
   - IPC communication
   - BrowserWindow

3. **Security**:
   - Context isolation
   - Node integration
   - CSP (Content Security Policy)

Here are useful links:

- [Electron Documentation](https://www.electronjs.org/docs)
- [Electron Security](https://www.electronjs.org/docs/tutorial/security)
- [IPC Communication](https://www.electronjs.org/docs/tutorial/ipc)

## Step 0 - Setup

📑 **Description:**

Set up your Electron development environment.

📌 **Tasks:**

1. Create a new project:
```bash
mkdir electron-app
cd electron-app
npm init -y
npm install --save-dev electron
```

2. Create `main.js`:
```javascript
const { app, BrowserWindow } = require('electron');

function createWindow() {
  const win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true
    }
  });

  win.loadFile('index.html');
}

app.whenReady().then(createWindow);
```

3. Update `package.json`:
```json
{
  "main": "main.js",
  "scripts": {
    "start": "electron ."
  }
}
```

📚 **Documentation:**

- [Electron Quick Start](https://www.electronjs.org/docs/latest/tutorial/tutorial-first-app)

✔️ **Validation:**

Run `npm start` and you should see a window open.

## Step 1 - Basic Electron Application

📑 **Description:**

In this exercise, you'll create your first Electron application. Electron allows you to create desktop applications with web technologies (HTML, CSS, JavaScript). You'll learn Electron's architecture with main and renderer processes, and IPC communication between them.

📌 **What you need to do:**

### Step 1.1 - Initialize the project

1. Create a new folder and initialize npm:
```bash
mkdir electron-hello
cd electron-hello
npm init -y
```

2. Install Electron as a development dependency:
```bash
npm install --save-dev electron
```

3. Create the base structure:
```
electron-hello/
├── main.js          # Main process
├── preload.js       # Preload script (secure bridge)
├── index.html       # User interface
├── renderer.js      # Renderer process code
└── package.json
```

**Why this structure?**
- `main.js`: Controls the application lifecycle
- `preload.js`: Secure bridge between main and renderer
- `index.html`: User interface
- `renderer.js`: Interface logic

### Step 1.2 - Configure package.json

Modify `package.json` to add the start script:

```json
{
  "name": "electron-hello",
  "version": "1.0.0",
  "main": "main.js",
  "scripts": {
    "start": "electron .",
    "dev": "electron ."
  }
}
```

**Detailed instructions:**
- `"main"`: Application entry point (the main.js file)
- `"start"`: Script to launch the application

### Step 1.3 - Create the main process (main.js)

Create `main.js` with a `createWindow()` function that creates a `BrowserWindow` with width 800px and height 600px. Configure `webPreferences` with `preload` pointing to `preload.js`, `contextIsolation: true` and `nodeIntegration: false` for security. Load `index.html` with `loadFile()`.

Create a `createMenu()` function that builds a custom menu with `Menu.buildFromTemplate()`. The menu must contain at minimum:
- A "File" menu with New, Open, and Quit options (with keyboard shortcuts)
- An "Edit" menu with Undo, Redo, Cut, Copy, Paste
- A "Help" menu with an "About" option that displays a dialog with `dialog.showMessageBox()`

In `app.whenReady()`, call `createWindow()` and `createMenu()`. Handle the `window-all-closed` event to quit the application (except on macOS where it needs different handling).

**Why these security settings?**
- `contextIsolation: true`: Isolates the renderer context to avoid security leaks
- `nodeIntegration: false`: Prevents direct access to Node.js from the renderer
- `preload`: Allows exposing APIs securely via `contextBridge`

### Step 1.4 - Create the preload script (preload.js)

Create `preload.js` that uses `contextBridge.exposeInMainWorld()` to expose an `electronAPI` object to the renderer. This object must contain:
- `sendMessage(message)`: Uses `ipcRenderer.invoke('send-message', message)` to send a message to the main process
- `onMessage(callback)`: Uses `ipcRenderer.on('message-from-main', ...)` to listen for messages from the main process
- `getVersion()`: Uses `ipcRenderer.invoke('get-version')` to get the application version

**Why use preload?** It's the secure method recommended by Electron for communicating between main and renderer, avoiding direct exposure of Node.js to the renderer.

### Step 1.5 - Create the interface (index.html)

Create `index.html` with a simple interface containing:
- A title "Hello Electron!"
- Two buttons: "Send message" and "Show version"
- A div with id `message` to display results

Add a `renderer.js` file that will be loaded in the HTML. In this file, retrieve DOM elements and add event listeners on the buttons. When the user clicks, use `window.electronAPI` (exposed by preload) to call functions asynchronously with `await`. Display results in the message div and handle errors.

### Step 1.6 - Create the renderer code (renderer.js)

In `renderer.js`, create event listeners for the buttons. When the user clicks "Send message", call `window.electronAPI.sendMessage()` with a test message. When they click "Show version", call `window.electronAPI.getVersion()`. Display results in the message div.

Also add a listener for `window.electronAPI.onMessage()` that displays messages received from the main process in the message div.

### Step 1.7 - Add IPC handlers in main.js

In `main.js`, add IPC handlers with `ipcMain.handle()`:
- `send-message`: Receives a message, displays it in the console, and returns a response
- `get-version`: Returns `app.getVersion()`

Also add an example that sends a message to the renderer after 3 seconds with `mainWindow.webContents.send('message-from-main', ...)` to demonstrate communication in the other direction.

### Étape 1.8 - Lancer l'application

Lancez l'application :

```bash
npm start
```

**Résultat attendu :**
- Une fenêtre s'ouvre avec le titre "Hello Electron"
- Un menu personnalisé est disponible
- Les boutons fonctionnent et communiquent avec le main process
- Après 3 secondes, un message arrive du main process

**Bonus - Ajouter une boîte de dialogue :**

Dans `preload.js`, ajoutez :
```javascript
openDialog: () => ipcRenderer.invoke('open-dialog'),
```

Dans `main.js`, ajoutez :
```javascript
ipcMain.handle('open-dialog', async () => {
  const { dialog } = require('electron');
  const result = await dialog.showMessageBox(mainWindow, {
    type: 'question',
    buttons: ['Oui', 'Non'],
    title: 'Question',
    message: 'Voulez-vous continuer?',
  });
  return result.response === 0;
});
```

Dans `renderer.js`, ajoutez un bouton qui appelle `window.electronAPI.openDialog()`.

**Contraintes à respecter :**
- Utilisez `contextIsolation: true` et `nodeIntegration: false` pour la sécurité
- Créez un menu personnalisé
- Implémentez la communication IPC entre main et renderer
- Créez une interface moderne et attrayante

📚 **Documentation:**

- [BrowserWindow](https://www.electronjs.org/docs/api/browser-window)
- [Menu](https://www.electronjs.org/docs/api/menu)
- [IPC Main](https://www.electronjs.org/docs/api/ipc-main)
- [IPC Renderer](https://www.electronjs.org/docs/api/ipc-renderer)
- [Context Bridge](https://www.electronjs.org/docs/tutorial/context-isolation)

✔️ **Validation:**

Votre application doit :
- ✅ S'ouvrir dans une fenêtre desktop
- ✅ Avoir un menu personnalisé fonctionnel
- ✅ Communiquer via IPC entre main et renderer
- ✅ Afficher des messages dans l'interface
- ✅ Avoir un design moderne et attrayant
- ✅ Ouvrir une boîte de dialogue (bonus)

**Exemple d'utilisation complète :**
```bash
# Développement
npm start

# Build de production (avec electron-builder)
npm install --save-dev electron-builder
# Ajoutez "build" script dans package.json
npm run build
```

## Step 2 - Text Editor with Electron

📑 **Description:**

In this exercise, you'll create a complete text editor with Electron. This will teach you how to work with file dialogs, manage multiple documents, and implement advanced editor features.

📌 **What you need to do:**

### Step 2.1 - Set up the editor interface

Create an HTML interface with:
- A textarea or use a code editor library (like CodeMirror or Monaco Editor) for better editing experience
- A toolbar with buttons for New, Open, Save
- A tab bar for multiple open files
- A status bar showing line numbers, column position
- Menu bar (use Electron's Menu API)

### Step 2.2 - Implement file operations

In the main process, create IPC handlers for:
- `open-file-dialog` - Opens a file dialog and returns the selected file path
- `save-file-dialog` - Opens a save dialog and returns the selected path
- `read-file(path)` - Reads file content
- `write-file(path, content)` - Writes content to a file

Use Electron's `dialog` API and Node.js `fs` module. Handle errors and return them to the renderer process.

### Step 2.3 - Implement tab system

Create a tab management system:
- Track open files with their paths and content
- Display tabs in the UI
- Allow switching between tabs
- Show which tab is active
- Allow closing tabs (with unsaved changes check)

Store tab data in the renderer process. When switching tabs, save current content and load the new tab's content.

### Step 2.4 - Implement New, Open, Save

**New**: Create a new empty tab. Generate a unique identifier for untitled files.

**Open**:
- Open file dialog via IPC
- Read file content
- Create a new tab with the file content
- Track the file path for this tab

**Save**:
- If file path exists, save directly
- If no path (new file), open save dialog first
- Write content to file
- Update tab title with file name
- Mark tab as saved

### Step 2.5 - Implement search and replace

Add a search/replace panel:
- Search field to find text in the current tab
- Replace field and replace button
- Highlight search results
- Navigate between matches (next/previous)
- Replace all functionality

Implement search in the frontend using JavaScript. Highlight matches visually and scroll to them.

### Step 2.6 - Add line numbers

If using a simple textarea, implement line numbers:
- Create a separate div showing line numbers
- Sync scrolling between line numbers and textarea
- Update line numbers when content changes

Alternatively, use a code editor library that includes line numbers.

### Step 2.7 - Implement auto-save

Add auto-save functionality:
- Save current file periodically (e.g., every 30 seconds)
- Only auto-save if file has a path (not untitled files)
- Show a subtle indicator when auto-saving
- Handle auto-save errors gracefully

### Step 2.8 - Handle unsaved changes

Track unsaved changes for each tab:
- Mark tab as modified when content changes
- Show indicator (asterisk or dot) on modified tabs
- Before closing tab or opening new file, check for unsaved changes
- Show confirmation dialog if there are unsaved changes
- Allow user to save, discard, or cancel

**Constraints to follow:**
- Use Electron's dialog API for file operations
- Support multiple tabs
- Implement search and replace
- Show line numbers
- Handle unsaved changes
- Auto-save functionality

📚 **Documentation:**

- [Dialog API](https://www.electronjs.org/docs/api/dialog)
- [File System](https://nodejs.org/api/fs.html)
- [CodeMirror](https://codemirror.net/) or [Monaco Editor](https://microsoft.github.io/monaco-editor/) (optional)

✔️ **Validation:**

Your editor must:
- ✅ Create, open, and save files
- ✅ Support multiple tabs
- ✅ Search and replace text
- ✅ Display line numbers
- ✅ Handle unsaved changes
- ✅ Auto-save files

## Step 3 - File Manager

📑 **Description:**

In this exercise, you'll create a file explorer application with Electron. This will teach you how to work with the file system, handle directory navigation, and implement file operations.

📌 **What you need to do:**

### Step 3.1 - Create the file manager interface

Design an interface with:
- A sidebar showing the directory tree or bookmarks
- Main area showing files and folders in the current directory
- Address bar showing the current path
- Toolbar with navigation buttons (back, forward, up)
- View toggle buttons (list/grid)

### Step 3.2 - Implement directory reading

In the main process, create IPC handlers:
- `read-directory(path)` - Reads directory contents and returns files/folders
- `get-file-info(path)` - Gets file metadata (size, modified date, etc.)

Use Node.js `fs` module to read directories. Return file information including name, type (file/directory), size, and modification date.

### Step 3.3 - Display file tree

In the renderer, create a file tree component:
- Display directories and files hierarchically
- Show folder icons for directories, file icons for files
- Allow expanding/collapsing directories
- Highlight the current directory

You can implement this recursively or use a tree component library.

### Step 3.4 - Implement navigation

Implement navigation functionality:
- **Address bar**: Allow typing a path and navigating to it
- **Back button**: Navigate to previous directory (maintain history)
- **Forward button**: Navigate forward in history
- **Up button**: Navigate to parent directory
- **Click on folder**: Navigate into that folder

Maintain a history stack to enable back/forward navigation.

### Step 3.5 - Implement list/grid view

Create two view modes:
- **List view**: Show files in a table with columns (name, size, date, type)
- **Grid view**: Show files as icons/cards in a grid layout

Add toggle buttons to switch between views. Store the preference (localStorage).

### Step 3.6 - Implement file operations

Add file operation handlers in main process:
- `copy-file(source, destination)` - Copy a file
- `move-file(source, destination)` - Move/rename a file
- `delete-file(path)` - Delete a file or directory
- `create-directory(path)` - Create a new directory

Use Node.js `fs` operations. Handle errors and return success/error status to renderer.

### Step 3.7 - Add context menu

Implement a context menu (right-click) with options:
- Open
- Copy
- Cut
- Paste
- Delete
- Rename
- Properties

Use Electron's context menu API or create a custom menu in the renderer.

### Step 3.8 - Bonus: File preview

For the bonus, add file preview:
- **Text files**: Show content in a preview pane
- **Images**: Display image preview
- **Other files**: Show file information

Create IPC handlers to read file content. For images, you can display them directly. For text files, read and display content with syntax highlighting (optional).

**Constraints to follow:**
- Use Node.js fs module for file operations
- Support directory navigation
- Display files and folders clearly
- Implement copy, move, delete operations
- Support list and grid views
- Handle errors gracefully

📚 **Documentation:**

- [File System API](https://nodejs.org/api/fs.html)
- [Path API](https://nodejs.org/api/path.html)
- [Electron Context Menu](https://www.electronjs.org/docs/api/menu)

✔️ **Validation:**

Your file manager must:
- ✅ Display directory tree
- ✅ Navigate directories
- ✅ Show files in list and grid views
- ✅ Copy, move, and delete files
- ✅ Handle navigation history
- ✅ Preview files (bonus)

## Step 4 - Markdown Notes Application

📑 **Description:**

In this exercise, you'll create a markdown notes application with Electron. This will teach you how to work with markdown parsing, file management, and system tray integration.

📌 **What you need to do:**

### Step 4.1 - Set up the notes interface

Create an interface with:
- A sidebar showing the list of notes
- A main editor area with markdown editing
- A preview pane showing rendered markdown
- A search bar
- Tags/categories section

Design it similar to popular markdown editors (like Typora or Obsidian).

### Step 4.2 - Implement note storage

Create IPC handlers for note management:
- `create-note(title, content)` - Create a new note
- `save-note(id, content)` - Save note content
- `load-note(id)` - Load a note by ID
- `list-notes()` - Get all notes
- `delete-note(id)` - Delete a note
- `search-notes(query)` - Search notes by content or title

Store notes as markdown files in a directory (e.g., `notes/` folder). Use file system operations to manage notes.

### Step 4.3 - Implement markdown editor

Set up a markdown editor:
- Use a markdown editor library (like CodeMirror with markdown mode, or SimpleMDE)
- Or create a simple textarea with markdown syntax highlighting
- Show line numbers
- Support markdown shortcuts (bold, italic, links, etc.)

### Step 4.4 - Implement markdown preview

Add markdown preview functionality:
- Parse markdown content using a library like `marked` or `markdown-it`
- Render HTML from markdown
- Update preview in real-time as user types (debounce for performance)
- Style the preview to look like a document

You can use a split view (editor on left, preview on right) or toggle between edit/preview modes.

### Step 4.5 - Implement search

Add search functionality:
- Search bar that filters notes by title or content
- Highlight search results in the note list
- Search within note content and highlight matches
- Support case-sensitive/insensitive search

Implement search in the renderer process for instant results, or use IPC for searching file contents.

### Step 4.6 - Add tags and categories

Implement tagging system:
- Allow adding tags to notes
- Display tags on each note in the list
- Filter notes by tag
- Show tag cloud or tag list in sidebar

Store tags in note metadata (frontmatter in markdown or separate metadata file).

### Step 4.7 - Implement export functionality

Add export options:
- **Export to HTML**: Convert markdown to HTML and save
- **Export to PDF**: Use a library like `puppeteer` or `electron-pdf` to generate PDF
- Add export menu items or buttons

Create IPC handlers for export operations. Generate properly formatted documents.

### Step 4.8 - Add system tray

Implement a system tray icon:
- Create a tray icon with a menu
- Menu options: New Note, Show/Hide Window, Quit
- Show notification when creating a note from tray
- Minimize to tray option

Use Electron's Tray API. Handle window show/hide when clicking tray icon.

### Step 4.9 - Bonus: Cloud synchronization

For the bonus, add cloud sync:
- Support syncing to cloud storage (Google Drive, Dropbox, etc.)
- Or implement a simple sync server
- Sync notes automatically or on demand
- Handle conflicts (multiple devices editing same note)

**Constraints to follow:**
- Store notes as markdown files
- Support markdown editing and preview
- Implement search functionality
- Support tags/categories
- Export to HTML and PDF
- Add system tray integration
- Handle file errors gracefully

📚 **Documentation:**

- [Tray API](https://www.electronjs.org/docs/api/tray)
- [Markdown Parsing](https://www.npmjs.com/package/marked)
- [File System](https://nodejs.org/api/fs.html)

✔️ **Validation:**

Your notes app must:
- ✅ Create, edit, and delete notes
- ✅ Edit markdown with live preview
- ✅ Search notes
- ✅ Support tags and categories
- ✅ Export to HTML and PDF
- ✅ Have system tray with menu
- ✅ Sync to cloud (bonus)

## Step 5 - Music Player

📑 **Description:**

In this exercise, you'll create a music player application with Electron. This will teach you how to work with audio playback, metadata extraction, and create a modern media player interface.

📌 **What you need to do:**

### Step 5.1 - Design the player interface

Create a modern music player interface inspired by Spotify:
- A sidebar with library/playlists
- Main area showing current track info and album art
- Bottom player bar with controls and progress
- Playlist view showing tracks
- Search functionality

Use modern CSS with gradients, shadows, and smooth animations.

### Step 5.2 - Implement audio playback

Set up audio playback in the renderer:
- Use HTML5 `<audio>` element or Web Audio API
- Create audio controls: play, pause, next, previous
- Implement progress bar that shows current position
- Allow seeking by clicking on progress bar
- Display current time and total duration

Handle audio events (ended, timeupdate, etc.) to update UI and auto-play next track.

### Step 5.3 - Implement playlist management

Create playlist functionality:
- Add files to playlist (support drag & drop or file picker)
- Display playlist with track names, artists, duration
- Allow reordering tracks (drag & drop)
- Remove tracks from playlist
- Save/load playlists

Store playlist data (file paths) in localStorage or a JSON file. Use IPC to read audio files from the file system.

### Step 5.4 - Extract audio metadata

Extract metadata from audio files:
- Use `music-metadata` npm package to read ID3 tags
- Extract: title, artist, album, duration, album art
- Display metadata in the UI
- Show album art if available

Create IPC handlers to read metadata. Cache metadata to avoid re-reading files.

### Step 5.5 - Implement playback controls

Implement all playback controls:
- **Play/Pause**: Toggle playback
- **Next**: Play next track in playlist (loop to start if at end)
- **Previous**: Play previous track (or restart current if less than 3 seconds in)
- **Shuffle**: Randomize playlist order
- **Repeat**: Repeat current track or entire playlist
- **Volume**: Control volume with slider

Update UI state based on playback status (playing/paused, current track, etc.).

### Step 5.6 - Add progress bar and time display

Implement progress tracking:
- Show progress bar indicating current playback position
- Display current time (e.g., "1:23") and total duration (e.g., "3:45")
- Allow seeking by clicking/dragging on progress bar
- Update progress in real-time during playback

Use the audio element's `currentTime` and `duration` properties.

### Step 5.7 - Implement visual equalizer

Add a visual equalizer (optional, can be simplified):
- Display frequency bars that animate during playback
- Use Web Audio API to analyze audio frequencies
- Create bars that react to music (can be simulated if Web Audio API is complex)
- Make it visually appealing

For a simpler version, create animated bars that react to playback state without actual frequency analysis.

### Step 5.8 - Add library management

Implement music library:
- Scan a directory for audio files
- Organize by artist, album, or genre
- Display library in sidebar
- Add tracks from library to playlist
- Support multiple audio formats (mp3, flac, ogg, etc.)

Create IPC handlers to scan directories and filter audio files by extension.

### Step 5.9 - Add system tray controls

Implement system tray with playback controls:
- Tray icon showing play/pause state
- Tray menu with: Play/Pause, Next, Previous, Show Window, Quit
- Update tray icon based on playback state
- Show notification when track changes (optional)

Use Electron's Tray API. Update menu items dynamically based on playback state.

**Constraints to follow:**
- Support multiple audio formats
- Extract and display metadata
- Implement full playback controls
- Create modern, Spotify-style design
- Add system tray integration
- Handle file errors gracefully

📚 **Documentation:**

- [HTML Audio API](https://developer.mozilla.org/en-US/docs/Web/API/HTMLAudioElement)
- [Media Metadata](https://www.npmjs.com/package/music-metadata)
- [Web Audio API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API) (for equalizer)

✔️ **Validation:**

Your music player must:
- ✅ Play audio files
- ✅ Display playlist
- ✅ Show playback controls (play, pause, next, previous)
- ✅ Display progress bar and time
- ✅ Extract and show metadata
- ✅ Support multiple audio formats
- ✅ Have system tray with controls
- ✅ Visual equalizer (optional)

## Step 6 - Desktop Chat Application

📑 **Description:**

In this exercise, you'll create a desktop chat application with Electron. This will teach you how to work with WebSockets, real-time communication, and system notifications.

📌 **What you need to do:**

### Step 6.1 - Design the chat interface

Create a modern chat interface:
- Message area showing conversation history
- Input area for typing messages
- Contact/user list sidebar
- User status indicators (online/offline)
- Message timestamps
- Send button and enter key support

Style it similar to modern chat apps (Discord, Slack, etc.).

### Step 6.2 - Set up WebSocket connection

Implement WebSocket client:
- Connect to a WebSocket server (you can use a public test server or create a simple one)
- Handle connection events (open, close, error)
- Send messages to server
- Receive messages from server
- Reconnect on disconnect

Use the browser's WebSocket API in the renderer process. Handle connection errors gracefully.

### Step 6.3 - Implement message sending and receiving

Create message handling:
- **Send message**: When user types and sends, format message and send via WebSocket
- **Receive message**: When message received, add to conversation
- Display messages with sender name, timestamp, and content
- Distinguish between your messages and others' (different styling)
- Scroll to bottom when new messages arrive

Format messages as JSON with fields: sender, content, timestamp, type.

### Step 6.4 - Implement contact list

Create contact/user management:
- Display list of users/contacts in sidebar
- Show online/offline status
- Highlight active conversation
- Allow selecting a contact to chat with
- Show unread message indicators

If using a simple server, you may need to implement user authentication and contact management.

### Step 6.5 - Add system notifications

Implement desktop notifications:
- Show notification when new message arrives (if window not focused)
- Include sender name and message preview
- Click notification to focus window
- Handle notification permissions

Use Electron's Notification API. Check if window is focused before showing notification.

### Step 6.6 - Add system tray with badge

Implement system tray:
- Create tray icon
- Show unread message count as badge on tray icon
- Tray menu: Show/Hide Window, Mark as Read, Quit
- Click tray icon to show/hide window
- Update badge count when messages arrive

Use Electron's Tray API. Update badge dynamically based on unread count.

### Step 6.7 - Implement dark/light theme

Add theme switching:
- Toggle button to switch between dark and light themes
- Store theme preference (localStorage)
- Apply theme to all UI elements
- Smooth transition between themes

Use CSS variables or a theme system to switch colors easily.

### Step 6.8 - Bonus: Additional features

For the bonus, add:
- **File support**: Allow sending/receiving files
- **Emojis**: Emoji picker and emoji support in messages
- **Reactions**: React to messages with emojis
- **Message editing**: Edit sent messages
- **Message deletion**: Delete messages

**Constraints to follow:**
- Connect to WebSocket server
- Send and receive messages
- Display contact list
- Show system notifications
- Add system tray with badge
- Support dark/light theme
- Handle connection errors gracefully

📚 **Documentation:**

- [WebSocket](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket)
- [Notifications API](https://www.electronjs.org/docs/api/notification)
- [Tray API](https://www.electronjs.org/docs/api/tray)

✔️ **Validation:**

Your chat app must:
- ✅ Connect to WebSocket server
- ✅ Send and receive messages
- ✅ Display contact list
- ✅ Show system notifications for new messages
- ✅ Have system tray with unread badge
- ✅ Support dark/light theme
- ✅ Handle connection errors
- ✅ Support files, emojis, reactions (bonus)

## Step 7 - System Dashboard

📑 **Description:**

In this exercise, you'll create a system dashboard application with Electron that monitors system resources in real-time. This will teach you how to use Node.js system APIs and create data visualizations.

📌 **What you need to do:**

### Step 7.1 - Collect system metrics

In the main process, create IPC handlers to collect system information:
- `get-cpu-usage()` - Get current CPU usage
- `get-memory-info()` - Get memory statistics
- `get-disk-info()` - Get disk usage
- `get-processes()` - Get process list with resource usage

Use the `systeminformation` npm package or Node.js `os` module. The `systeminformation` package provides more detailed information and is easier to use.

### Step 7.2 - Design the dashboard interface

Create a dashboard layout with:
- CPU usage card with graph
- Memory usage card with graph
- Disk usage card
- Process list table
- System information panel
- Alert/notification area

Use a grid layout with cards for each metric. Make it look like a professional monitoring dashboard.

### Step 7.3 - Implement real-time graphs

Set up graphs using Chart.js or similar:
- **CPU graph**: Line chart showing CPU usage over time
- **Memory graph**: Line chart or area chart showing memory usage
- Update graphs every second with new data points
- Keep a rolling history (e.g., last 60-120 data points)
- Use different colors for different metrics

In the renderer, set up an interval that calls IPC handlers every second to get updated metrics.

### Step 7.4 - Display process list

Create a process table showing:
- Process name
- CPU usage percentage
- Memory usage
- Process ID
- Status

Sort by CPU or memory usage (highest first). Update the list periodically. Allow sorting by different columns.

### Step 7.5 - Implement performance history

Store and display historical data:
- Keep history of metrics over time
- Display trends (increasing/decreasing)
- Show peak usage times
- Optionally, persist history to a file

Store history in memory or use a database/file for persistence. Display historical trends in graphs.

### Step 7.6 - Add alert notifications

Implement alert system:
- Set thresholds for CPU, memory, disk usage
- Show desktop notification when threshold exceeded
- Display alerts in the dashboard
- Allow configuring thresholds

Use Electron's Notification API. Check metrics against thresholds and trigger alerts.

### Step 7.7 - Add system tray

Implement system tray:
- Create tray icon
- Show summary in tray menu (CPU %, Memory %)
- Tray menu: Show Dashboard, Settings, Quit
- Update tray tooltip with current metrics
- Click to show/hide window

Use Electron's Tray API. Update menu/tooltip periodically with current metrics.

### Step 7.8 - Style the dashboard

Create a modern, professional dashboard:
- Use a dark theme (common for dashboards)
- Make graphs visually appealing
- Use color coding (green for normal, yellow for warning, red for critical)
- Add hover effects and animations
- Make layout responsive

**Constraints to follow:**
- Use Node.js system APIs or `systeminformation` package
- Display CPU, RAM, and Disk monitoring
- Show real-time graphs
- List processes with usage
- Store performance history
- Show alert notifications
- Add system tray with summary
- Update in real-time

📚 **Documentation:**

- [os Module](https://nodejs.org/api/os.html)
- [systeminformation](https://www.npmjs.com/package/systeminformation)
- [Chart.js](https://www.chartjs.org/)

✔️ **Validation:**

Your dashboard must:
- ✅ Display CPU, RAM, and Disk usage
- ✅ Show real-time graphs
- ✅ List processes with resource usage
- ✅ Store and display performance history
- ✅ Show alert notifications
- ✅ Have system tray with summary
- ✅ Update automatically
- ✅ Have a modern, professional design

## Step 8 - Make it the Cutest Code You've Ever Seen

📑 **Description:**

Package and optimize your Electron application.

📌 **Tasks:**

1. Use Electron Builder or Electron Forge
2. Create installers for your platform
3. Add application icon
4. Configure auto-updater (optional)
5. Test on different platforms
6. Optimize bundle size

📚 **Documentation:**

- [Electron Builder](https://www.electron.build/)
- [Electron Forge](https://www.electronforge.io/)
- [Code Signing](https://www.electronjs.org/docs/tutorial/code-signing)

✔️ **Validation:**

Your application should be packaged and distributable.

## Bonus Challenge

📑 **Description:**

Create a **development application** (simplified VS Code-style).

📌 **Tasks:**

Create a development app with:
- Code editor with syntax highlighting
- File explorer
- Integrated terminal
- Customizable themes
- System extensions (optional)
- Modern and professional design

**Estimated time**: 4-5 hours

📚 **Documentation:**

- [Monaco Editor](https://microsoft.github.io/monaco-editor/) or [CodeMirror](https://codemirror.net/)
- [xterm.js](https://xtermjs.org/) (for terminal)

## 📚 Additional Resources

- [Electron Best Practices](https://www.electronjs.org/docs/tutorial/performance)
- [Electron Security](https://www.electronjs.org/docs/tutorial/security)
- [Electron Examples](https://github.com/electron/electron/tree/main/docs/fiddles)

## ✅ End of Day Checklist

- [ ] I've created a functional Electron application
- [ ] I've used IPC communication
- [ ] I've used multiple Electron APIs
- [ ] My application has a custom menu
- [ ] I've handled security (context isolation)
- [ ] I've packaged my application
- [ ] My application works on multiple OS

## 💡 Tips

- Use Electron Forge for quick setup
- Always enable context isolation for security
- Use preload scripts to expose secure APIs
- Test on different platforms
- Optimize performance (lazy loading)
- Think about native user experience
- Keep main process code minimal
- Use native modules when possible for performance

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

**Good luck for the rush tomorrow! 💪**
