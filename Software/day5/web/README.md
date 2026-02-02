# 🌐 Day 05 - Web Track: Advanced React

Welcome to Day 5 of the Software Pool 2026! 🚀

Last day before the rush! Today, you'll dive deeper into React and learn advanced concepts: routing, state management, context API, and building full-stack applications.

## Day Purposes

✔️ Master React Router for navigation

✔️ Understand Context API for global state

✔️ Learn state management patterns

✔️ Build full-stack applications (React + Backend)

✔️ Deploy React applications

✔️ Learn advanced React patterns and optimizations

## Introduction

### Why Advanced React?

Now that you know the basics, it's time to build real-world applications. Advanced React concepts enable you to:

- **Build multi-page applications** - Routing between different pages
- **Manage global state** - Share state across many components
- **Optimize performance** - Make your apps fast and efficient
- **Integrate with backends** - Connect React to your APIs
- **Deploy applications** - Put your apps online

### What You'll Learn Today

- **React Router** - Navigation and routing
- **Context API** - Global state management
- **Advanced Hooks** - useReducer, useContext, useMemo, useCallback
- **API Integration** - Connect to your backend (Day 3)
- **Deployment** - Deploy to Vercel, Netlify, etc.
- **Performance** - Optimize React applications

## Warm Up

Before starting, make sure you're comfortable with:

1. **React Fundamentals** (from Day 2):
   - Components and JSX
   - Props and state
   - useState and useEffect hooks
   - Event handling
   - Component composition

2. **Backend Knowledge** (from Day 3):
   - REST APIs
   - HTTP methods (GET, POST, PUT, DELETE)
   - Fetch API or axios
   - Async/await

3. **Database Knowledge** (from Day 4):
   - Basic understanding of databases
   - API endpoints that return data

Here are useful links:

- [React Router Documentation](https://reactrouter.com/en/main)
- [React Context API](https://react.dev/learn/passing-data-deeply-with-context)
- [Advanced React Hooks](https://react.dev/reference/react)
- [Vercel Deployment](https://vercel.com/docs)

## Step 0 - Setup

📑 **Description:**

Set up your project for advanced React development. Install React Router and other necessary dependencies.

📌 **Tasks:**

1. **Create a new React project** (or use an existing one):
```bash
npm create vite@latest my-advanced-app -- --template react-ts
cd my-advanced-app
npm install
```

2. **Install React Router**:
```bash
npm install react-router-dom
```

3. **Install additional useful packages**:
```bash
npm install axios  # For API calls (alternative to fetch)
```

4. **Start the development server**:
```bash
npm run dev
```

5. **Project structure** - Organize your project:
```
src/
  components/
  pages/
  hooks/
  context/
  utils/
  types/
  App.tsx
  main.tsx
```

📚 **Documentation:**

- [React Router Installation](https://reactrouter.com/en/main/start/installation)
- [Vite Getting Started](https://vitejs.dev/guide/)

✔️ **Validation:**

Your development server should start successfully. You should have React Router installed and ready to use.

## Step 1 - React Router Basics

📑 **Description:**

Learn to create multi-page applications with React Router. Routing is essential for building real-world applications.

📌 **What you need to do:**

### Step 1.1 - Set up React Router

Set up React Router in your application:
- Install `react-router-dom`
- Wrap your app with `BrowserRouter`
- Create routes with `Routes` and `Route`
- Use `Link` component for navigation

### Step 1.2 - Create Multiple Pages

Create a simple multi-page application:
- **Home page** (`/`) - Welcome page
- **About page** (`/about`) - About information
- **Contact page** (`/contact`) - Contact form

Create separate components for each page in a `pages/` folder.

### Step 1.3 - Navigation Component

Create a navigation component:
- Navigation bar with links to all pages
- Use `Link` components for navigation
- Highlight active route
- Make it responsive

### Step 1.4 - Use NavLink

Use `NavLink` instead of `Link`:
- Automatically add active class to current route
- Style active links differently

**What to understand:**
- `BrowserRouter` enables routing
- `Routes` and `Route` define routes
- `Link` and `NavLink` for navigation
- `useNavigate` hook for programmatic navigation

**Constraints to follow:**
- Use TypeScript for route types
- Organize pages in separate files
- Create a reusable navigation component
- Handle 404 (not found) route

📚 **Documentation:**

- [React Router Tutorial](https://reactrouter.com/en/main/start/tutorial)
- [React Router API](https://reactrouter.com/en/main/routers/router)

✔️ **Validation:**

You should be able to:
- ✅ Navigate between different pages
- ✅ See URL changes in the browser
- ✅ Use browser back/forward buttons
- ✅ Have active link highlighting

## Step 2 - Dynamic Routes and URL Parameters

📑 **Description:**

Learn to create dynamic routes with URL parameters. This is essential for pages like user profiles, product details, blog posts, etc.

📌 **What you need to do:**

### Step 2.1 - Dynamic Routes

Create dynamic routes:
- Use `:param` syntax in routes (e.g., `/user/:id`)
- Access parameters with `useParams` hook
- Create pages that display different content based on URL

### Step 2.2 - Blog Application

Build a simple blog application:
- **Home page** (`/`) - List all blog posts
- **Post detail page** (`/post/:id`) - Show individual post
- **User profile page** (`/user/:username`) - Show user profile

Use mock data (array of posts/users) for now.

### Step 2.3 - Query Parameters

Learn to use query parameters:
- Access query params with `useSearchParams`
- Filter blog posts by category or tag
- Search functionality with query params

### Step 2.4 - Nested Routes

Create nested routes:
- `/blog` - Blog layout
- `/blog/posts` - List posts
- `/blog/posts/:id` - Post detail
- Use `Outlet` component for nested routes

**What to understand:**
- Dynamic routes with `:param`
- `useParams` to access route parameters
- `useSearchParams` for query parameters
- Nested routes with `Outlet`
- Programmatic navigation with `useNavigate`

**Constraints to follow:**
- Use TypeScript for route params
- Handle loading and error states
- Create reusable components
- Clean URL structure

📚 **Documentation:**

- [Dynamic Routes](https://reactrouter.com/en/main/route/route#dynamic-segments)
- [useParams](https://reactrouter.com/en/main/hooks/use-params)
- [useSearchParams](https://reactrouter.com/en/main/hooks/use-search-params)
- [Nested Routes](https://reactrouter.com/en/main/start/concepts#nested-routes)

✔️ **Validation:**

You should be able to:
- ✅ Create dynamic routes
- ✅ Access URL parameters
- ✅ Use query parameters
- ✅ Create nested routes
- ✅ Navigate programmatically

## Step 3 - Context API for Global State

📑 **Description:**

Learn to manage global state with Context API. This is essential for sharing state across many components without prop drilling.

📌 **What you need to do:**

### Step 3.1 - Understand Context API

Learn how Context works:
- `createContext` - Create a context
- `Provider` - Provide value to children
- `useContext` - Consume context value

### Step 3.2 - Create a Theme Context

Create a theme context:
- Dark/light mode toggle
- Provide theme and toggle function via context
- Use context in multiple components
- Persist theme preference in localStorage

### Step 3.3 - Create an Auth Context

Create an authentication context:
- User state (logged in/out)
- Login/logout functions
- Provide auth state globally
- Protect routes (redirect if not logged in)

### Step 3.4 - Refactor Todo App with Context

Refactor your todo app (from Day 2):
- Move todo state to context
- Share todos across multiple components
- Avoid prop drilling

**What to understand:**
- When to use Context vs local state
- Context Provider wraps components
- `useContext` accesses context value
- Multiple contexts can be used together
- Context can cause re-renders (be careful)

**Constraints to follow:**
- Create separate context files
- Use TypeScript for context types
- Provide default values
- Handle context outside Provider (optional)

📚 **Documentation:**

- [Context API](https://react.dev/learn/passing-data-deeply-with-context)
- [useContext Hook](https://react.dev/reference/react/useContext)
- [Context Best Practices](https://kentcdodds.com/blog/how-to-use-react-context-effectively)

✔️ **Validation:**

You should be able to:
- ✅ Create and use Context
- ✅ Share state across components
- ✅ Avoid prop drilling
- ✅ Use multiple contexts
- ✅ Handle context properly

## Step 4 - Connecting React to Your Backend API

📑 **Description:**

Connect your React frontend to the backend API you built on Day 3. Learn to fetch data, handle loading states, and manage API errors.

📌 **What you need to do:**

### Step 4.1 - Set up API Integration

Set up API calls:
- Create an API utility file (`utils/api.ts`)
- Use `fetch` or `axios` for API calls
- Create functions for each API endpoint
- Handle CORS if needed

### Step 4.2 - Fetch Data on Component Mount

Create components that fetch data:
- Use `useEffect` to fetch data on mount
- Display loading state while fetching
- Handle errors gracefully
- Display data when loaded

### Step 4.3 - Create/Update/Delete Operations

Implement CRUD operations:
- Create new resources (POST)
- Update existing resources (PUT/PATCH)
- Delete resources (DELETE)
- Optimistic updates (update UI before API responds)

### Step 4.4 - Connect Todo App to Backend

Connect your todo app to your backend:
- Fetch todos from API on mount
- Create todos via API
- Update todos via API
- Delete todos via API
- Handle loading and error states

### Step 4.5 - Create a Custom useFetch Hook

Create a reusable `useFetch` hook:
- Takes a URL and options
- Returns `{ data, loading, error, refetch }`
- Use it in multiple components
- Handle different HTTP methods

**What to understand:**
- API integration patterns
- Loading and error states
- Async operations in React
- Optimistic updates
- Custom hooks for API calls

**Constraints to follow:**
- Use TypeScript for API types
- Handle all error cases
- Show loading indicators
- Provide user feedback
- Organize API calls in utility files

📚 **Documentation:**

- [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)
- [Axios](https://axios-http.com/docs/intro)
- [React Data Fetching](https://react.dev/learn/synchronizing-with-effects#fetching-data)

✔️ **Validation:**

You should be able to:
- ✅ Fetch data from your backend API
- ✅ Create, update, and delete resources
- ✅ Handle loading and error states
- ✅ Use custom hooks for API calls
- ✅ Connect React to your backend successfully

## Step 5 - Advanced Hooks: useReducer and useMemo

📑 **Description:**

Learn advanced React hooks for complex state management and performance optimization.

📌 **What you need to do:**

### Step 5.1 - useReducer Hook

Learn `useReducer`:
- Alternative to `useState` for complex state
- Takes a reducer function and initial state
- Returns state and dispatch function
- Better for multiple state updates

### Step 5.2 - Refactor Todo App with useReducer

Refactor your todo app to use `useReducer`:
- Define reducer function with actions (ADD_TODO, TOGGLE_TODO, DELETE_TODO)
- Replace `useState` with `useReducer`
- Dispatch actions instead of direct state updates

### Step 5.3 - useMemo Hook

Learn `useMemo`:
- Memoize expensive calculations
- Only recalculate when dependencies change
- Improve performance

### Step 5.4 - useCallback Hook

Learn `useCallback`:
- Memoize functions
- Prevent unnecessary re-renders
- Use with `React.memo`

### Step 5.5 - Performance Optimization

Optimize a component:
- Use `React.memo` for component memoization
- Use `useMemo` for expensive calculations
- Use `useCallback` for function props
- Identify unnecessary re-renders

**What to understand:**
- `useReducer` for complex state logic
- `useMemo` for expensive calculations
- `useCallback` for function memoization
- When to optimize (don't over-optimize!)
- React DevTools Profiler

**Constraints to follow:**
- Use `useReducer` for complex state
- Use `useMemo` and `useCallback` appropriately
- Don't over-optimize
- Measure performance before optimizing

📚 **Documentation:**

- [useReducer](https://react.dev/reference/react/useReducer)
- [useMemo](https://react.dev/reference/react/useMemo)
- [useCallback](https://react.dev/reference/react/useCallback)
- [React Performance](https://react.dev/learn/render-and-commit)

✔️ **Validation:**

You should be able to:
- ✅ Use `useReducer` for complex state
- ✅ Use `useMemo` for expensive calculations
- ✅ Use `useCallback` for function memoization
- ✅ Optimize component performance
- ✅ Understand when to optimize

## Step 6 - Protected Routes and Authentication

📑 **Description:**

Learn to protect routes and handle authentication in React applications. This is essential for real-world apps.

📌 **What you need to do:**

### Step 6.1 - Create Protected Route Component

Create a `ProtectedRoute` component:
- Check if user is authenticated
- Redirect to login if not authenticated
- Render children if authenticated
- Use React Router's `Navigate` component

### Step 6.2 - Implement Authentication Flow

Build authentication:
- Login page with form
- Handle login API call
- Store token in localStorage or context
- Redirect after successful login
- Handle login errors

### Step 6.3 - Protected Pages

Create protected pages:
- Dashboard (protected)
- Profile (protected)
- Settings (protected)
- Use `ProtectedRoute` wrapper

### Step 6.4 - Logout Functionality

Implement logout:
- Clear authentication token
- Clear user state
- Redirect to login page
- Handle token expiration

### Step 6.5 - Auth Context

Create authentication context:
- User state (logged in/out, user data)
- Login/logout functions
- Token management
- Provide auth state globally

**What to understand:**
- Protected routes pattern
- Authentication flow
- Token storage and management
- Redirecting after auth
- Handling auth errors

**Constraints to follow:**
- Use Context for auth state
- Protect routes properly
- Handle token expiration
- Provide good UX (loading states, errors)

📚 **Documentation:**

- [Protected Routes](https://reactrouter.com/en/main/start/tutorial#adding-a-router)
- [Authentication](https://reactrouter.com/en/main/start/tutorial#adding-a-router)
- [Navigate Component](https://reactrouter.com/en/main/components/navigate)

✔️ **Validation:**

You should be able to:
- ✅ Protect routes from unauthorized access
- ✅ Handle login/logout
- ✅ Manage authentication state
- ✅ Redirect users appropriately
- ✅ Handle authentication errors

## Step 7 - Connect React to Your Backend API

📑 **Description:**

Connect your React applications to the backend APIs you built on Days 3 and 4. This step focuses on **integration patterns** rather than building a complete application from scratch.

📌 **What you need to do:**

### Step 7.1 - Update Your Todo App

Connect your React todo app (from Day 2) to your backend API (from Day 3):
- Replace `localStorage` with API calls
- Fetch todos from your backend on mount
- Create todos via POST request
- Update todos via PUT request
- Delete todos via DELETE request
- Handle loading and error states

### Step 7.2 - Create API Service Layer

Create a clean API service layer:
- Create `services/api.ts` file
- Create functions for each API endpoint
- Handle authentication tokens
- Centralize error handling
- Use axios or fetch consistently

Example structure:
```typescript
// services/todoApi.ts
export const getTodos = async () => { ... }
export const createTodo = async (todo) => { ... }
export const updateTodo = async (id, todo) => { ... }
export const deleteTodo = async (id) => { ... }
```

### Step 7.3 - Add Authentication to React App

Integrate authentication (from Day 3 backend):
- Create login/register pages
- Store JWT token in localStorage or context
- Add token to API requests (Authorization header)
- Handle token expiration
- Redirect to login when unauthorized

### Step 7.4 - Implement Protected Routes

Protect routes in your React app:
- Create `ProtectedRoute` component
- Wrap protected pages with authentication check
- Redirect to login if not authenticated
- Show user info in navigation

### Step 7.5 - Error Handling and Loading States

Improve user experience:
- Show loading spinners during API calls
- Display error messages for failed requests
- Handle network errors gracefully
- Provide retry mechanisms
- Show success notifications

**What to understand:**
- API integration patterns
- Authentication flow in React
- Error handling strategies
- Loading state management
- Token management

**Constraints to follow:**
- Keep API calls organized in service files
- Handle all error cases
- Provide good user feedback
- Use TypeScript for API types
- Don't build a complete new app - enhance existing ones

📚 **Documentation:**

- Review Day 3 (Backend APIs) and Day 4 (Database)
- [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)
- [Axios](https://axios-http.com/docs/intro)
- [React Authentication](https://reactrouter.com/en/main/start/tutorial#adding-a-router)

✔️ **Validation:**

You should be able to:
- ✅ Connect React to your backend API
- ✅ Handle authentication in React
- ✅ Protect routes properly
- ✅ Manage loading and error states
- ✅ Use a clean API service layer

## Step 8 - Deploy Your Application

📑 **Description:**

Learn to deploy your React application to production. Get your app online so others can use it!

📌 **What you need to do:**

### Step 8.1 - Build for Production

Build your React app:
- Run `npm run build` to create production build
- Understand the build output
- Test the production build locally

### Step 8.2 - Deploy to Vercel

Deploy to Vercel (recommended for React):
- Create Vercel account
- Connect your Git repository
- Configure build settings
- Deploy automatically on push

### Step 8.3 - Deploy to Netlify

Alternative: Deploy to Netlify:
- Create Netlify account
- Connect repository
- Configure build command and publish directory
- Deploy

### Step 8.4 - Environment Variables

Set up environment variables:
- Create `.env` file for local development
- Add environment variables in Vercel/Netlify
- Use `import.meta.env` (Vite) or `process.env` (Create React App)
- Never commit secrets to Git

### Step 8.5 - Deploy Backend

Deploy your backend (if you have one):
- Deploy to Railway, Render, or Heroku
- Set up environment variables
- Configure CORS for your frontend URL
- Test the deployed API

**What to understand:**
- Production builds
- Deployment platforms
- Environment variables
- CORS configuration
- Domain and hosting

**Constraints to follow:**
- Use environment variables for API URLs
- Never commit secrets
- Test production builds locally
- Configure CORS properly

📚 **Documentation:**

- [Vercel Deployment](https://vercel.com/docs)
- [Netlify Deployment](https://docs.netlify.com/)
- [Vite Environment Variables](https://vitejs.dev/guide/env-and-mode.html)
- [Railway](https://railway.app/) - Backend hosting

✔️ **Validation:**

You should be able to:
- ✅ Build your app for production
- ✅ Deploy to Vercel or Netlify
- ✅ Configure environment variables
- ✅ Access your app online
- ✅ Deploy backend (if applicable)

## Bonus Challenge - Advanced React Patterns

📑 **Description:**

Explore advanced React patterns and techniques that will make you a better React developer.

📌 **Choose one or more challenges:**

### Challenge 1: Custom Hooks Library

Create a library of reusable custom hooks:
- `useDebounce` - Debounce a value
- `useLocalStorage` - Sync with localStorage
- `useFetch` - Generic data fetching hook
- `useToggle` - Boolean state toggle
- `usePrevious` - Track previous value
- `useClickOutside` - Detect clicks outside element

### Challenge 2: Form Management

Build a reusable form system:
- Create a `useForm` hook with validation
- Support multiple input types
- Handle form errors
- Show validation messages
- Support async validation

### Challenge 3: Infinite Scroll

Implement infinite scroll:
- Load more data on scroll
- Show loading indicator
- Handle end of data
- Optimize performance
- Use Intersection Observer API

### Challenge 4: Optimistic Updates

Implement optimistic updates:
- Update UI immediately
- Rollback on error
- Show loading states
- Handle race conditions
- Provide good UX

**Estimated time**: 2-3 hours per challenge

📚 **Documentation:**

- [Custom Hooks](https://react.dev/learn/reusing-logic-with-custom-hooks)
- [Form Handling](https://react.dev/reference/react-dom/components/form)
- [Intersection Observer](https://developer.mozilla.org/en-US/docs/Web/API/Intersection_Observer_API)

## 📚 Additional Resources

- [React Router Documentation](https://reactrouter.com/en/main) - Complete routing guide
- [React Context API](https://react.dev/learn/passing-data-deeply-with-context) - Global state
- [React Advanced Patterns](https://kentcdodds.com/blog/react-hooks-pitfalls) - Advanced concepts
- [React Performance](https://react.dev/learn/render-and-commit) - Optimization guide
- [Full-Stack React](https://www.newline.co/fullstack-react/) - Full-stack tutorials
- [React TypeScript Cheatsheet](https://react-typescript-cheatsheet.netlify.app/) - TypeScript + React

## ✅ End of Day Checklist

- [ ] I can use React Router for navigation
- [ ] I understand dynamic routes and URL parameters
- [ ] I can use Context API for global state
- [ ] I've connected React to my backend API
- [ ] I understand useReducer, useMemo, and useCallback
- [ ] I can create protected routes
- [ ] I've integrated authentication in my React app
- [ ] I've deployed my application to production
- [ ] I understand how to structure API calls in React
- [ ] I'm ready for the rush tomorrow!

## 💡 Tips

- **Practice routing** - It's essential for real apps
- **Use Context wisely** - Don't overuse it, prefer local state when possible
- **Connect to your backend** - Full-stack is where the magic happens
- **Deploy early** - Get your app online and test it
- **Use TypeScript** - It catches errors and improves code quality
- **Organize your code** - Good structure makes maintenance easier
- **Handle errors** - Always handle API errors and edge cases
- **Test your app** - Test on different devices and browsers
- **Read error messages** - React gives helpful error messages
- **Keep learning** - React ecosystem is huge, keep exploring!

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
