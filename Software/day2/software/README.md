# ⚙️ Day 02 - Software Track: Advanced Rust

Welcome to Day 2 of the Software Pool 2026! 🚀

Today, you'll dive deeper into Rust with advanced concepts: advanced ownership, lifetimes, concurrency, and robust error handling.

## Day Purposes

✔️ Master ownership and borrowing in complex cases

✔️ Understand lifetimes and their annotations

✔️ Use traits (Rust's interfaces)

✔️ Handle errors with `Result` and `Option`

✔️ Introduction to concurrency with threads

✔️ Use iterators and closures

## Introduction

### Why Advanced Rust?

After mastering the basics, it's time to explore Rust's unique features that make it powerful and safe. Today you'll learn:

- **Lifetimes** - Rust's way of ensuring memory safety without garbage collection
- **Traits** - Rust's powerful abstraction mechanism (similar to interfaces)
- **Concurrency** - Safe parallel programming with threads
- **Error Handling** - Robust error management with `Result` and `Option`

These concepts are what make Rust stand out from other languages. They enable you to write safe, fast, and concurrent code.

## Warm Up

Before diving into the exercises, review these concepts:

1. **Ownership Review**: Make sure you understand the basics from Day 1
   - Ownership rules
   - Borrowing (`&` and `&mut`)
   - Move semantics

2. **Read The Rust Book**: Chapters 10-16, 19-20 cover:
   - Generic types, traits, and lifetimes
   - Error handling
   - Concurrency

3. **Try Rustlings**: Complete the advanced exercises if you haven't already

Here are useful links:

- [The Rust Book - Advanced Topics](https://doc.rust-lang.org/book/ch10-00-generics.html)
- [Rust by Example - Traits](https://doc.rust-lang.org/rust-by-example/trait.html)
- [Rust by Example - Error Handling](https://doc.rust-lang.org/rust-by-example/error.html)
- [Rust by Example - Concurrency](https://doc.rust-lang.org/rust-by-example/std_misc/threads.html)

## Step 0 - Setup

📑 **Description:**

Create a new project for Day 2 exercises. We'll build more complex applications today.

📌 **Tasks:**

1. Create a folder for Day 2:
```bash
mkdir -p day2
cd day2
cargo new advanced_rust
cd advanced_rust
```

2. Add useful dependencies to `Cargo.toml`:
```toml
[dependencies]
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
chrono = "0.4"
```

📚 **Documentation:**

- [Cargo Dependencies](https://doc.rust-lang.org/cargo/reference/specifying-dependencies.html)

✔️ **Validation:**

Your project should compile with `cargo build`.

## Step 1 - File Manager

📑 **Description:**

In this exercise, you'll create a file manager to practice error handling and file operations. This is the perfect opportunity to understand how Rust handles errors with `Result` and `Option`.

📌 **What you need to do:**

### Step 1.1 - Create the base structure

Create a new module `src/file_manager.rs` with a `FileManager` struct that will contain your methods. Start by creating a simple struct that will serve as a namespace for your functions.

### Step 1.2 - Define a custom error type

Before implementing the features, create a custom error type using an enum. You need to handle at minimum these error cases: file not found, permission denied, invalid path, and general I/O errors. Implement the `Display` trait for your error type to display clear error messages.

**Why do this?** A custom error type allows you to provide clear and specific error messages for your application, rather than using standard library errors directly.

### Step 1.3 - Implement the `list_files` method

Create a static method `list_files` that takes a directory path as a parameter and returns a `Result<Vec<String>, FileManagerError>`.

To implement it, you'll need to use `std::fs::read_dir` to read the directory contents. Then loop through all entries and check if each entry is a file (not a directory). You can use the `file_type()` method on entries to check this. Collect all file names into a vector of strings.

Don't forget to handle errors: if the directory doesn't exist, return your custom `FileNotFound` error. Use the `?` pattern to propagate errors from the standard library to your custom error type.

**Expected result:** When you call `FileManager::list_files("./src")`, you should get a vector containing the names of all files in the `src` directory, for example `["main.rs", "file_manager.rs", ...]`.

### Step 1.4 - Implement the `read_file` method

Create a `read_file` method that takes a file path and returns its content as a `String`. Use `std::fs::read_to_string` to read the file.

Handle error cases: if the file doesn't exist, return `FileNotFound`. If you don't have read permissions, return `PermissionDenied`. To convert standard library errors to your error type, you can use `map_err` or create a conversion function.

**Expected result:** `FileManager::read_file("./Cargo.toml")` should return the complete content of the `Cargo.toml` file as a string.

### Step 1.5 - Implement the `write_file` method

Create a `write_file` method that takes a file path and content to write. Use `std::fs::write` to write to the file.

If the parent directory doesn't exist, you can use `std::fs::create_dir_all` to create it automatically before writing the file. Handle permission errors and other I/O errors.

**Expected result:** After calling `FileManager::write_file("./test.txt", "Hello, World!")`, the `test.txt` file should be created (or overwritten if it already exists) with the content "Hello, World!".

### Step 1.6 - Implement the `copy_file` method

Create a `copy_file` method that takes a source path and a destination path. Use `std::fs::copy` to copy the file.

Before copying, verify that the source file exists. If the destination directory doesn't exist, create it with `create_dir_all`. Handle all possible error cases: source not found, inaccessible destination, permission errors, etc.

**Expected result:** `FileManager::copy_file("./source.txt", "./destination.txt")` should create the `destination.txt` file with the same content as `source.txt`.

### Step 1.7 - Test your implementation

Create unit tests to validate your implementation. Test at minimum:
- Listing files in an existing directory
- Reading an existing file
- Reading a non-existent file (should return an error)
- Writing to a file
- Copying a file

Use `#[cfg(test)]` and `#[test]` to create your tests. Verify that successes return `Ok` and errors return the correct error type.

**Constraints to follow:**
- Use `std::fs` and `std::path` for all operations
- Handle ALL error cases (file not found, permissions, invalid path, etc.)
- Return custom error types with clear messages
- Use the `?` pattern to propagate errors
- Write tests for each functionality

📚 **Documentation:**

- [std::fs](https://doc.rust-lang.org/std/fs/index.html)
- [std::path](https://doc.rust-lang.org/std/path/index.html)
- [Error Handling](https://doc.rust-lang.org/book/ch09-00-error-handling.html)

✔️ **Validation:**

Your file manager must:
- ✅ List files in a directory correctly
- ✅ Read the content of an existing file
- ✅ Write to a file (create or overwrite)
- ✅ Copy a file to a destination
- ✅ Handle all errors with clear messages
- ✅ Pass all unit tests

## Step 2 - Configuration Parser

📑 **Description:**

In this exercise, you'll create a configuration file parser to practice string manipulation and error handling. You'll learn to parse a simple configuration format (INI-style) and structure data.

📌 **What you need to do:**

### Step 2.1 - Define the data structure

Create a new module `src/config_parser.rs`. Define a structure to represent a configuration section that contains a name and a HashMap of key-value pairs. Then create a `Config` structure that contains a HashMap of sections.

**Why this structure?** It allows you to store sections (like `[database]`) and their key-value pairs in an organized and easily accessible way.

### Step 2.2 - Create the error type

Create a `ConfigError` enum to handle parsing errors. You need to handle at minimum: invalid format, missing section, duplicate key, and I/O errors. Implement the `Display` trait to display clear error messages.

### Step 2.3 - Implement the `parse` method

Create a static method `parse` that takes the configuration file content as a string and returns a `Result<Config, ConfigError>`.

To parse the file, iterate through each line with `content.lines()`. For each line:
- Ignore empty lines and comments (lines starting with `#`)
- Detect sections with the pattern `[section_name]` (line starting with `[` and ending with `]`)
- Parse `key = value` pairs using `split('=')` and trimming spaces
- Store values in the current section

Handle errors: if a line doesn't have the correct format, return `InvalidFormat` with the line number. If a key is duplicated in a section, you can either replace it or return an error.

**Example format to parse:**
```ini
[database]
host = localhost
port = 5432

[server]
name = MyServer
debug = true
```

### Step 2.4 - Implement the `from_file` method

Create a `from_file` method that takes a file path, reads its content with `std::fs::read_to_string`, then calls `parse` on the content. Handle I/O errors by converting them to `ConfigError::IoError`.

### Step 2.5 - Implement the `get` method

Create a `get` method that takes a section name and a key, and returns an `Option<&String>`. Use `HashMap::get` to retrieve the section, then retrieve the value in that section. If the section or key doesn't exist, return `None`.

**Expected result:** `config.get("database", "host")` should return `Some("localhost")` if the configuration contains this value.

### Step 2.6 - Test your implementation

Create tests to validate your parser. Test at minimum:
- Parsing a simple configuration with one section and multiple keys
- Parsing with comments (comments should be ignored)
- Retrieving values with `get`
- Error handling (invalid format, missing section)

**Bonus - Comment support:**
- Lines starting with `#` should be ignored
- End-of-line comments can be handled using `split('#')` to separate content from the comment

**Constraints to follow:**
- Handle `[section]` sections
- Parse `key = value` pairs (with space handling)
- Ignore empty lines
- Handle format errors with clear messages
- Support comments (bonus)

📚 **Documentation:**

- [String Methods](https://doc.rust-lang.org/std/string/struct.String.html)
- [HashMap](https://doc.rust-lang.org/std/collections/struct.HashMap.html)
- [Custom Error Types](https://doc.rust-lang.org/book/ch09-03-to-panic-or-not-to-panic.html)

✔️ **Validation:**

Your parser must:
- ✅ Parse a configuration file correctly
- ✅ Store sections and their values in appropriate structures
- ✅ Retrieve a value with `get(section, key)`
- ✅ Handle format errors with clear messages
- ✅ Ignore comments (bonus)
- ✅ Pass all unit tests

## Step 3 - Thread-Safe Cache System

📑 **Description:**

In this exercise, you'll create a thread-safe cache system to practice concurrent programming in Rust. You'll learn to use `Arc`, `Mutex`, and threads to create a data structure shared between multiple threads.

📌 **What you need to do:**

### Step 3.1 - Understand the concepts

Before starting, understand these key concepts:
- **Arc**: An atomic reference counter that allows sharing data between threads
- **Mutex**: A locking mechanism to protect shared data
- **TTL (Time To Live)**: The lifetime of an entry in the cache

### Step 3.2 - Define the base structure

Create a new module `src/cache.rs`. Define a `CacheEntry` structure that contains a value and an `Instant` representing the expiration time. Then create a generic `Cache` structure that contains an `Arc<Mutex<HashMap<K, CacheEntry<V>>>>` and a default TTL duration.

**Why this structure?**
- `CacheEntry` stores the value and expiration time to manage TTL
- `Arc<Mutex<>>` enables thread-safe sharing of the HashMap between multiple threads
- `default_ttl` defines the default lifetime for all entries

### Step 3.3 - Implement the constructor and base methods

Create a `new` constructor that initializes the cache with a default TTL duration. The HashMap must be wrapped in a `Mutex` itself wrapped in an `Arc`.

Implement the `insert` method that takes a key and a value. To implement it:
1. Lock the Mutex with `lock().unwrap()`
2. Create a `CacheEntry` with `expires_at` equal to `Instant::now() + default_ttl`
3. Insert the pair into the HashMap

Implement the `get` method that takes a reference to a key and returns an `Option<V>`. To implement it:
1. Lock the Mutex
2. Retrieve the entry with `HashMap::get`
3. Check if the entry is expired by comparing `expires_at` with `Instant::now()`
4. If expired, remove the entry with `remove` and return `None`
5. Otherwise, return `Some(value.clone())`

### Step 3.4 - Implement automatic cleanup

Create a `cleanup_expired` method that removes all expired entries from the cache. Use `HashMap::retain` which keeps only entries for which the closure returns `true`. The closure must check that `expires_at > Instant::now()`.

### Step 3.5 - Create a periodic cleanup thread

Create a `start_cleanup_thread` method that takes a time interval as a parameter. This method must:
1. Clone the `Arc` of the HashMap with `Arc::clone`
2. Create a new thread with `std::thread::spawn`
3. In the thread, create an infinite loop that:
   - Waits for the interval with `std::thread::sleep`
   - Cleans expired entries by calling `retain` on the HashMap

The thread will continue running in the background and automatically clean the cache at regular intervals.

### Step 3.6 - Test thread-safety

Create tests to validate that the cache is thread-safe. Test at minimum:
- Basic insertion and retrieval
- Automatic removal of expired entries (insert an entry with a very short TTL, wait, then verify it no longer exists)
- Concurrent access from multiple threads (create several threads that insert values simultaneously, then verify all values are present)

To test concurrency, use `Arc::clone` to share the cache between threads and `join()` to wait for all threads to finish.

**Constraints to follow:**
- Use `Arc<Mutex<>>` for thread-safe sharing
- Implement TTL for each entry with `Instant`
- Create a thread for periodic cleanup
- Test with multiple simultaneous threads
- Handle locks correctly to avoid deadlocks (don't hold the lock too long)

📚 **Documentation:**

- [std::thread](https://doc.rust-lang.org/std/thread/index.html)
- [Arc and Mutex](https://doc.rust-lang.org/book/ch16-03-shared-state.html)
- [Send and Sync](https://doc.rust-lang.org/book/ch16-04-extensible-concurrency-sync-and-send.html)
- [std::time::Instant](https://doc.rust-lang.org/std/time/struct.Instant.html)

✔️ **Validation:**

Your cache must:
- ✅ Be thread-safe (no panics with concurrent access)
- ✅ Store and retrieve values with `get` and `insert`
- ✅ Automatically remove expired entries during `get`
- ✅ Have a cleanup thread running in the background
- ✅ Pass all concurrency tests

## Step 4 - Log Analyzer

📑 **Description:**

In this exercise, you'll create a log analyzer to practice reading files line by line and parsing strings. You'll learn to extract structured information from text files and generate statistics.

📌 **What you need to do:**

### Step 4.1 - Define the data structure

Create a new module `src/log_analyzer.rs`. Define a structure to represent a log line with a timestamp (`NaiveDateTime`), a log level (enum: Error, Warning, Info, Debug), and a message string. Then define a `LogStatistics` structure with counters for total lines, errors, warnings, info, and debug entries.

**Why these structures?** They allow you to represent data in a structured way and easily calculate statistics.

### Step 4.2 - Implement line parsing

Create a function to parse a log line. The expected format is: `"2024-01-15 10:30:45 [ERROR] Database connection failed"`.

To parse it:
- Use `split_whitespace()` to separate the parts of the line
- The date is in format `YYYY-MM-DD HH:MM:SS`
- The level is between brackets `[LEVEL]`
- The message is everything remaining after the level
- Use `NaiveDateTime::parse_from_str` with format `"%Y-%m-%d %H:%M:%S"`

**Example line to parse:**
```
2024-01-15 10:30:45 [ERROR] Database connection failed
```

**Expected result:** `LogEntry::parse()` should create a `LogEntry` with the parsed timestamp, log level, and message.

### Step 4.3 - Implement file reading

Create a function to read and parse a log file. Use `File::open` to open the file, create a `BufReader` to read line by line efficiently, then iterate through lines with `reader.lines()`. For each line, call `LogEntry::parse` and increment the appropriate counters in `LogStatistics`. Handle parsing errors gracefully without stopping the analysis (use `eprintln!` for warnings).

### Step 4.4 - Implement report generation

Create a method to generate a textual report. Format the statistics into a readable report showing total lines, errors, warnings, info, and debug counts.

**Expected result:** A formatted report showing all statistics clearly.

### Step 4.5 - Bonus: Filter by level and date

Create a method to filter logs. If `level_filter` is `Some(level)`, keep only entries with that level. If `date_filter` is `Some(date)`, keep only entries from that date. Use `NaiveDateTime::date()` to compare dates.

### Step 4.6 - Test your implementation

Create a test file `test_logs.txt` with several log entries of different levels. Create tests to validate:
- Parsing a single log entry
- Analyzing a file and getting correct statistics
- Error handling for invalid formats

**Constraints to follow:**
- Read the file line by line with `BufReader`
- Parse each line according to the given format
- Extract statistics (errors, warnings, info)
- Generate a clear report
- Handle parsing errors without stopping the analysis

📚 **Documentation:**

- [File I/O](https://doc.rust-lang.org/std/fs/struct.File.html)
- [BufReader](https://doc.rust-lang.org/std/io/struct.BufReader.html)
- [NaiveDateTime](https://docs.rs/chrono/latest/chrono/naive/struct.NaiveDateTime.html)
- [Regular Expressions](https://docs.rs/regex/) (optionnel pour parsing avancé)

✔️ **Validation:**

Votre analyseur doit :
- ✅ Lire un fichier de logs ligne par ligne
- ✅ Parser chaque ligne correctement
- ✅ Extraire les statistiques (erreurs, warnings, info)
- ✅ Générer un rapport textuel clair
- ✅ Gérer les erreurs de parsing gracieusement
- ✅ Filtrer par niveau et date (bonus)
- ✅ Passer tous les tests unitaires

**Exemple d'utilisation complète :**
```rust
use log_analyzer::{LogAnalyzer, LogStatistics};

fn main() -> Result<(), String> {
    let stats = LogAnalyzer::analyze_file("./app.log")?;
    println!("{}", stats.generate_report());

    // Bonus : filtrer les erreurs
    let errors = LogAnalyzer::filter_logs(
        "./app.log",
        Some(LogLevel::Error),
        None,
    )?;

    println!("\nFound {} errors:", errors.len());
    for error in errors {
        println!("  - {}", error.message);
    }

    Ok(())
}
```

## Step 5 - Simple HTTP Server

📑 **Description:**

In this exercise, you'll create a minimal HTTP server to practice networking and concurrency. You'll learn how to handle TCP connections, parse HTTP requests, and respond with proper HTTP responses.

📌 **What you need to do:**

### Step 5.1 - Set up the server structure

Create a new module `src/http_server.rs`. Define a structure `HttpServer` that will hold the server configuration and handle incoming connections. The server needs to listen on a port and accept multiple connections concurrently.

### Step 5.2 - Implement TCP listener

Use `std::net::TcpListener` to bind to a port (e.g., 8080). The listener should accept incoming connections in a loop. For each connection, you'll need to handle it in a separate thread or use async patterns to handle multiple connections simultaneously.

### Step 5.3 - Parse HTTP requests

Create a function to parse incoming HTTP requests. An HTTP request has the following structure:
- Request line: `METHOD /path HTTP/1.1`
- Headers: `Header-Name: value`
- Empty line
- Body (optional)

Parse the request line to extract the HTTP method (GET, POST) and the path. Parse headers into a structure (you can use a HashMap). Handle the request body if present (for POST requests).

### Step 5.4 - Implement routing

Create a routing system that can handle different paths:
- `/` - Return a simple HTML page
- `/about` - Return an HTML page with information
- `/api/data` - Return JSON data

Use pattern matching or a HashMap to map paths to handler functions. Each handler should return an HTTP response.

### Step 5.5 - Generate HTTP responses

Create a function to generate valid HTTP responses. An HTTP response has:
- Status line: `HTTP/1.1 200 OK`
- Headers: `Content-Type: text/html` or `Content-Type: application/json`
- Empty line
- Body: The actual content

For HTML responses, set `Content-Type: text/html`. For JSON responses, set `Content-Type: application/json`. Return appropriate status codes (200 for success, 404 for not found, etc.).

### Step 5.6 - Handle multiple connections

To handle multiple simultaneous connections, you can either:
- Create a new thread for each connection using `std::thread::spawn`
- Use a thread pool to limit the number of concurrent threads
- Use async/await with `tokio` (more advanced)

For this exercise, start with spawning a new thread for each connection. Make sure to handle errors gracefully and close connections properly.

### Step 5.7 - Bonus: Support POST method

For the bonus, implement POST method support. Parse the request body from POST requests, which comes after the headers and empty line. You may need to read the `Content-Length` header to know how many bytes to read for the body.

**Constraints to follow:**
- Use `std::net::TcpListener` for listening
- Parse HTTP request headers correctly
- Handle connection errors gracefully
- Support multiple simultaneous connections (thread pool recommended)
- Return valid HTTP responses with proper headers
- Handle at least three different routes

📚 **Documentation:**

- [std::net](https://doc.rust-lang.org/std/net/index.html)
- [HTTP Protocol](https://developer.mozilla.org/en-US/docs/Web/HTTP)
- [std::thread](https://doc.rust-lang.org/std/thread/index.html)

✔️ **Validation:**

Your server must:
- ✅ Listen on a port and accept connections
- ✅ Parse HTTP requests correctly (method, path, headers)
- ✅ Handle multiple routes (`/`, `/about`, `/api/data`)
- ✅ Return valid HTTP responses with correct content types
- ✅ Handle multiple simultaneous connections
- ✅ Support GET method (and POST for bonus)

## Step 6 - Plugin System

📑 **Description:**

In this exercise, you'll build a plugin system to practice traits and dynamic behavior. This will teach you how to create extensible architectures using Rust's trait system.

📌 **What you need to do:**

### Step 6.1 - Define the Plugin trait

Create a new module `src/plugin.rs`. Define a `Plugin` trait with at minimum:
- `execute(&self, input: &str) -> Result<String, String>` - Executes the plugin with input
- `name(&self) -> &str` - Returns the plugin's name
- `version(&self) -> &str` - Returns the plugin's version

The trait should be object-safe so you can use trait objects (`Box<dyn Plugin>`).

### Step 6.2 - Create example plugins

Implement the `Plugin` trait for at least two different plugin types. For example:
- A `GreetPlugin` that greets the user
- A `ReversePlugin` that reverses the input string
- A `UppercasePlugin` that converts input to uppercase

Each plugin should be a struct that implements the `Plugin` trait.

### Step 6.3 - Create PluginManager

Create a `PluginManager` structure that manages plugins. It should contain:
- A registry of plugins (use `HashMap<String, Box<dyn Plugin>>` or similar)
- Methods to register plugins
- Methods to execute plugins by name
- Methods to enable/disable plugins

### Step 6.4 - Implement plugin registration

Implement methods to register plugins in the manager:
- `register(plugin: Box<dyn Plugin>)` - Register a new plugin
- `unregister(name: &str)` - Remove a plugin
- `get_plugin(name: &str) -> Option<&dyn Plugin>` - Get a plugin by name

Handle the case where a plugin with the same name already exists (either replace it or return an error).

### Step 6.5 - Implement plugin execution

Implement a method `execute_plugin(&self, name: &str, input: &str)` that:
- Looks up the plugin by name
- Checks if the plugin is enabled
- Executes the plugin with the input
- Returns the result or an error

Handle errors gracefully: plugin not found, plugin disabled, execution errors, etc.

### Step 6.6 - Add enable/disable functionality

Add functionality to enable and disable plugins. You can add an `enabled: bool` field to each plugin entry, or create a separate structure to track plugin state. When a plugin is disabled, `execute_plugin` should return an error.

### Step 6.7 - Test your plugin system

Create tests to validate:
- Registering plugins
- Executing plugins
- Enabling/disabling plugins
- Handling errors (plugin not found, disabled, etc.)

**Constraints to follow:**
- Use traits for abstraction (the `Plugin` trait)
- Support dynamic plugin loading (plugins can be added at runtime)
- Handle loading and execution errors gracefully
- Allow enabling/disabling plugins
- Use trait objects (`Box<dyn Plugin>`) for dynamic dispatch

📚 **Documentation:**

- [Traits](https://doc.rust-lang.org/book/ch10-02-traits.html)
- [Trait Objects](https://doc.rust-lang.org/book/ch17-02-trait-objects.html)
- [Object-Safe Traits](https://doc.rust-lang.org/book/ch17-02-trait-objects.html#object-safety-is-required-for-trait-objects)

✔️ **Validation:**

Your plugin system must:
- ✅ Define a `Plugin` trait with required methods
- ✅ Implement the trait for multiple plugin types
- ✅ Allow registering plugins dynamically
- ✅ Execute plugins by name
- ✅ Enable/disable plugins
- ✅ Handle errors gracefully

## Step 7 - RPN Calculator with History

📑 **Description:**

In this exercise, you'll create an RPN (Reverse Polish Notation) calculator with history tracking and file persistence. This will teach you how to build an interactive CLI application, manage state, persist data, and implement undo functionality.

📌 **What you need to do:**

### Step 7.1 - Create the basic RPN calculator

Create a new module `src/rpn_calculator.rs` with a `RpnCalculator` struct that contains:
- A stack (vector) to store numbers
- Methods for basic operations:
  - `push(value: f64)` - Push a number onto the stack
  - `add()` - Pop two numbers, add them, push result
  - `subtract()` - Pop two numbers, subtract them, push result
  - `multiply()` - Pop two numbers, multiply them, push result
  - `divide()` - Pop two numbers, divide them, push result
  - `display()` - Show the current stack

Handle errors: if there aren't enough numbers on the stack for an operation, return an appropriate error.

### Step 7.2 - Add history tracking

Add history tracking to your calculator. Create a structure to represent a history entry that contains:
- The operation performed (e.g., "push 5", "add", "multiply")
- The state of the stack before the operation
- The state of the stack after the operation
- A timestamp (optional)

Store history entries in a vector. Each time an operation is performed, add an entry to the history.

### Step 7.3 - Implement undo functionality

Implement an `undo` command that:
- Retrieves the last history entry
- Restores the stack to its state before the last operation
- Removes the last entry from history (or marks it as undone)

Handle the case where there's no history to undo. You may want to keep undone operations in a separate "redo" stack for future implementation.

### Step 7.4 - Implement history display

Implement a `history` command that displays all operations in the history. Format the output clearly, showing:
- Operation number or index
- The operation performed
- The stack state before and after (optional, can be verbose)

You may want to limit the number of entries displayed or add pagination for large histories.

### Step 7.5 - Create a CLI interface

Create a command-line interface for your calculator:
- Read user input from stdin
- Parse commands: `push <number>`, `add`, `sub`, `mul`, `div`, `undo`, `history`, `quit`
- Execute commands and display results
- Handle invalid commands gracefully

Use a loop to continuously read commands until the user types `quit`.

### Step 7.6 - Add file persistence

Implement saving and loading history to/from a file:
- `save_history(&self, file_path: &str)` - Serialize the history to JSON and save to a file
- `load_history(&mut self, file_path: &str)` - Load history from a file and deserialize

Use `serde` and `serde_json` for serialization. Define a serializable structure for history entries. Handle file errors gracefully (file not found, permission errors, invalid JSON, etc.).

### Step 7.7 - Load history on startup

Modify your calculator's initialization to automatically load history from a file if it exists. You can use a default path like `calculator_history.json` or allow the user to specify a path.

### Step 7.8 - Make it thread-safe (Optional)

If you want to support multiple users or concurrent access, wrap your calculator state (stack and history) in `Arc<Mutex<>>` to make it thread-safe. This allows multiple threads to safely access and modify the calculator state.

**Constraints to follow:**
- Implement basic RPN calculator operations (push, add, subtract, multiply, divide)
- Track all operations in history
- Implement `undo` to reverse the last operation
- Implement `history` command to display operations
- Create a CLI interface for user interaction
- Save history to a file using JSON serialization
- Load history from a file on startup
- Handle file errors gracefully
- Make it thread-safe if supporting multiple users

📚 **Documentation:**

- [File Persistence](https://doc.rust-lang.org/std/fs/index.html)
- [Serialization](https://serde.rs/)
- [serde_json](https://docs.rs/serde_json/)

✔️ **Validation:**

Your calculator must:
- ✅ Perform basic RPN operations (push, add, subtract, multiply, divide)
- ✅ Have a working CLI interface
- ✅ Track operation history
- ✅ Support `undo` command to reverse operations
- ✅ Support `history` command to display operations
- ✅ Save history to a file
- ✅ Load history from a file on startup
- ✅ Handle file errors gracefully
- ✅ Be thread-safe (if supporting multiple users)

## Step 8 - Make it the Cutest Code You've Ever Seen

📑 **Description:**

Organize and document your code properly. Use Rust's best practices.

📌 **Tasks:**

1. Use `cargo fmt` to format your code
2. Run `cargo clippy` for suggestions
3. Add documentation comments
4. Organize code into modules
5. Write unit tests

📚 **Documentation:**

- [Rust Documentation Comments](https://doc.rust-lang.org/book/ch14-02-publishing-to-crates-io.html#documentation-comments-as-tests)
- [Testing](https://doc.rust-lang.org/book/ch11-00-testing.html)

✔️ **Validation:**

Your code should be well-formatted, documented, and tested.

## Bonus Challenge

📑 **Description:**

Create a **multi-threaded chat server** to showcase all your skills.

📌 **Tasks:**

Create a multi-threaded chat server with:
- Accepts multiple clients simultaneously
- Broadcasts messages to all clients
- Handles disconnection properly
- Special commands (`/help`, `/users`, `/quit`)
- Conversation logs in a file

**Estimated time**: 4-5 hours

## 📚 Additional Resources

- [The Rust Book - Advanced](https://doc.rust-lang.org/book/ch19-00-advanced-features.html)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
- [Rust Async Book](https://rust-lang.github.io/async-book/) (for future learning)

## ✅ End of Day Checklist

- [ ] I understand lifetimes and can annotate them
- [ ] I've created and implemented custom traits
- [ ] I handle errors with `Result` and `?`
- [ ] I've created multi-threaded programs
- [ ] I use iterators efficiently
- [ ] My code compiles without warnings
- [ ] I've written unit tests

## 💡 Tips

- Use `cargo test` to test your code
- `RUST_BACKTRACE=1` for detailed backtraces
- Lifetimes are often inferred, only annotate when necessary
- Prefer iterators over manual loops
- Use `clippy` for advanced suggestions

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
