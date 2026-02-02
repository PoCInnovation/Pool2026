# ⚙️ Day 01 - Software Track: Rust Fundamentals

Welcome to the Software Pool 2026! 🚀

During this first day, you will discover Rust, a modern, safe, and performant systems programming language. Rust is designed to give you the performance of C++ with the safety guarantees of modern languages.

## Day Purposes

✔️ Setup a Rust project

✔️ Learn basics of Rust

✔️ Discover software development good practices

✔️ Understand ownership and borrowing (unique Rust concepts)

✔️ Create interactive terminal applications

## Introduction

### Why Rust?

Rust is an open-source programming language created and maintained by Mozilla (now the Rust Foundation). It solves several problems of modern software development thanks to its simplicity and incredible standard library.

**Rust's killer features:**

- **Memory safety without garbage collection** - Prevents common bugs like null pointer dereferences and data races
- **Zero-cost abstractions** - High-level features compile to efficient code
- **Fearless concurrency** - Easily solve complex concurrency issues with goroutines
- **Strongly statically typed** - Catches errors at compile time
- **Amazing dependency management** - Cargo makes dependency management a breeze
- **Multi-paradigm** - Supports OOP, functional, and imperative programming styles
- **Incredible performance** - Comparable to C/C++ performance

Rust has many uses: you can write powerful cloud & network services, CLI tools, APIs, embedded systems, or DevOps tools. Because it's a compiled language, it's really fast, much faster than JavaScript for instance 🏃

### Requirements

Rust comes with a complete CLI toolchain. You can manage any Rust project from its command line.

With it, you can build Rust binaries, download dependencies, format your code, run tests, and more. If you're curious, you can look at the [Cargo documentation](https://doc.rust-lang.org/cargo/) 😉

Start by installing Rust, you can verify that everything works using the command below:

```bash
# Version must be at least 1.70
rustc --version
# rustc 1.75.0 (82e1608df 2024-01-17)

cargo --version
# cargo 1.75.0 (1d8b05cdd 2024-01-11)
```

If you have any issue, don't hesitate to ask the staff for help 😄

## Warm Up

Let's begin this pool with a simple warm up: **The Rust Book** and **Rustlings**

1. **Read the first chapters** of [The Rust Book](https://doc.rust-lang.org/book/) (Chapters 1-6)
2. **Try Rustlings** - Interactive exercises to learn Rust: [Rustlings](https://github.com/rust-lang/rustlings)
3. **Experiment** with [Rust Playground](https://play.rust-lang.org/) - A useful tool to test or share pieces of code

You will also need a good IDE. We recommend:
- **Visual Studio Code** with the [rust-analyzer extension](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer)
- **RustRover** (JetBrains IDE for Rust)
- **Vim/Neovim** with rust-analyzer LSP

In summary, here's a bunch of links that will be very useful during the pool:

- [The Rust Book](https://doc.rust-lang.org/book/)
- [Rust by Example](https://doc.rust-lang.org/rust-by-example/)
- [Rust Playground](https://play.rust-lang.org/)
- [Rustlings](https://github.com/rust-lang/rustlings)
- [Rust Standard Library](https://doc.rust-lang.org/std/)
- [Cargo Book](https://doc.rust-lang.org/cargo/)

## Step 0 - Setup

📑 **Description:**

As usual, every exercise must be pushed to a git repository. Let's set up your first Rust project.

📌 **Tasks:**

1. Create a folder for Day 1:
```bash
mkdir -p day1
cd day1
```

2. Initialize a Rust project:
```bash
cargo new hello_rust
cd hello_rust
```

You should see a `Cargo.toml` file and a `src` directory appear.

3. Create your first Rust file. The `src/main.rs` should already exist with:
```rust
fn main() {
    println!("Hello, world!");
}
```

📚 **Documentation:**

- 💡 If you're curious about this, check the [fmt package documentation](https://doc.rust-lang.org/std/fmt/)

✔️ **Validation:**

Let's execute it:

```bash
# Use `cargo run` to execute your program without building the binary
cargo run

# You can also build and run it in separate commands
cargo build
./target/debug/hello_rust  # On Windows: .\target\debug\hello_rust.exe

# You should have the following output
> Hello, world!
```

Before going further, read the first chapters of The Rust Book and try some Rustlings exercises. Those core concepts are important to understand the rest of the pool 💯

## Step 1 - Hello World

📑 **Description:**

It's time to start coding! We will start with a simple helloWorld package.

📌 **Tasks:**

1. Create a new module file `src/hello_world.rs`:
```rust
pub fn hello_world() {
    println!("Hello World!");
}
```

2. Add the module to `src/main.rs`:
```rust
mod hello_world;

fn main() {
    hello_world::hello_world();
}
```

Don't forget to add the correct package name at the top of each file 😉

📚 **Documentation:**

- 💡 Here's a couple of slides about [what is good naming in Go](https://go.dev/doc/effective_go#names) (similar principles apply to Rust)
- [Rust Modules](https://doc.rust-lang.org/book/ch07-02-defining-modules-to-control-scope-and-privacy.html)

✔️ **Validation:**

```bash
cargo run

# You should have the following output
> Hello World!
```

## Step 2 - Loops, Conditions, Arrays and Unit Tests

📑 **Description:**

The purpose of this step is to use what you have learned during the warm-up 👀

Let's create a function to sort numbers, so we can cover useful concepts such as loops, conditions, arrays and tests 🥳

📌 **Tasks:**

Your function must:
- Sort a list in ascending order
- Remove odd numbers
- Format the result to return

### Sort like a pro

1. Create a new module `src/get_even_numbers.rs`:
```rust
pub fn get_even_numbers(numbers: &[i32]) -> String {
    // Your implementation here
}
```

2. Update `main.rs` to call `get_even_numbers` and display the result:
```rust
mod get_even_numbers;

fn main() {
    let array = vec![1, 0, 19, 17, 16, 8, 13, 24];
    println!("{}", get_even_numbers::get_even_numbers(&array));
}
```

📚 **Documentation:**

- [Rust Vectors](https://doc.rust-lang.org/book/ch08-01-vectors.html)
- [Rust Slices](https://doc.rust-lang.org/book/ch04-03-slices.html)
- [Rust Sorting](https://doc.rust-lang.org/std/primitive.slice.html#method.sort)

✔️ **Validation:**

You should have the following result:

```
0 - 8 - 16 - 24
```

### Test like a pro 🧪

📑 **Description:**

It's really important to correctly test your code. Untested code can lead to unpredictable bugs, and the time lost debugging could be avoided by creating some tests.

📚 **Documentation:**

To do so, Rust provides a built-in test framework with a clean way to organize your tests 💥

Let's create a test file `src/get_even_numbers_test.rs` or add tests in the same file.

📌 **Tasks:**

To make sure your `get_even_numbers` works as intended, write a test for each of these cases:

- Only positive numbers
- Only negative numbers
- Mixed numbers

Example test structure:
```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_get_even_numbers_positive() {
        let numbers = vec![1, 2, 3, 4, 5, 6];
        assert_eq!(get_even_numbers(&numbers), "2 - 4 - 6");
    }
}
```

✔️ **Validation:**

You can then execute them with `cargo test`, which should produce a result similar to this one:

```bash
cargo test

running 3 tests
test get_even_numbers::tests::test_get_even_numbers_positive ... ok
test get_even_numbers::tests::test_get_even_numbers_negative ... ok
test get_even_numbers::tests::test_get_even_numbers_mixed ... ok

test result: ok. 3 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out
```

## Step 3 - My Name Is...

📑 **Description:**

Now it's time to learn how to read input from the terminal 🤩

📌 **Tasks:**

Create a new module `src/what_is_your_name.rs` with a function `what_is_your_name` inside it.

This function must display a prompt in the terminal to ask a user to fill their name and retrieve it.

📚 **Documentation:**

To do so, you can use the `std::io` module 😉

Example:
```rust
use std::io;

pub fn what_is_your_name() -> String {
    println!("What is your name?");
    let mut name = String::new();
    io::stdin().read_line(&mut name).expect("Failed to read line");
    name.trim().to_string()
}
```

✔️ **Validation:**

You should end up with the following behavior:

```
What is your name?
# User fills input
> Slim Shady

# Display input
Your name is Slim Shady
```

Don't forget to call it from `main.rs` and correctly manage errors.

💡 Display your errors using the `log` crate or `eprintln!` macro.

## Step 4 - Make it the Cutest Code You've Ever Seen

📑 **Description:**

As we said in the introduction, Rust comes with great built-in tools to help you during your development.

📚 **Documentation:**

One of these tools is `rustfmt`, a powerful formatting tool that will help you have standard coding style rules in your code.

It's really helpful for formatting, but having clean code architecture is up to you 🚀

📌 **Tasks:**

To use `rustfmt`, just launch `cargo fmt` at the root of your module 😉

You can also configure VSCode or RustRover to format your code on save.

```bash
cargo fmt
```

Also try `cargo clippy` for linting suggestions:

```bash
cargo clippy
```

## Step 5 - Task Manager v1.0

📚 **Documentation:**

You are ready for a complex exercise. Let's create your first application!

It will be a program that helps you manage tasks from your terminal.

We will not code everything in one step, that would be too huge for this moment.

⚠️ **Read the whole step before coding**, it will help you understand what to do and how to do it.

📌 **Tasks:**

Let's start with a simple implementation. The goal is to have a CLI similar to this one:

```
Welcome to your Task Manager!

What do you want to do?
1 - List all tasks
2 - Add a task
3 - Leave

# User types input
> 3

Type 1, 2, or 3.

# User types input
> 1

Here are your tasks:
-- 1 -- [ ] Buy groceries
-- 2 -- [X] Finish homework
-- 3 -- [ ] Call mom

What do you want to do?
1 - List all tasks
2 - Add a task
3 - Leave

# User types input
> 3

See you!
```

📚 **Documentation:**

To do this, we must build a program that follows a strong architecture. We will use one of the most popular: **MVC (Model-View-Controller)**.

MVC stands for Model - View - Controller. It's an architecture where your code logic is split into smaller parts to easily maintain and scale a project.

Here's a schema of your architecture:

```
┌─────────┐
│  Router │  ← Entry point, main loop
└────┬────┘
     │
     ├───→ Controller ───→ Repository ───→ Data (JSON file)
     │           │
     │           └───→ View ───→ User
     │
     └───→ Model (Task struct)
```

📌 **Tasks:**

Let's code step by step 😄

### Router

Router corresponds to the entry point of your program and the main loop.
It has different roles:
- Display actions to user
- Catch the user input
- Call controllers to execute the action asked by the user

A good architecture also requires good folder management in your code. Each resource must be in its own module.

- Create a module `src/router.rs`
- Create a function `router` that will do the loop described in the example
- Update `main.rs` to call `router`

### Controllers

A controller is in charge of the business logic that manages your resources.

Its only purpose is to create the link between the function that manages your data storage (for now it will be a simple JSON file) and functions exposed to the user.

- Create a module `src/controllers.rs`
- Create a sub-module `tasks` in it
- Create functions to control task operations

### Repositories

A repository is responsible for all interactions with the data storage.

- Create a module `src/repositories.rs`
- Create a sub-module `tasks` in it
- Write functions to retrieve and save tasks

📚 **Documentation:**

You will need the `std::fs` and `serde_json` crates to read/write JSON files.

Add to `Cargo.toml`:
```toml
[dependencies]
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
```

### Views

A view exposes a list of functions to the user to make them interact with a resource.

- Create a module `src/views.rs`
- Create a sub-module `tasks` in it
- Write functions to display tasks in the terminal

### Models

A model defines the type of the stored data.

- Create a module `src/models.rs`
- Create a struct `Task` that contains:
  - `id: u32`
  - `description: String`
  - `completed: bool`

### Data

Data defines your storage. Here, it will be a simple JSON file.

📚 **Documentation:**

JSON stands for JavaScript Object Notation. It's a standard like CSV, XML or YAML used to define structured data.

We'll discover real databases tomorrow 👀

Create a file `data/tasks.json` with the following content:

```json
[
  {
    "id": 1,
    "description": "Buy groceries",
    "completed": false
  },
  {
    "id": 2,
    "description": "Finish homework",
    "completed": true
  },
  {
    "id": 3,
    "description": "Call mom",
    "completed": false
  }
]
```

✔️ **Validation:**

Finally, you should have the following structure:

```
src/
  main.rs
  router.rs
  controllers.rs
    tasks/
  repositories.rs
    tasks/
  views.rs
    tasks/
  models.rs
data/
  tasks.json
Cargo.toml
```

This exercise may seem hard, but if you write your code step by step, it will be a piece of cake 🍰!

## Step 6 - Task Manager v2.0

📑 **Description:**

You've built the base of your MVC architecture, it's time to improve it 📈

For now, you can only read data. Let's add operations to create, update, or delete it.

Those four primitive operations are mandatory to manage a resource in data storage.

📚 **Documentation:**

They are usually called **CRUD**, which stands for **CREATE - READ - UPDATE - DELETE**.

📌 **Tasks:**

Let's add the missing ones 🚀

### CREATE

Update your codebase to allow a user to add a new task to their list.

- Add a function `create` in your tasks repository
- Add a function `ask_description` in your views
- Add a function `create` in your controllers
- Update the router to allow task creation

⚠️ You will need to write the whole `tasks.json` file. Take care not to lose data when you rewrite the file.

### UPDATE

Update your application to allow the user to mark a task as completed or update its description.

### DELETE

Update your codebase to allow the user to remove a task from their list.

It's up to you to find the best way to do it 🚀

✔️ **Validation:**

You should have a complete CRUD application working from the terminal.

## Step 7 - Task Manager v3.0

📑 **Description:**

You have implemented a complete MVC architecture, that's excellent 🚀

Only one thing is missing: our data is too basic. Let's add some fields.

📌 **Tasks:**

Update the `Task` structure to add:
- `created_at: chrono::DateTime<chrono::Utc>` - Creation timestamp
- `priority: Priority` - Task priority (enum: Low, Medium, High)
- `tags: Vec<String>` - Tags for categorization

You'll have to update all your codebase to support those new fields.

Don't worry, it's not that hard because you have built a strong architecture!
And if you struggle, remember that the staff is here to help you out 😃

📚 **Documentation:**

Add to `Cargo.toml`:
```toml
chrono = { version = "0.4", features = ["serde"] }
```

## Step 8 - Interfaces (Traits)

📑 **Description:**

It's time to learn another important concept in Rust: **traits** (similar to interfaces in other languages).

To do so, we will do a simple example with geometric shapes 🟥

📌 **Tasks:**

Let's create a module `src/geometric_shape.rs`.

### Definition

Inside it, create a trait `GeometricShape` with a method `calc_perimeter`.

This method must have the following signature:

```rust
trait GeometricShape {
    fn calc_perimeter(&self) -> f64;
}
```

Create a function `calc_perimeter` that will take a reference to something implementing `GeometricShape` and return the result:

```rust
fn calc_perimeter(shape: &dyn GeometricShape) -> f64 {
    shape.calc_perimeter()
}
```

### Shapes

Create the struct `Circle` with a field `radius: f64`.
Create the struct `Rectangle` with fields `x: f64` and `y: f64`.
Create the struct `Triangle` with fields `x: f64`, `y: f64`, and `z: f64`.

For each shape, implement the trait `GeometricShape`:

```rust
impl GeometricShape for Circle {
    fn calc_perimeter(&self) -> f64 {
        2.0 * std::f64::consts::PI * self.radius
    }
}
```

### Upgrade

Update the file `main.rs` to create 3 shapes and display their perimeter.

As you can see, the default display is not clear. Let's use the power of traits to fix that 😃

📚 **Documentation:**

The `fmt::Display` trait controls how values are formatted. If our structures implement `Display`, we can control how they're displayed.

Update your structures to implement `Display`:

```rust
use std::fmt;

impl fmt::Display for Circle {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "Circle: {{ radius = {} }}", self.radius)
    }
}
```

Thanks to traits, you don't have to change anything in `main.rs`, just rerun the program and appreciate the moment 😍

✔️ **Validation:**

```
Circle: { radius = 12 } has a perimeter of 75.398224
Rectangle: { X = 2, Y = 3 } has a perimeter of 10.000000
Triangle: { X = 5, Y = 2, Z = 1 } has a perimeter of 8.000000
```

## Step 9 - Task Manager v4.0

📑 **Description:**

Since you now know traits, why not use them in your MVC?

📌 **Tasks:**

The purpose is to update `Task` to correctly display it with the `fmt` package.

In your task model, implement the `Display` trait.

You can also update `DisplayAll` from your views to use a simple `println!` to display tasks.

## Bonus

First, congratulations! You've survived day 1 👏

Your MVC currently manages only one resource: Task.

You can create a new resource named `Project` containing the following data:
- `id: u32` - Resource unique identifier
- `name: String` - Project name
- `tasks: Vec<Task>` - Tasks in this project
- `created_at: DateTime<Utc>` - Creation date

You're free to add any features to your application.

You can maybe start by adding the CRUD for your new `Project` resource.

📚 **Documentation:**

### Additional Resources

- [Clean Code in Rust](https://github.com/rust-lang/rust-clippy)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
- [Amazing Rust Projects](https://github.com/rust-unofficial/awesome-rust)
- [Rust Generics](https://doc.rust-lang.org/book/ch10-00-generics.html)
- [Rust Concurrency](https://doc.rust-lang.org/book/ch16-00-concurrency.html)
- [Rust Courses](https://github.com/ctjhoa/rust-learning)

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
