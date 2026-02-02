# ⚙️ Day 03 - Software Track: Build a CLI in Rust

Welcome to Day 3 of the Software Pool 2026! 🚀

Today, you'll create professional command-line tools with Rust. CLIs are essential for automation and developer tools.

## Day Purposes

✔️ Create CLI applications with Rust

✔️ Parse command-line arguments

✔️ Handle input/output (stdin, stdout, stderr)

✔️ Create useful and reusable tools

✔️ Manage files and directories

✔️ Create terminal user interfaces (basic TUI)

## Introduction

### Why CLI Tools?

Command-line interfaces are powerful tools for:
- **Automation** - Script repetitive tasks
- **Developer tools** - Build tools, linters, formatters
- **System administration** - Manage servers and systems
- **Productivity** - Quick access to functionality
- **Cross-platform** - Work on any operating system

### Why Rust for CLIs?

- **Performance** - Fast execution, low memory usage
- **Single binary** - Easy to distribute
- **Great ecosystem** - Excellent CLI libraries (clap, indicatif, etc.)
- **Type safety** - Catch errors at compile time
- **Cross-platform** - Compile for Windows, macOS, Linux

## Warm Up

Before starting, familiarize yourself with:

1. **Command-line basics**:
   - Arguments and flags
   - Standard input/output
   - Exit codes

2. **Rust I/O**:
   - `std::io` module
   - Reading from stdin
   - Writing to stdout/stderr

3. **Useful crates**:
   - `clap` - Argument parsing
   - `indicatif` - Progress bars
   - `colored` - Terminal colors

Here are useful links:

- [clap Documentation](https://docs.rs/clap/)
- [serde](https://serde.rs/) - Serialization/deserialization
- [indicatif](https://docs.rs/indicatif/) - Progress bars
- [colored](https://docs.rs/colored/) - Terminal colors

## Step 0 - Setup

📑 **Description:**

Set up your Rust project for CLI development.

📌 **Tasks:**

1. Create a folder for Day 3:
```bash
mkdir -p day3
cd day3
cargo new my_cli_tool --bin
cd my_cli_tool
```

2. Add dependencies to `Cargo.toml`:
```toml
[dependencies]
clap = { version = "4.0", features = ["derive"] }
colored = "2.0"
```

📚 **Documentation:**

- [Cargo Binary](https://doc.rust-lang.org/cargo/reference/cargo-targets.html#binaries)

✔️ **Validation:**

Your project should compile with `cargo build`.

## Step 1 - Simplified Grep

📑 **Description:**

In this exercise, you'll create a simplified clone of `grep`, a very popular command-line tool for searching text in files. This is the perfect opportunity to learn how to create CLI tools with Rust and use `clap` to parse arguments.

📌 **What you need to do:**

### Step 1.1 - Configure the CLI project

Create a new binary project with `cargo new rgrep --bin`. Add the necessary dependencies in `Cargo.toml`: `clap` with `derive` features to parse arguments, and `colored` to color text in the terminal.

**Why these dependencies?**
- `clap`: Powerful library for parsing command-line arguments with automatic help generation
- `colored`: To improve readability by coloring matches

### Step 1.2 - Define the argument structure

In `src/main.rs`, use `clap` with `#[derive(Parser)]` to create an `Args` structure that contains:
- `pattern`: a string (required positional argument)
- `file`: a string (required positional argument)
- `case_insensitive`: a boolean with option `-i` or `--case-insensitive`
- `line_numbers`: a boolean with option `-n` or `--line-numbers`

Add documentation comments on each field so `clap` automatically generates help with `--help`.

### Step 1.3 - Implement the search function

Create a `search_in_file` function that takes the pattern, file path, and search options. This function must:
1. Read the file content with `fs::read_to_string`
2. Iterate through each line with `lines().enumerate()` (line numbers start at 1)
3. Check if the line contains the pattern (taking into account `case_insensitive`)
4. If a match is found, display the line (with the number if `line_numbers` is true)
5. Color the pattern in the line to highlight it

For case-insensitive search, convert the line and pattern to lowercase before comparing with `contains`.

### Step 1.4 - Implement pattern coloring

Create a `highlight_pattern` function that takes a line, a pattern, and the case-insensitive option. This function must replace all occurrences of the pattern in the line with its colored version (red and bold with `colored`).

For case-insensitive search, you'll need to find occurrences while respecting the original case of the line, but comparing with the pattern in lowercase. A simple approach is to use `replace` for each occurrence found.

### Step 1.5 - Implement the main function

In `main`, use `Args::parse()` to parse command-line arguments. Then call `search_in_file` with the parsed arguments. Handle errors by displaying an error message with `eprintln!` and exiting with error code 1.

### Step 1.6 - Test your tool

Create a test file with several lines containing different words. Test your tool with different option combinations:
- Simple search without options
- With `-n` option to display line numbers
- With `-i` option for case-insensitive search
- With both options combined

Verify that matches are properly colored and line numbers display correctly.

### Step 1.7 - Bonus: Regular expression support

To add regex support, add the `regex` dependency in `Cargo.toml`. Modify your search function to detect if the pattern is a valid regex (by trying to create a `Regex`). If so, use `is_match` instead of `contains`.

**Constraints to follow:**
- Use `clap` with `derive` to parse arguments
- Support `-i` (case-insensitive) and `-n` (line numbers) options
- Color matches in the terminal with `colored`
- Handle errors (file not found, etc.) with clear messages
- Help with `--help` is automatically generated by `clap`

📚 **Documentation:**

- [clap Documentation](https://docs.rs/clap/)
- [std::fs::read_to_string](https://doc.rust-lang.org/std/fs/fn.read_to_string.html)
- [String Methods](https://doc.rust-lang.org/std/string/struct.String.html)
- [colored crate](https://docs.rs/colored/)
- [regex crate](https://docs.rs/regex/) (for bonus)

✔️ **Validation:**

Your `rgrep` tool must:
- ✅ Search for a pattern in a file and display matching lines
- ✅ Support `-i` option for case-insensitive search
- ✅ Support `-n` option to display line numbers
- ✅ Color matches in the terminal
- ✅ Handle errors gracefully (file not found, etc.)
- ✅ Display help with `--help` (automatically generated)
- ✅ Support regular expressions (bonus)

## Step 2 - Password Manager

📑 **Description:**

In this exercise, you'll create a secure command-line password manager. This is a practical project that will teach you to handle sensitive data, use encryption, and create a CLI interface with subcommands.

📌 **What you need to do:**

### Step 2.1 - Configure the project and dependencies

Create a new binary project with `cargo new pwdmgr --bin`. Add the necessary dependencies in `Cargo.toml`: `clap` with derive for subcommands, `rpassword` to hide input, `aes-gcm` for encryption, `serde` and `serde_json` for serialization, and `rand` to generate passwords.

**Why these dependencies?**
- `clap`: To parse arguments and create subcommands easily
- `rpassword`: To hide master password input in the terminal
- `aes-gcm`: To encrypt data with a secure algorithm
- `serde` / `serde_json`: To serialize and deserialize data to JSON
- `rand`: To generate random and strong passwords

### Step 2.2 - Define the data structure

Create a module `src/models.rs` with two structures: `PasswordEntry` that contains service, username, and password, and `PasswordStore` that contains a vector of entries. Add `Serialize` and `Deserialize` derives from `serde` to serialize these structures to JSON.

**Why this structure?** It allows you to store multiple entries in an organized way and serialize them easily for storage.

### Step 2.3 - Define subcommands with clap

In `src/main.rs`, use `clap` with `#[derive(Subcommand)]` to create a `Commands` enum with the following variants:
- `Add` with `service` and `username` as arguments
- `Get` with `service` as argument
- `List` without arguments
- `Delete` with `service` as argument
- `Generate` with a `length` option (default 16)

Each variant becomes a CLI subcommand. Add documentation comments on each variant so `clap` generates help automatically.

### Step 2.4 - Implement encryption

Create a module `src/crypto.rs` with a `CryptoManager` structure that encapsulates an `Aes256Gcm`.

In the `new` constructor, derive a 32-byte key from the master password. To simplify, you can use SHA-256, but in production you should use PBKDF2 or Argon2. Then create the AES-GCM cipher with this key.

Implement `encrypt` that takes a string and returns a byte vector. Generate a random nonce with `Aes256Gcm::generate_nonce`, encrypt the data, then concatenate the nonce (first 12 bytes) with the encrypted text for storage.

Implement `decrypt` that takes a byte vector, separates the nonce (first 12 bytes) from the encrypted text, then decrypts and returns the original string.

**Important note:** For a real application, use `pbkdf2` or `argon2` to derive the key from the master password securely.

### Step 2.5 - Implement storage

Create a module `src/storage.rs` with a `Storage` structure that contains a `CryptoManager`. Define a constant for the storage file name (e.g., `.pwdmgr_store.encrypted`).

Implement `load` that checks if the file exists. If it doesn't exist, return an empty `PasswordStore`. Otherwise, read the file, decrypt the data with `decrypt`, then deserialize the JSON with `serde_json::from_str`.

Implement `save` that serializes the `PasswordStore` to JSON with `serde_json::to_string`, encrypts the JSON with `encrypt`, then writes the encrypted data to the file.

### Step 2.6 - Implement commands

In `main`, after parsing arguments with `Cli::parse()`, ask for the master password with `rpassword::read_password()` (don't forget to `flush` stdout before to display the prompt).

Create a `Storage` instance with the master password, then use a `match` on `cli.command` to handle each subcommand:

- **Add**: Ask for the password to store with `read_password()`, load the store, add a new `PasswordEntry`, then save.
- **Get**: Load the store, find the entry corresponding to the service with `find()`, then display the information.
- **List**: Load the store and display all entries (or a message if empty).
- **Delete**: Load the store, use `retain()` to remove the entry corresponding to the service, then save if an entry was removed.
- **Generate**: Generate a random password with `rand` using a charset containing uppercase letters, lowercase letters, digits, and special characters.

### Step 2.7 - Generate strong passwords

Create a `generate_password` function that takes a length parameter. Use `rand::thread_rng()` to generate random characters from a charset. The charset must contain at minimum: uppercase letters, lowercase letters, digits, and special characters. Generate `length` random characters and collect them into a string.

**Constraints to follow:**
- Use `rpassword` to hide master password input
- Encrypt all data with AES-GCM before storage
- Store data in an encrypted file
- Generate strong passwords with `rand` (at least 16 characters by default)
- Handle all errors properly (file not found, decryption failed, etc.)

📚 **Documentation:**

- [clap Subcommands](https://docs.rs/clap/latest/clap/_derive/_tutorial/index.html)
- [rpassword](https://docs.rs/rpassword/)
- [aes-gcm](https://docs.rs/aes-gcm/)
- [serde_json](https://docs.rs/serde_json/)
- [rand](https://docs.rs/rand/)

✔️ **Validation:**

Your password manager must:
- ✅ Add entries with `add <service> <username>`
- ✅ Retrieve passwords with `get <service>`
- ✅ List all services with `list`
- ✅ Delete services with `delete <service>`
- ✅ Generate strong passwords with `generate --length <n>`
- ✅ Encrypt all stored data
- ✅ Hide master password input
- ✅ Handle errors gracefully

## Step 3 - File Search Tool

📑 **Description:**

In this exercise, you'll create a file search tool similar to `find`. This will teach you how to traverse directory trees recursively and filter files based on various criteria.

📌 **What you need to do:**

### Step 3.1 - Set up the CLI structure

Create a new binary project with `cargo new findr --bin`. Use `clap` to define the command-line arguments:
- `name`: Required positional argument for the file name pattern to search
- `-t, --type <extension>`: Optional flag to filter by file extension
- `-d, --dir <directory>`: Optional flag to specify the starting directory (default to current directory)

### Step 3.2 - Implement recursive directory traversal

To search recursively, you have two options:
- Use the `walkdir` crate which provides efficient recursive directory traversal
- Implement your own recursive traversal using `std::fs::read_dir` and recursion

For this exercise, use `walkdir` as it's more efficient and handles edge cases better. Iterate through all entries in the directory tree starting from the specified directory.

### Step 3.3 - Filter files by name

For each entry found, check if it's a file (not a directory). Then check if the file name matches the search pattern. You can use simple string matching with `contains()` or implement more advanced pattern matching.

Display matching files with their full path and file size. Use `metadata()` to get file size information.

### Step 3.4 - Filter by extension

If the `--type` option is provided, filter results to only show files with the specified extension. Extract the file extension from the file name and compare it (case-insensitive) with the provided extension.

### Step 3.5 - Display results

Format the output clearly, showing:
- Full path to the file
- File size in a human-readable format (bytes, KB, MB, etc.)
- Optionally, file modification date

Use colors with `colored` crate to make the output more readable (e.g., highlight the file name, use different colors for paths and sizes).

### Step 3.6 - Bonus: Search by content

For the bonus, add a `-c, --content <pattern>` option that searches for files containing the pattern in their content. When this option is used:
- Read each file's content (be careful with binary files)
- Search for the pattern in the content
- Display matching files along with line numbers where the pattern appears (optional)

Handle errors gracefully (permission denied, binary files, etc.).

**Constraints to follow:**
- Use `clap` for argument parsing
- Support recursive search through directory trees
- Filter by file name pattern
- Filter by extension with `-t` option
- Display full path and file size
- Handle errors gracefully (permissions, etc.)
- Search by content (bonus)

📚 **Documentation:**

- [std::fs::read_dir](https://doc.rust-lang.org/std/fs/fn.read_dir.html)
- [walkdir](https://docs.rs/walkdir/) (for recursive search)
- [clap](https://docs.rs/clap/)

✔️ **Validation:**

Your search tool must:
- ✅ Search for files by name recursively
- ✅ Filter by extension with `-t` option
- ✅ Specify starting directory with `-d` option
- ✅ Display full path and file size
- ✅ Handle errors gracefully
- ✅ Search by content (bonus)

## Step 4 - Project Generator

📑 **Description:**

In this exercise, you'll create a project generator tool that scaffolds new projects from templates. This will teach you how to programmatically create directory structures and files.

📌 **What you need to do:**

### Step 4.1 - Set up the CLI structure

Create a new binary project with `cargo new projgen --bin`. Use `clap` to define arguments:
- `name`: Required positional argument for the project name
- `template`: Required positional argument for the template type (`rust`, `web`, `cli`)

### Step 4.2 - Define template structures

Create a structure or enum to represent different project templates. Each template should define:
- The directory structure to create
- Files to create with their content
- Dependencies or configuration files

For the `rust` template, create:
- `Cargo.toml` with basic project metadata
- `src/main.rs` with a hello world program
- `.gitignore` for Rust projects
- `README.md` with project information

For the `web` template, create:
- `index.html` with a basic HTML structure
- `style.css` with basic styles
- `script.js` with basic JavaScript
- `README.md`

For the `cli` template, create:
- A simple CLI structure with argument parsing setup
- `README.md` with usage instructions

### Step 4.3 - Implement directory creation

Create a function that generates the project structure:
- Create the main project directory with the given name
- Create subdirectories as needed (e.g., `src/` for Rust projects)
- Handle errors if the directory already exists (either error out or ask for confirmation)

### Step 4.4 - Generate template files

For each template, create functions that generate the required files with appropriate content. Use string templates or format strings to customize content based on the project name.

For example, the `Cargo.toml` should have the project name filled in. The `README.md` should mention the project name.

### Step 4.5 - Initialize git repository

After creating the project structure, initialize a git repository in the project directory. Use `std::process::Command` to run `git init`. Handle the case where git is not installed or the command fails.

### Step 4.6 - Create README

Generate a basic README.md file for each template with:
- Project name
- Description
- Basic usage instructions
- Template-specific information

**Constraints to follow:**
- Use `clap` for argument parsing
- Support at least three templates (`rust`, `web`, `cli`)
- Create proper directory structures
- Generate files with appropriate content
- Initialize git repository
- Handle errors gracefully (directory exists, git not installed, etc.)

📚 **Documentation:**

- [std::fs::create_dir](https://doc.rust-lang.org/std/fs/fn.create_dir.html)
- [std::fs::write](https://doc.rust-lang.org/std/fs/fn.write.html)
- [std::process::Command](https://doc.rust-lang.org/std/process/struct.Command.html)

✔️ **Validation:**

Your generator must:
- ✅ Create projects from templates (`rust`, `web`, `cli`)
- ✅ Generate proper directory structures
- ✅ Create template files with appropriate content
- ✅ Initialize git repository
- ✅ Create a README file
- ✅ Handle errors gracefully

## Step 5 - System Monitor

📑 **Description:**

In this exercise, you'll create a system monitoring tool similar to `htop` or `top`. This will teach you how to interact with system APIs and create a terminal-based real-time interface.

📌 **What you need to do:**

### Step 5.1 - Set up dependencies

Create a new binary project and add dependencies:
- `sysinfo` - For system information (CPU, memory, processes)
- `crossterm` or `termion` - For terminal manipulation (clearing screen, cursor positioning)
- `clap` - For command-line arguments (optional, for configuration)

### Step 5.2 - Initialize system information

Create a `SystemMonitor` structure that wraps `sysinfo::System`. Initialize it and refresh system information. You'll need to refresh periodically to get updated statistics.

### Step 5.3 - Collect system metrics

Implement functions to collect:
- **CPU usage**: Use `sysinfo::System::cpu_usage()` to get overall CPU usage percentage
- **Memory**: Use `sysinfo::System::used_memory()` and `total_memory()` to get memory statistics
- **Disk space**: Use `sysinfo::System::disk_usage()` for disk information
- **Processes**: Use `sysinfo::System::processes()` to get the list of running processes

### Step 5.4 - Format and display information

Create a function to format and display the collected information in a clear layout:
- Display CPU usage as a percentage or progress bar
- Display memory usage (used/total) in human-readable format (MB, GB)
- Display disk usage similarly
- Display a list of processes with their CPU usage, memory usage, and name

Use terminal colors to make the output more readable (e.g., red for high CPU usage, green for normal).

### Step 5.5 - Implement real-time updates

Create a main loop that:
- Clears the terminal screen
- Refreshes system information
- Displays the updated information
- Waits for one second
- Repeats

Use `crossterm` or `termion` to clear the screen and position the cursor. Handle Ctrl+C to exit gracefully.

### Step 5.6 - Sort processes by CPU usage

Sort the process list by CPU usage (highest first). Extract CPU usage for each process and sort accordingly. Display only the top N processes (e.g., top 20) to keep the output manageable.

### Step 5.7 - Add refresh rate control

Optionally, add a command-line argument to control the refresh rate (default 1 second). Allow users to specify a different interval.

**Constraints to follow:**
- Use `sysinfo` for system information
- Display CPU, memory, disk, and process information
- Update in real-time (every second by default)
- Clear and refresh the terminal display
- Sort processes by CPU usage
- Handle Ctrl+C to exit gracefully

📚 **Documentation:**

- [sysinfo](https://docs.rs/sysinfo/)
- [crossterm](https://docs.rs/crossterm/) or [termion](https://docs.rs/termion/)
- [Terminal clearing](https://docs.rs/crossterm/latest/crossterm/terminal/index.html)

✔️ **Validation:**

Your monitor must:
- ✅ Display CPU usage accurately
- ✅ Display memory usage (used/available)
- ✅ Display disk space (used/free)
- ✅ List running processes sorted by CPU usage
- ✅ Update in real-time
- ✅ Clear screen and refresh properly
- ✅ Handle exit gracefully

## Step 6 - Format Converter

📑 **Description:**

In this exercise, you'll create a file format converter that can convert between different data formats (JSON, YAML, CSV). This will teach you how to work with serialization libraries and handle different file formats.

📌 **What you need to do:**

### Step 6.1 - Set up dependencies

Create a new binary project and add dependencies:
- `clap` - For command-line argument parsing
- `serde` with `derive` feature - For serialization/deserialization
- `serde_json` - For JSON support
- `serde_yaml` - For YAML support
- `csv` - For CSV support

### Step 6.2 - Detect file format

Create a function to detect the file format from the file extension or content. Check the file extension first (`.json`, `.yaml`, `.yml`, `.csv`). Optionally, you can peek at the file content to validate the format.

### Step 6.3 - Parse input file

Create functions to parse different input formats:
- **JSON**: Use `serde_json::from_reader()` to deserialize JSON into a generic `serde_json::Value` or a custom structure
- **YAML**: Use `serde_yaml::from_reader()` similarly
- **CSV**: Use the `csv` crate to read CSV files. You may need to handle headers and convert rows to a structure

Handle parsing errors gracefully with clear error messages indicating what went wrong.

### Step 6.4 - Convert between formats

Implement conversion logic:
- **JSON ↔ YAML**: Since both use serde, you can deserialize from one format and serialize to the other
- **CSV → JSON**: Read CSV rows, convert each row to a JSON object, and create a JSON array
- **JSON → CSV**: Parse JSON array, extract objects, and write as CSV rows with headers

For CSV conversions, you'll need to handle the structure carefully. CSV is tabular (rows and columns), while JSON/YAML can be nested structures.

### Step 6.5 - Write output file

After conversion, write the data to the output file in the target format:
- Use `serde_json::to_writer_pretty()` for JSON (pretty-printed)
- Use `serde_yaml::to_writer()` for YAML
- Use `csv::Writer` for CSV

Handle file writing errors (permissions, disk full, etc.).

### Step 6.6 - Validate formats

Before conversion, validate that:
- The input file exists and is readable
- The input format is supported
- The output format is supported
- The conversion is possible (e.g., nested JSON to CSV may lose structure)

Return clear error messages if validation fails.

### Step 6.7 - Bonus: Batch conversion

For the bonus, add support for batch conversion:
- Accept multiple input files with a pattern (e.g., `*.json`)
- Convert each file to the target format
- Generate output filenames automatically (change extension)
- Process files in parallel or sequentially

**Constraints to follow:**
- Use `clap` for argument parsing
- Support JSON ↔ YAML conversion
- Support CSV ↔ JSON conversion
- Validate input format
- Handle conversion errors gracefully
- Support batch conversion (bonus)

📚 **Documentation:**

- [serde_json](https://docs.rs/serde_json/)
- [serde_yaml](https://docs.rs/serde_yaml/)
- [csv](https://docs.rs/csv/)
- [serde](https://serde.rs/)

✔️ **Validation:**

Your converter must:
- ✅ Convert JSON to YAML and vice versa
- ✅ Convert CSV to JSON and vice versa
- ✅ Validate input format
- ✅ Handle conversion errors gracefully
- ✅ Support batch conversion (bonus)

## Step 7 - CLI Task Manager

📑 **Description:**

In this exercise, you'll create a command-line task manager similar to task management tools. This combines everything you've learned: CLI argument parsing, file I/O, serialization, and data management.

📌 **What you need to do:**

### Step 7.1 - Define the data model

Create a `Task` structure with:
- `id`: Unique identifier (can be auto-incrementing)
- `description`: Task description
- `completed`: Boolean flag
- `priority`: Enum or string (`high`, `medium`, `low`)
- `created_at`: Timestamp (optional)

Create a `TaskStore` structure that contains a vector of tasks and manages the next ID.

### Step 7.2 - Set up CLI with subcommands

Use `clap` with `Subcommand` to create subcommands:
- `add <description>` - Add a new task
- `list` - List all tasks (with optional filters)
- `complete <id>` - Mark a task as completed
- `delete <id>` - Delete a task
- `priority <id> <level>` - Set task priority

### Step 7.3 - Implement task storage

Create functions to save and load tasks from a JSON file:
- `load_tasks(file_path: &str)` - Load tasks from JSON file
- `save_tasks(tasks: &TaskStore, file_path: &str)` - Save tasks to JSON file

Use `serde_json` for serialization. Handle file errors gracefully (file not found should return empty store, not error).

### Step 7.4 - Implement add command

When adding a task:
- Generate a new unique ID
- Create a new `Task` with the description
- Set default priority (e.g., `medium`)
- Add to the task store
- Save to file

### Step 7.5 - Implement list command

Display all tasks in a formatted table showing:
- ID
- Description
- Status (completed/incomplete)
- Priority
- Created date (if available)

Use colors to highlight completed tasks, high-priority tasks, etc. Make the output readable and well-formatted.

### Step 7.6 - Implement complete and delete commands

For `complete <id>`:
- Find the task by ID
- Mark it as completed
- Save to file
- Return error if task not found

For `delete <id>`:
- Find the task by ID
- Remove it from the store
- Save to file
- Return error if task not found

### Step 7.7 - Implement priority command

For `priority <id> <level>`:
- Find the task by ID
- Update its priority
- Validate the priority level
- Save to file
- Return error if task not found or invalid priority

### Step 7.8 - Bonus: Add filters

For the bonus, add filter options to the `list` command:
- `--completed` - Show only completed tasks
- `--incomplete` - Show only incomplete tasks
- `--priority <level>` - Show only tasks with specific priority
- Combine multiple filters

**Constraints to follow:**
- Use `clap` with subcommands
- Store tasks in JSON file
- Support all CRUD operations (add, list, complete, delete, update priority)
- Handle errors gracefully (task not found, invalid ID, etc.)
- Support filters (bonus)

📚 **Documentation:**

- [clap Subcommands](https://docs.rs/clap/latest/clap/_derive/_tutorial/index.html)
- [serde_json](https://docs.rs/serde_json/)

✔️ **Validation:**

Your task manager must:
- ✅ Add tasks with `add <description>`
- ✅ List all tasks with `list`
- ✅ Mark tasks as completed with `complete <id>`
- ✅ Delete tasks with `delete <id>`
- ✅ Set priority with `priority <id> <level>`
- ✅ Save and load from JSON file
- ✅ Support filters (bonus)

## Step 8 - Make it the Cutest Code You've Ever Seen

📑 **Description:**

Polish your CLI tools with good UX and error handling.

📌 **Tasks:**

1. Add `--help` to all commands
2. Use colors for better readability
3. Add progress bars where appropriate
4. Handle all error cases
5. Write clear error messages
6. Make tools installable with `cargo install --path .`

📚 **Documentation:**

- [clap Help](https://docs.rs/clap/latest/clap/_derive/index.html)
- [Error Handling](https://doc.rust-lang.org/book/ch09-00-error-handling.html)

✔️ **Validation:**

Your tools should be user-friendly and handle errors gracefully.

## Bonus Challenge

📑 **Description:**

Create a **semantic version manager**.

📌 **Tasks:**

Create a semantic version manager:
- `semver bump major|minor|patch` - Increment version
- `semver set <version>` - Set a version
- `semver compare <v1> <v2>` - Compare two versions
- Integration with `Cargo.toml` or `package.json`
- Automatic changelog generation

**Estimated time**: 3-4 hours

## 📚 Additional Resources

- [Command Line Interface Guidelines](https://clig.dev/)
- [Rust CLI Book](https://rust-cli.github.io/book/)

## ✅ End of Day Checklist

- [ ] I've created at least 3 CLI tools
- [ ] I've used `clap` to parse arguments
- [ ] I've handled input/output correctly
- [ ] My tools have help (`--help`)
- [ ] I've handled errors properly
- [ ] My tools are installable with `cargo install --path .`
- [ ] I've added colors and formatting

## 💡 Tips

- Use `cargo install --path .` to test installation
- Think about user experience (clear messages, help)
- Handle all error cases
- Use colors to improve readability
- Test your tools with different use cases
- Consider using `anyhow` or `thiserror` for error handling

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
