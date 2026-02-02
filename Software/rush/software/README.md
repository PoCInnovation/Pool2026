# 🏁 Rush Weekend - Software Track

Welcome to the **Rush Weekend**! This is the moment to put into practice everything you've learned this week. You're going to create a complete desktop application with Rust and/or Electron.

## 🎯 Rush Objective

Create a **complete and functional desktop application** that demonstrates all the skills you've acquired this week:
- Performant Rust application
- Modern graphical interface
- Data management
- Integrated CLI tools (optional)
- Packaging and distribution

## 📋 Constraints

- **Duration**: 2 days (Saturday and Sunday)
- **Work**: In teams of 2-4 people (recommended) or solo
- **Technologies**: Use what you've learned this week (Rust, Tauri, Electron)
- **Distribution**: The application must be packaged and distributable

## 🎨 Project Themes (choose one)

### Option 1: Desktop Project Manager
Create a project management tool with:
- Modern graphical interface
- Project and task creation
- Kanban boards
- Tags and priority system
- Search and filters
- Data export (JSON, CSV)
- Local storage

**Suggested stack**: Tauri + React/Vue + SQLite or Electron + Node.js + SQLite

### Option 2: Simplified Code Editor
Create a code editor with:
- Syntax highlighting
- File explorer
- Integrated terminal
- Customizable themes
- Search and replace
- Project management
- System extensions (optional)

**Suggested stack**: Tauri + Monaco Editor or Electron + CodeMirror

### Option 3: System Monitoring Application
Create an advanced system monitor with:
- Real-time graphs (CPU, RAM, Disk, Network)
- Process list with management
- Performance history
- Configurable alerts
- Report export
- Tray icon with summary
- Customizable widgets

**Suggested stack**: Rust + Tauri/Iced + sysinfo

### Option 4: Media Manager
Create a media manager with:
- File library (images, videos, music)
- Metadata and tags
- Advanced search
- Preview
- Organization by folders/collections
- Export and sharing
- Integrated player (optional)

**Suggested stack**: Tauri + React/Vue + Rust backend

### Option 5: Development Application
Create a developer tool with:
- Integrated Git version manager
- Multiple terminals
- File editor
- Dependency manager
- Integrated linter
- Simplified deployment
- Project templates

**Suggested stack**: Tauri + Rust + Git2-rs

### Option 6: Productivity Application
Create a productivity suite with:
- Task manager
- Pomodoro timer
- Quick notes
- Reminders and notifications
- Productivity statistics
- Cloud synchronization (optional)
- Desktop widgets

**Suggested stack**: Tauri + React/Vue + SQLite

### Option 7: Your Own Project
Have an idea? Propose it and create it! Make sure it's ambitious enough to demonstrate your skills.

## ✅ Minimum Features Checklist

### Rust Backend
- [ ] Clean and organized Rust code
- [ ] Error handling with `Result`
- [ ] Well-designed data structures
- [ ] Data persistence (files, SQLite)
- [ ] Optimized performance

### Graphical Interface
- [ ] Modern and intuitive interface
- [ ] Smooth navigation
- [ ] State management
- [ ] Forms with validation
- [ ] Error handling and user feedback
- [ ] Coherent design

### System Features
- [ ] File system access
- [ ] System notifications
- [ ] Tray icon (if relevant)
- [ ] System menu
- [ ] Window management

### Packaging
- [ ] Application packaged for at least one platform
- [ ] Custom icon
- [ ] Correct metadata
- [ ] Functional executable
- [ ] Installation documentation

### Advanced Features
- [ ] Search
- [ ] Filters and sorting
- [ ] Data export
- [ ] User configuration
- [ ] Themes (optional)

## 📝 Project Structure

```
my-project/
├── src/
│   ├── main.rs
│   ├── lib.rs
│   ├── commands/
│   ├── models/
│   ├── utils/
│   └── ...
├── src-tauri/
│   ├── src/
│   │   ├── main.rs
│   │   └── commands.rs
│   ├── tauri.conf.json
│   └── ...
├── frontend/
│   ├── src/
│   ├── package.json
│   └── ...
├── Cargo.toml
└── README.md
```

## 🎯 Evaluation Criteria

### Functionality (40%)
- The application works as expected
- All main features are implemented
- Appropriate error handling
- Acceptable performance

### Code Quality (25%)
- Clean and idiomatic Rust code
- No compiler warnings
- Logical project structure
- Relevant comments
- Unit tests (bonus)

### Design & UX (20%)
- Modern and attractive interface
- Smooth user experience
- Appropriate user feedback
- Basic accessibility

### Packaging (10%)
- Application packaged correctly
- Installation documentation
- Complete metadata

### Bonus (5%)
- Additional features
- Tests
- Complete documentation
- Optimized performance
- Multi-platform

## 📚 Useful Resources

- [Tauri Documentation](https://v2.tauri.app/fr/start/)
- [Electron Documentation](https://www.electronjs.org/docs)
- [Rust Book](https://doc.rust-lang.org/book/)
- [SQLite with Rust](https://docs.rs/rusqlite/)

## 💡 Rush Tips

1. **Plan**: Spend 1-2 hours planning before coding
2. **MVP first**: Make a functional Minimum Viable Product, then add features
3. **Git**: Use Git correctly, make regular commits
4. **Compilation**: Test compilation regularly (Rust compiles slowly)
5. **Communication**: If you're in a team, communicate regularly
6. **Document**: Write a clear README with installation instructions
7. **Rest**: Take breaks, the rush is intense but not at the expense of your health

## 🚀 Suggested Timeline

### Saturday (Day 6)
- **Morning**: Planning, project setup, architecture
- **Afternoon**: Rust backend, data models
- **Evening**: Basic interface, frontend-backend communication

### Sunday (Day 7)
- **Morning**: Main features
- **Afternoon**: Polish, design, bug fixes
- **Evening**: Packaging, documentation, tests

## 📤 Deliverables

At the end of the rush, you must provide:

1. **Git repository** with complete source code
2. **Packaged executable** (or build instructions)
3. **README.md** with:
   - Project description
   - Installation and build instructions
   - Technologies used
   - Screenshots
   - Technical architecture
4. **Presentation** (5-10 minutes):
   - Application demonstration
   - Technical architecture
   - Challenges encountered and solutions
   - Future improvements

## 🎉 Good Luck!

This is the moment to shine! You have all the necessary skills. Do your best and most importantly, have fun! 🚀

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

**Remember**: The goal is not perfection, but to create something functional that demonstrates your skills. A complete MVP is better than an unfinished ambitious project!

**Rust Tip**: If you encounter problems with the borrow checker, take the time to understand rather than work around it. It's a valuable skill!
