# 🌐 Day 02 - Web Track: React Fundamentals

Welcome to Day 2 of the Software Pool 2026! 🚀

Today, you'll discover React, the most popular JavaScript framework for building modern web applications. React is the foundation of modern web development, used by companies like Facebook, Netflix, Airbnb, and many others.

## Day Purposes

✔️ Understand React fundamentals (components, props, state)

✔️ Create reusable React components

✔️ Manage component state with hooks

✔️ Handle user events in React

✔️ Use React hooks (useState, useEffect, etc.)

✔️ Build interactive React applications

✔️ Understand JSX and component composition

✔️ Work with forms and controlled components

## Introduction

### Why React?

React is the most popular JavaScript framework for building user interfaces. It's used by millions of developers worldwide and powers some of the biggest web applications. React enables:

- **Component-based architecture** - Build reusable UI components
- **Declarative programming** - Describe what you want, React handles how
- **Virtual DOM** - Efficient updates and rendering
- **Rich ecosystem** - Thousands of libraries and tools
- **Industry standard** - Most in-demand skill for frontend developers
- **TypeScript support** - Build type-safe applications

### Key Features of React:

- **Components** - Reusable pieces of UI
- **Props** - Pass data to components
- **State** - Manage component data
- **Hooks** - Modern way to use state and side effects
- **JSX** - Write HTML-like syntax in JavaScript
- **One-way data flow** - Predictable data flow
- **Fast rendering** - Virtual DOM optimizations

## Warm Up

Before diving into React, make sure you understand these JavaScript concepts (from Day 1):

1. **ES6+ JavaScript** (essential for React):
   - Arrow functions: `const add = (a, b) => a + b`
   - Destructuring: `const { name, age } = user`
   - Template literals: `` `Hello ${name}` ``
   - Array methods: `map`, `filter`, `reduce`
   - Spread operator: `[...array, newItem]`

2. **React Concepts** (you'll learn these today):
   - Components - Building blocks of React apps
   - JSX - HTML-like syntax in JavaScript
   - Props - Passing data to components
   - State - Managing component data
   - Hooks - `useState`, `useEffect`, etc.

3. **Development Tools**:
   - Node.js and npm (for installing packages)
   - Vite (fast build tool for React)
   - React DevTools (browser extension)
   - VS Code with React extensions

Here are useful links to get started:

- [React Official Documentation](https://react.dev/) - Start here!
- [React Tutorial](https://react.dev/learn) - Interactive tutorial
- [JSX Introduction](https://react.dev/learn/writing-markup-with-jsx)
- [React Hooks](https://react.dev/reference/react)

## Step 0 - Setup

📑 **Description:**

Set up your React development environment. We'll use Vite, a modern build tool that's fast and easy to use.

📌 **Tasks:**

1. **Create a new React project with Vite:**
```bash
npm create vite@latest my-react-app -- --template react
cd my-react-app
npm install
```

2. **For TypeScript (recommended):**
```bash
npm create vite@latest my-react-app -- --template react-ts
cd my-react-app
npm install
```

3. **Start the development server:**
```bash
npm run dev
```

4. **Open your browser** to the URL shown (usually `http://localhost:5173`)

You should see the default React welcome page. Explore the project structure:
- `src/` - Your source code
- `src/main.jsx` or `src/main.tsx` - Entry point
- `src/App.jsx` or `src/App.tsx` - Main App component
- `index.html` - HTML template

5. **Install React DevTools** (browser extension):
   - Chrome: [React Developer Tools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi)
   - Firefox: [React Developer Tools](https://addons.mozilla.org/en-US/firefox/addon/react-devtools/)

📚 **Documentation:**

- [Vite Getting Started](https://vitejs.dev/guide/)
- [React Quick Start](https://react.dev/learn)
- [Create React App (alternative)](https://create-react-app.dev/) - Older but still used

✔️ **Validation:**

Your development server should start and display the React welcome page. You should be able to see React components in the browser DevTools.

## Step 1 - Your First React Components

📑 **Description:**

Learn the fundamentals of React: components, JSX, and props. Create your first React components.

📌 **What you need to do:**

### Step 1.1 - Understand JSX

JSX lets you write HTML-like syntax in JavaScript. Learn:
- How to write JSX (it's like HTML but in JavaScript)
- JSX rules (one parent element, className instead of class, etc.)
- Embedding JavaScript expressions in JSX with `{}`
- Conditional rendering (`{condition && <Component />}`)

### Step 1.2 - Create Functional Components

Create your first React components:
- **Simple component**: A component that returns JSX
- **Component with props**: A component that receives and uses props
- **Component composition**: Use one component inside another

Create at least 3 components:
1. A `Header` component that displays a title
2. A `Button` component that accepts `text` and `onClick` props
3. A `Card` component that displays content with a title and description

### Step 1.3 - Use Components in Your App

Import and use your components in `App.jsx`:
- Import components
- Pass props to components
- Compose multiple components together

**What to understand:**
- Components are functions that return JSX
- Props are how you pass data to components
- Components are reusable
- Component names must start with a capital letter

**Constraints to follow:**
- Use functional components (not class components)
- Use TypeScript if you set up a TypeScript project
- Keep components small and focused
- Use meaningful prop names

📚 **Documentation:**

- [React Components](https://react.dev/learn/your-first-component)
- [JSX in Depth](https://react.dev/learn/writing-markup-with-jsx)
- [Props](https://react.dev/learn/passing-props-to-a-component)

✔️ **Validation:**

You should be able to:
- ✅ Create functional components
- ✅ Use JSX syntax correctly
- ✅ Pass and use props
- ✅ Compose components together
- ✅ See your components render in the browser

## Step 2 - State Management with useState

📑 **Description:**

Learn to manage component state with the `useState` hook. State allows your components to be interactive and dynamic.

📌 **What you need to do:**

### Step 2.1 - Understand useState Hook

Learn how `useState` works:
- Import `useState` from React
- Call `useState(initialValue)` to create state
- Use the state value and setter function
- Update state with the setter function

### Step 2.2 - Create a Counter Component

Create a counter component that:
- Displays a number
- Has a button to increment the number
- Has a button to decrement the number
- Has a button to reset to 0

This teaches you the basics of state management.

### Step 2.3 - Create an Input Component

Create a component with an input field that:
- Displays what you type in real-time
- Shows the character count
- Has a button to clear the input

This teaches you controlled components (inputs controlled by React state).

### Step 2.4 - Build a Simple Todo List

Now build a todo list application:
- **State**: An array of todo items
- **Add todo**: Input field and button to add new todos
- **Display todos**: List all todos
- **Toggle completion**: Click to mark as complete/incomplete
- **Delete todo**: Button to remove a todo

Each todo should have: `id`, `text`, `completed` properties.

**What to understand:**
- State is local to each component
- State updates trigger re-renders
- Never mutate state directly, always use the setter
- Arrays and objects in state need special handling

**Constraints to follow:**
- Use `useState` for all state management
- Use TypeScript interfaces/types for todo structure
- Handle edge cases (empty input, etc.)
- Keep components organized

📚 **Documentation:**

- [useState Hook](https://react.dev/reference/react/useState)
- [State: A Component's Memory](https://react.dev/learn/state-a-components-memory)
- [Updating Objects in State](https://react.dev/learn/updating-objects-in-state)
- [Updating Arrays in State](https://react.dev/learn/updating-arrays-in-state)

✔️ **Validation:**

You should be able to:
- ✅ Use `useState` to manage component state
- ✅ Update state correctly (especially arrays and objects)
- ✅ Create interactive components
- ✅ Build a working todo list application

## Step 3 - useEffect Hook and Side Effects

📑 **Description:**

Learn to handle side effects (API calls, timers, subscriptions) with the `useEffect` hook. This is essential for building real-world applications.

📌 **What you need to do:**

### Step 3.1 - Understand useEffect

Learn how `useEffect` works:
- Import `useEffect` from React
- `useEffect` runs after render
- Dependencies array controls when it runs
- Cleanup function for cleanup

### Step 3.2 - Fetch Data from an API

Create a component that fetches and displays data:
- Use `fetch` to get data from an API (e.g., JSONPlaceholder, a free API)
- Display a loading state while fetching
- Display the data when loaded
- Handle errors

Example APIs to use:
- [JSONPlaceholder](https://jsonplaceholder.typicode.com/) - Fake REST API
- [Dog API](https://dog.ceo/dog-api/) - Random dog images
- [Cat Facts API](https://catfact.ninja/) - Random cat facts

### Step 3.3 - Timer Component

Create a timer component:
- Start/stop/pause functionality
- Display elapsed time
- Use `useEffect` with `setInterval`
- Clean up the interval when component unmounts

### Step 3.4 - localStorage Integration

Enhance your todo list from Step 2:
- Save todos to `localStorage` when they change
- Load todos from `localStorage` on component mount
- Use `useEffect` to sync with `localStorage`

**What to understand:**
- `useEffect` runs after render
- Empty dependency array `[]` = run once on mount
- Dependencies in array = run when dependencies change
- Cleanup prevents memory leaks

**Constraints to follow:**
- Always include dependencies in the dependency array
- Clean up timers/subscriptions
- Handle loading and error states
- Use TypeScript for API response types

📚 **Documentation:**

- [useEffect Hook](https://react.dev/reference/react/useEffect)
- [Synchronizing with Effects](https://react.dev/learn/synchronizing-with-effects)
- [You Might Not Need an Effect](https://react.dev/learn/you-might-not-need-an-effect)

✔️ **Validation:**

You should be able to:
- ✅ Use `useEffect` for side effects
- ✅ Fetch data from APIs
- ✅ Handle loading and error states
- ✅ Clean up effects properly
- ✅ Integrate with browser APIs (localStorage, timers)

## Step 4 - Forms and Controlled Components

📑 **Description:**

Learn to handle forms in React. Forms are essential for user input in web applications.

📌 **What you need to do:**

### Step 4.1 - Controlled Inputs

Create a form with controlled inputs:
- Input fields controlled by React state
- Handle `onChange` events
- Handle form submission with `onSubmit`
- Prevent default form behavior

### Step 4.2 - Contact Form Component

Create a contact form with:
- Name input
- Email input (with validation)
- Message textarea
- Submit button
- Display submitted data (or show success message)

### Step 4.3 - Form Validation

Add validation to your form:
- Required field validation
- Email format validation
- Show error messages
- Disable submit button if form is invalid

### Step 4.4 - Search Component

Create a search component:
- Input field for search query
- Debounce the search (wait for user to stop typing)
- Display search results
- Handle empty results

**What to understand:**
- Controlled components: value controlled by React state
- `onChange` handler updates state
- `onSubmit` handles form submission
- Form validation patterns

**Constraints to follow:**
- Use controlled components (not uncontrolled)
- Validate user input
- Provide user feedback (errors, success messages)
- Handle form submission properly

📚 **Documentation:**

- [Forms](https://react.dev/reference/react-dom/components/form)
- [Controlled Components](https://react.dev/reference/react-dom/components/input#controlling-an-input-with-a-state-variable)
- [Form Validation](https://react.dev/learn/escape-hatches#validating-input-with-a-reducer)

✔️ **Validation:**

You should be able to:
- ✅ Create forms with controlled inputs
- ✅ Handle form submission
- ✅ Validate form inputs
- ✅ Provide user feedback
- ✅ Build a working contact form

## Step 5 - Component Composition and Props Drilling

📑 **Description:**

Learn advanced component patterns: composition, prop drilling, and when to lift state up.

📌 **What you need to do:**

### Step 5.1 - Component Composition

Create a card component system:
- `Card` component (wrapper)
- `CardHeader` component
- `CardBody` component
- `CardFooter` component
- Compose them together using `children` prop

### Step 5.2 - Props Drilling

Create a multi-level component structure:
- Parent component with state
- Child component that receives props
- Grandchild component that receives props from child
- Understand prop drilling (passing props through multiple levels)

### Step 5.3 - Lift State Up

Create a temperature converter:
- Two input fields: Celsius and Fahrenheit
- When one changes, update the other
- State should be in a common parent component
- Both inputs are controlled by the same state

### Step 5.4 - Build a Product List

Create a product list application:
- List of products (array in state)
- Each product displayed in a `ProductCard` component
- Filter products by category
- Search products by name
- State management: where should state live?

**What to understand:**
- Component composition with `children`
- When to lift state up
- Props drilling and its limitations
- Component hierarchy and data flow

**Constraints to follow:**
- Use composition for reusable components
- Lift state to the appropriate level
- Keep components focused and small
- Use TypeScript for prop types

📚 **Documentation:**

- [Composition vs Inheritance](https://react.dev/learn/passing-data-deeply-with-context#the-problem-with-passing-props)
- [Lifting State Up](https://react.dev/learn/sharing-state-between-components)
- [Passing Data Deeply with Context](https://react.dev/learn/passing-data-deeply-with-context)

✔️ **Validation:**

You should be able to:
- ✅ Compose components using children
- ✅ Understand when to lift state up
- ✅ Pass props through multiple component levels
- ✅ Build a multi-component application

## Step 6 - Complete Todo Application with React

📑 **Description:**

Build a complete, polished todo application using all the React concepts you've learned. This will be your first real React application!

📌 **What you need to do:**

### Step 6.1 - Enhanced Todo List

Build a complete todo application with:
- **Add todos**: Input field with add button
- **Display todos**: List all todos with checkboxes
- **Toggle completion**: Click checkbox to mark complete/incomplete
- **Delete todos**: Delete button for each todo
- **Filter todos**: Show all, active only, or completed only
- **Edit todos**: Double-click to edit (or edit button)
- **Clear completed**: Button to remove all completed todos
- **Todo counter**: Display "X tasks remaining"
- **localStorage**: Persist todos across page reloads

### Step 6.2 - Component Structure

Organize your components:
- `TodoApp` - Main component (manages state)
- `TodoForm` - Form to add new todos
- `TodoList` - List container
- `TodoItem` - Individual todo item
- `TodoFilter` - Filter buttons
- `TodoStats` - Statistics display

### Step 6.3 - Styling

Style your application:
- Modern, clean design
- Hover effects
- Smooth transitions
- Responsive layout
- Different styles for completed todos

### Step 6.4 - TypeScript (if using TypeScript)

Define types/interfaces:
- `Todo` interface
- Props interfaces for each component
- Type all functions and state

**What to understand:**
- Component structure and organization
- State management in a larger application
- Component composition
- Event handling
- Side effects (localStorage)

**Constraints to follow:**
- Use functional components and hooks
- Organize code into multiple components
- Use TypeScript if possible
- Persist data with localStorage
- Handle edge cases
- Clean, readable code

📚 **Documentation:**

- [Thinking in React](https://react.dev/learn/thinking-in-react) - Essential reading!
- [State Management](https://react.dev/learn/managing-state)
- [Component Organization](https://react.dev/learn/importing-and-exporting-components)

✔️ **Validation:**

Your todo application must:
- ✅ Have all CRUD operations (Create, Read, Update, Delete)
- ✅ Filter todos correctly
- ✅ Persist data in localStorage
- ✅ Be well-organized into components
- ✅ Have a modern, polished UI
- ✅ Handle all edge cases

## Step 7 - Custom Hooks

📑 **Description:**

Learn to create custom hooks to extract and reuse logic across components. This is a powerful pattern in React.

📌 **What you need to do:**

### Step 7.1 - Understand Custom Hooks

Learn the rules of hooks:
- Hooks must start with `use`
- Hooks can call other hooks
- Extract reusable logic into custom hooks

### Step 7.2 - Create useLocalStorage Hook

Create a custom `useLocalStorage` hook:
- Takes a key and initial value
- Returns the value and setter function
- Syncs with localStorage automatically
- Use it in your todo app to replace manual localStorage code

### Step 7.3 - Create useFetch Hook

Create a custom `useFetch` hook:
- Takes a URL
- Returns `{ data, loading, error }`
- Handles fetching, loading state, and errors
- Use it to fetch data in any component

### Step 7.4 - Create useDebounce Hook

Create a custom `useDebounce` hook:
- Takes a value and delay
- Returns debounced value
- Use it for search inputs

### Step 7.5 - Refactor Your Todo App

Refactor your todo app to use `useLocalStorage` hook:
- Replace manual localStorage code
- Make the code cleaner and more reusable

**What to understand:**
- Custom hooks extract reusable logic
- Hooks can use other hooks
- Custom hooks make code more maintainable
- Follow the rules of hooks

**Constraints to follow:**
- Hooks must start with `use`
- Only call hooks at the top level
- Extract logic that's used in multiple places
- Keep hooks focused and single-purpose

📚 **Documentation:**

- [Custom Hooks](https://react.dev/learn/reusing-logic-with-custom-hooks)
- [Rules of Hooks](https://react.dev/reference/rules/rules-of-hooks)
- [Building Your Own Hooks](https://react.dev/learn/reusing-logic-with-custom-hooks)

✔️ **Validation:**

You should be able to:
- ✅ Create custom hooks
- ✅ Extract reusable logic
- ✅ Use custom hooks in components
- ✅ Follow the rules of hooks
- ✅ Refactor code to use custom hooks

## Step 8 - Code Organization and Best Practices

📑 **Description:**

Learn React best practices and how to organize your code for maintainability and scalability.

📌 **What you need to do:**

### Step 8.1 - File Structure

Organize your React project:
- Create folders: `components/`, `hooks/`, `utils/`, `types/`
- Separate components into their own files
- Use index files for clean imports
- Group related components

### Step 8.2 - Component Organization

Follow React best practices:
- One component per file
- Use meaningful component and file names
- Extract constants and types
- Keep components small and focused

### Step 8.3 - Code Quality

Improve your code:
- Use TypeScript for type safety
- Add PropTypes or TypeScript types
- Remove unused code and imports
- Use consistent naming conventions
- Add comments where necessary

### Step 8.4 - Performance Considerations

Learn basic performance tips:
- Use `key` prop correctly in lists
- Avoid unnecessary re-renders
- Use `useMemo` and `useCallback` when appropriate (advanced)
- Optimize images and assets

### Step 8.5 - Refactor Your Todo App

Refactor your todo application:
- Organize into proper folder structure
- Extract types/interfaces
- Create utility functions
- Improve code organization
- Add TypeScript types everywhere

**What to understand:**
- Project structure matters
- Small, focused components are better
- TypeScript helps catch errors early
- Code organization improves maintainability

**Constraints to follow:**
- Follow consistent naming conventions
- Organize files logically
- Use TypeScript if possible
- Keep components small
- Write clean, readable code

📚 **Documentation:**

- [React File Structure](https://react.dev/learn/importing-and-exporting-components)
- [React Best Practices](https://react.dev/learn/thinking-in-react)
- [TypeScript with React](https://react-typescript-cheatsheet.netlify.app/)

✔️ **Validation:**

Your code should be:
- ✅ Well-organized into folders
- ✅ Components in separate files
- ✅ Using TypeScript (if set up)
- ✅ Following naming conventions
- ✅ Clean and maintainable

## Bonus Challenge - Weather App

📑 **Description:**

Create a weather application that fetches data from an API. This combines everything you've learned: components, state, effects, forms, and API integration.

📌 **What you need to do:**

Create a weather application with:
- **City search**: Input field to search for cities
- **Current weather**: Display current weather for the city
- **5-day forecast**: Show forecast for next 5 days
- **Favorite cities**: Save favorite cities to localStorage
- **Loading states**: Show loader while fetching
- **Error handling**: Handle API errors gracefully

Use a free weather API:
- [OpenWeatherMap](https://openweathermap.org/api) - Free tier available
- [WeatherAPI](https://www.weatherapi.com/) - Free tier available

**Features to implement:**
- Search for weather by city name
- Display temperature, humidity, wind speed, etc.
- Show weather icons
- Display 5-day forecast
- Save/remove favorite cities
- Switch between favorite cities

**Component structure:**
- `WeatherApp` - Main component
- `SearchBar` - City search input
- `CurrentWeather` - Current weather display
- `Forecast` - 5-day forecast
- `FavoriteCities` - List of favorite cities

**Estimated time**: 2-3 hours

📚 **Documentation:**

- [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)
- [OpenWeatherMap API](https://openweathermap.org/api)
- [Async/Await](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function)

## 📚 Additional Resources

- [React Official Documentation](https://react.dev/) - The best resource!
- [React Tutorial](https://react.dev/learn) - Interactive tutorial
- [React Beta Docs](https://beta.react.dev/) - Latest React documentation
- [React TypeScript Cheatsheet](https://react-typescript-cheatsheet.netlify.app/) - TypeScript + React
- [Awesome React](https://github.com/enaqx/awesome-react) - Curated list of React resources
- [React Patterns](https://reactpatterns.com/) - Common React patterns

## ✅ End of Day Checklist

- [ ] I understand React components and JSX
- [ ] I can use `useState` to manage component state
- [ ] I can use `useEffect` for side effects
- [ ] I can create forms with controlled components
- [ ] I understand component composition
- [ ] I can create custom hooks
- [ ] I've built a complete React application (todo app)
- [ ] My code is organized and follows best practices
- [ ] I'm ready to learn routing and more advanced React concepts!

## 💡 Tips

- **Read the React docs** - They're excellent and up-to-date
- **Use React DevTools** - Essential for debugging
- **Think in components** - Break UI into reusable pieces
- **Don't mutate state** - Always use setters
- **Use TypeScript** - It catches errors early
- **Keep components small** - Single responsibility principle
- **Practice, practice, practice** - Build more apps to solidify your knowledge
- **Read error messages carefully** - React gives helpful error messages

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
