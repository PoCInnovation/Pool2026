# 🌐 Day 03 - Web Track: Backend & API

Welcome to Day 3 of the Software Pool 2026! 🚀

Today, you're moving to the server side! You'll learn to create APIs and backend servers with Node.js and Express. **These APIs will power your React applications** that you built on Day 2, creating a complete full-stack experience.

## Day Purposes

✔️ Understand how a web server works

✔️ Create a server with Node.js and Express

✔️ Create routes and API endpoints

✔️ Handle HTTP requests (GET, POST, PUT, DELETE)

✔️ Use middlewares

✔️ Handle basic authentication

✔️ **Connect your backend to your React frontend**

## Introduction

### Why Backend Development?

Backend development is the foundation of web applications. It handles:
- **Business logic** - The core functionality of your application
- **Data processing** - Manipulating and transforming data
- **API creation** - Exposing data and functionality to frontends (like your React apps!)
- **Security** - Authentication, authorization, and data validation
- **Performance** - Optimizing database queries and caching

### Why Node.js and Express?

- **Node.js** - JavaScript runtime that lets you run JavaScript on the server
- **Express** - Fast, unopinionated web framework for Node.js
- **Same language** - Use JavaScript/TypeScript for both frontend (React) and backend
- **Rich ecosystem** - Millions of packages via npm
- **Fast development** - Quick to prototype and build
- **Perfect for React** - Create REST APIs that your React applications can consume

### Connecting Frontend and Backend

Today you'll build APIs that your React applications (from Day 2) can connect to. This creates a complete full-stack application:
- **React Frontend** (Day 2) → Makes HTTP requests → **Express Backend** (Day 3) → Returns JSON data

## Warm Up

Before starting, familiarize yourself with:

1. **Node.js Basics**:
   - Modules (CommonJS and ES6)
   - `require` and `module.exports`
   - File system operations

2. **HTTP Basics**:
   - HTTP methods (GET, POST, PUT, DELETE)
   - Status codes (200, 404, 500, etc.)
   - Request/Response cycle

3. **REST API Concepts**:
   - What is REST?
   - Resource-based URLs
   - JSON as data format

Here are useful links:

- [Node.js Documentation](https://nodejs.org/docs/latest/api/)
- [Express.js Guide](https://expressjs.com/en/guide/routing.html)
- [REST API Tutorial](https://restfulapi.net/)
- [HTTP Status Codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)

## Step 0 - Setup

📑 **Description:**

Set up your Node.js development environment.

📌 **Tasks:**

1. Create a folder for Day 3:
```bash
mkdir -p day3
cd day3
mkdir backend
cd backend
npm init -y
```

2. Install Express:
```bash
npm install express
npm install --save-dev nodemon
```

3. Create `server.js`:
```javascript
const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
```

4. Add to `package.json`:
```json
"scripts": {
  "start": "node server.js",
  "dev": "nodemon server.js"
}
```

📚 **Documentation:**

- [Express Getting Started](https://expressjs.com/en/starter/installing.html)

✔️ **Validation:**

Run `npm run dev` and visit `http://localhost:3000`. You should see "Hello World!".

## Step 1 - Basic Express Server and Middleware

📑 **Description:**

Create a basic Express server and understand how middlewares work. Middlewares are the foundation of Express applications.

📌 **What you need to do:**

### Step 1.1 - Create Basic Server

Create an Express server that:
- Listens on port 3000
- Has a `GET /` route that returns "Hello World"
- Uses `express.json()` middleware to parse JSON bodies
- Uses `express.urlencoded()` middleware to parse URL-encoded bodies

### Step 1.2 - Understand Middleware

Learn about middleware:
- Middlewares are functions that run between request and response
- They can modify `req` and `res` objects
- They can end the request-response cycle or call `next()`
- Order matters - middlewares execute in order

### Step 1.3 - Create Custom Middleware

Create a logging middleware:
- Log all incoming requests (method, URL, timestamp)
- Use `morgan` package for production-ready logging
- Understand how `next()` works

### Step 1.4 - Error Handling Middleware

Create error handling middleware:
- Handle 404 errors (route not found)
- Handle 500 errors (server errors)
- Return proper error responses in JSON format

**What to understand:**
- How Express middleware works
- The request-response cycle
- How to create custom middlewares
- Error handling patterns

📚 **Documentation:**

- [Express Routing](https://expressjs.com/en/guide/routing.html)
- [Express Middleware](https://expressjs.com/en/guide/using-middleware.html)
- [morgan](https://www.npmjs.com/package/morgan)

✔️ **Validation:**

Your server should:
- ✅ Start successfully
- ✅ Handle basic routes
- ✅ Log requests
- ✅ Handle errors properly

## Step 2 - Todo API: Basic CRUD Operations

📑 **Description:**

Create the foundation of your Todo API with basic CRUD operations. **This API will power your React todo application from Day 2!**

📌 **What you need to do:**

### Step 2.1 - Set up CORS

Install and configure CORS so your React app can access the API:
```bash
npm install cors
```

```javascript
const cors = require('cors');
app.use(cors()); // Enable CORS for all routes
```

### Step 2.2 - Create Basic CRUD Endpoints

Create a REST API for managing tasks:
- `GET /api/tasks` - List all tasks
- `GET /api/tasks/:id` - Get a task by ID
- `POST /api/tasks` - Create a new task
- `PUT /api/tasks/:id` - Update a task
- `DELETE /api/tasks/:id` - Delete a task

**Task structure**:
```json
{
  "id": 1,
  "title": "Buy groceries",
  "completed": false,
  "createdAt": "2024-01-15T10:30:00Z",
  "updatedAt": "2024-01-15T10:30:00Z"
}
```

**Constraints**:
- Store tasks in memory (array) for now (we'll add a database tomorrow)
- Return appropriate HTTP codes (200, 201, 404, 400, etc.)
- Return JSON responses

**What to understand:**
- REST API conventions
- HTTP methods and status codes
- Request/response handling
- Route parameters (`:id`)

📚 **Documentation:**

- [Express Request](https://expressjs.com/en/api.html#req)
- [Express Response](https://expressjs.com/en/api.html#res)
- [CORS](https://expressjs.com/en/resources/middleware/cors.html)

✔️ **Validation:**

Your API should:
- ✅ Handle all CRUD operations correctly
- ✅ Return proper JSON responses
- ✅ Have CORS enabled
- ✅ Use appropriate HTTP status codes

## Step 3 - Todo API: Input Validation and Error Handling

📑 **Description:**

Add proper validation and error handling to your Todo API. This is crucial for production-ready APIs.

📌 **What you need to do:**

### Step 3.1 - Input Validation

Validate all inputs:
- **POST /api/tasks**: Require `title` (string, not empty, max 200 characters)
- **PUT /api/tasks/:id**: Validate `title` and `completed` (boolean)
- Return 400 Bad Request with error messages for invalid data

### Step 3.2 - Error Handling

Handle all error cases:
- Task not found (404)
- Invalid task ID format (400)
- Missing required fields (400)
- Invalid data types (400)
- Server errors (500)

### Step 3.3 - Create Validation Middleware

Create reusable validation middleware:
- Validate request body structure
- Check data types
- Return clear error messages
- Use this middleware on POST and PUT routes

### Step 3.4 - Error Response Format

Standardize error responses:
```json
{
  "error": "Task not found",
  "statusCode": 404
}
```

**What to understand:**
- Input validation patterns
- Error handling best practices
- HTTP status codes
- Middleware for validation
- User-friendly error messages

📚 **Documentation:**

- [Express Error Handling](https://expressjs.com/en/guide/error-handling.html)
- [HTTP Status Codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)

✔️ **Validation:**

Your API should:
- ✅ Validate all inputs
- ✅ Return clear error messages
- ✅ Handle all error cases
- ✅ Use appropriate HTTP status codes

## Step 4 - Todo API: Query Parameters and Filtering

📑 **Description:**

Add advanced features to your Todo API: query parameters, filtering, sorting, and pagination.

📌 **What you need to do:**

### Step 4.1 - Query Parameters

Add query parameters to `GET /api/tasks`:
- `?completed=true` - Filter by completion status
- `?sortBy=createdAt` - Sort by field (createdAt, title)
- `?order=asc` or `?order=desc` - Sort order
- `?limit=10` - Limit number of results
- `?offset=0` - Pagination offset

### Step 4.2 - Search Functionality

Add search endpoint:
- `GET /api/tasks/search?q=groceries` - Search tasks by title
- Case-insensitive search
- Return matching tasks

### Step 4.3 - Statistics Endpoint

Add statistics endpoint:
- `GET /api/tasks/stats` - Get statistics
- Return: total tasks, completed tasks, pending tasks, completion percentage

### Step 4.4 - Combine Filters

Allow combining multiple filters:
- `GET /api/tasks?completed=false&sortBy=createdAt&order=desc&limit=5`

**What to understand:**
- Query parameters (`req.query`)
- Filtering and sorting logic
- Pagination patterns
- Search implementation

📚 **Documentation:**

- [Query Parameters](https://expressjs.com/en/api.html#req.query)
- [REST API Best Practices](https://restfulapi.net/)

✔️ **Validation:**

Your API should:
- ✅ Filter tasks by completion status
- ✅ Sort tasks by different fields
- ✅ Support pagination
- ✅ Search tasks by title
- ✅ Return statistics

## Step 5 - Todo API: Authentication and Authorization

📑 **Description:**

Add authentication to your Todo API so users can have their own tasks. **This will be used to protect your React app routes and API endpoints.**

📌 **What you need to do:**

### Step 5.1 - User Registration and Login

Create authentication endpoints:
- `POST /api/auth/register` - User registration
  - Require: email, password, name (optional)
  - Validate email format and password strength
  - Hash password with `bcrypt`
  - Store users in memory (we'll add database tomorrow)

- `POST /api/auth/login` - User login
  - Require: email, password
  - Verify password
  - Generate JWT token
  - Return token and user data

**Response format for login**:
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "email": "user@example.com",
    "name": "John Doe"
  }
}
```

### Step 5.2 - JWT Authentication Middleware

Create authentication middleware:
- Extract token from `Authorization` header (Bearer token)
- Verify JWT token
- Add user info to `req.user`
- Return 401 if token is missing or invalid

### Step 5.3 - Protect Todo Routes

Protect your Todo API routes:
- All Todo endpoints require authentication
- Users can only access their own tasks
- Add `userId` to tasks
- Filter tasks by `userId` in all queries

### Step 5.4 - User Profile Endpoint

Create user profile endpoint:
- `GET /api/auth/me` - Get current user profile (protected)
- Use authentication middleware
- Return user data from token

**What to understand:**
- JWT tokens and how they work
- Password hashing with bcrypt
- Authentication middleware pattern
- Authorization (users can only access their own data)
- Token-based authentication flow

**Constraints to follow:**
- Use `jsonwebtoken` for JWT
- Use `bcrypt` for password hashing
- Never return passwords in responses
- Validate all inputs
- Handle authentication errors properly

📚 **Documentation:**

- [JWT.io](https://jwt.io/)
- [jsonwebtoken](https://www.npmjs.com/package/jsonwebtoken)
- [bcrypt](https://www.npmjs.com/package/bcrypt)
- [JWT Authentication](https://www.npmjs.com/package/jsonwebtoken)

✔️ **Validation:**

Your authentication system should:
- ✅ Securely handle user registration and login
- ✅ Return JWT tokens
- ✅ Protect Todo routes with authentication middleware
- ✅ Users can only access their own tasks
- ✅ Hash passwords properly
- ✅ Handle authentication errors

## Step 6 - Todo API: Code Organization and Best Practices

📑 **Description:**

Organize your Todo API code properly. Good code organization is essential for maintainability and scalability.

📌 **What you need to do:**

### Step 6.1 - Project Structure

Organize your code into a proper structure:
```
backend/
├── src/
│   ├── routes/
│   │   ├── tasks.js
│   │   └── auth.js
│   ├── middleware/
│   │   ├── auth.js
│   │   ├── validation.js
│   │   └── errorHandler.js
│   ├── controllers/
│   │   ├── taskController.js
│   │   └── authController.js
│   ├── utils/
│   │   └── helpers.js
│   └── server.js
├── .env
└── package.json
```

### Step 6.2 - Separate Routes

Move routes to separate files:
- `routes/tasks.js` - All task-related routes
- `routes/auth.js` - All authentication routes
- Use `express.Router()` for route organization

### Step 6.3 - Controllers Pattern

Create controllers to separate logic:
- `controllers/taskController.js` - Task business logic
- `controllers/authController.js` - Authentication logic
- Keep routes thin, move logic to controllers

### Step 6.4 - Environment Variables

Use environment variables:
- Install `dotenv`
- Store: PORT, JWT_SECRET, NODE_ENV
- Never commit `.env` file
- Use `process.env` to access variables

### Step 6.5 - Error Handling Middleware

Create centralized error handling:
- Global error handler middleware
- Consistent error response format
- Log errors properly
- Handle different error types

**What to understand:**
- MVC-like architecture (Model-View-Controller)
- Separation of concerns
- Environment variables
- Error handling patterns
- Code organization best practices

📚 **Documentation:**

- [Express Router](https://expressjs.com/en/guide/routing.html)
- [dotenv](https://www.npmjs.com/package/dotenv)
- [Express Error Handling](https://expressjs.com/en/guide/error-handling.html)
- [Node.js Best Practices](https://github.com/goldbergyoni/nodebestpractices)

✔️ **Validation:**

Your code should:
- ✅ Be well-organized into folders
- ✅ Use environment variables
- ✅ Have separated routes and controllers
- ✅ Have centralized error handling
- ✅ Be easy to maintain and extend

## Step 7 - Todo API: Testing and Documentation

📑 **Description:**

Learn to test your API and document it properly. Testing ensures your API works correctly, and documentation helps others (and yourself) understand how to use it.

📌 **What you need to do:**

### Step 7.1 - Test Your API

Test all endpoints:
- Use **Postman** or **Thunder Client** (VS Code extension)
- Test all CRUD operations
- Test authentication endpoints
- Test error cases (invalid data, missing auth, etc.)
- Test query parameters and filters

### Step 7.2 - Create API Documentation

Document your API:
- List all endpoints
- Document request/response formats
- Document authentication requirements
- Document error responses
- Include examples

### Step 7.3 - Add Request Logging

Add request logging:
- Use `morgan` middleware
- Log: method, URL, status, response time
- Different log formats for dev vs production

### Step 7.4 - Health Check Endpoint

Create a health check endpoint:
- `GET /api/health` - Check if API is running
- Return server status, uptime, etc.

**What to understand:**
- API testing strategies
- Documentation importance
- Logging and monitoring
- Health checks
- Full-stack integration

📚 **Documentation:**

- [Postman](https://www.postman.com/)
- [morgan](https://www.npmjs.com/package/morgan)
- [API Documentation Best Practices](https://swagger.io/resources/articles/adopting-an-api-first-approach/)

✔️ **Validation:**

You should:
- ✅ Have tested all API endpoints
- ✅ Have documented your API
- ✅ Have request logging enabled
- ✅ Have connected your React app to the API
- ✅ Understand how frontend and backend work together

## Step 8 - Todo API: Advanced Features and Optimization

📑 **Description:**

Add advanced features and optimize your Todo API. Make it production-ready!

📌 **What you need to do:**

### Step 8.1 - Rate Limiting

Add rate limiting:
- Install `express-rate-limit`
- Limit API requests per IP
- Prevent abuse and DDoS attacks
- Return 429 Too Many Requests when limit exceeded

### Step 8.2 - Request Validation Library

Use a validation library:
- Install `joi` or `express-validator`
- Create validation schemas
- Validate requests automatically
- Return clear validation errors

### Step 8.3 - Data Sanitization

Sanitize user inputs:
- Remove dangerous characters
- Prevent XSS attacks
- Sanitize HTML if needed
- Use `helmet` for security headers

### Step 8.4 - Caching (Optional)

Add caching for frequently accessed data:
- Cache task lists
- Use in-memory cache (simple)
- Set cache expiration
- Clear cache on updates

### Step 8.5 - API Versioning

Prepare for API versioning:
- Use `/api/v1/tasks` instead of `/api/tasks`
- Plan for future API changes
- Maintain backward compatibility

**What to understand:**
- Security best practices
- Rate limiting
- Input sanitization
- Caching strategies
- API versioning

📚 **Documentation:**

- [express-rate-limit](https://www.npmjs.com/package/express-rate-limit)
- [joi](https://joi.dev/) or [express-validator](https://express-validator.github.io/docs/)
- [helmet](https://helmetjs.github.io/)
- [Express Security Best Practices](https://expressjs.com/en/advanced/best-practice-security.html)

✔️ **Validation:**

Your API should:
- ✅ Have rate limiting enabled
- ✅ Validate and sanitize all inputs
- ✅ Have security headers
- ✅ Be production-ready
- ✅ Be well-documented and tested

## Bonus Challenge - Enhance Your Todo API

📑 **Description:**

Add bonus features to make your Todo API even better!

📌 **Choose one or more enhancements:**

### Challenge 1: Task Categories/Tags

Add categories or tags to tasks:
- `POST /api/tasks` - Include category/tags
- `GET /api/tasks?category=work` - Filter by category
- `GET /api/categories` - List all categories

### Challenge 2: Task Priorities

Add priority levels to tasks:
- Priority: low, medium, high, urgent
- `GET /api/tasks?priority=high` - Filter by priority
- Sort by priority

### Challenge 3: Task Due Dates

Add due dates to tasks:
- `POST /api/tasks` - Include dueDate
- `GET /api/tasks?overdue=true` - Get overdue tasks
- Sort by due date

### Challenge 4: Task Sharing

Allow sharing tasks between users:
- `POST /api/tasks/:id/share` - Share task with another user
- `GET /api/tasks/shared` - Get shared tasks
- Permission management

**Estimated time**: 2-3 hours per challenge

📚 **Documentation:**

- Review Express documentation
- Think about data structures
- Plan API endpoints carefully

## 📚 Additional Resources

- [Node.js Best Practices](https://github.com/goldbergyoni/nodebestpractices)
- [Express Security Best Practices](https://expressjs.com/en/advanced/best-practice-security.html)
- [REST API Design](https://restfulapi.net/)

## ✅ End of Day Checklist

- [ ] I've created a complete Todo API with all CRUD operations
- [ ] I understand how Express middleware works
- [ ] I've implemented input validation and error handling
- [ ] I've added query parameters, filtering, and pagination
- [ ] I've implemented authentication with JWT
- [ ] I've organized my code properly (routes, controllers, middleware)
- [ ] I've used environment variables
- [ ] I've tested my API with Postman or similar tools
- [ ] I've connected my React todo app to the backend API
- [ ] I understand the full-stack architecture (React → Express → Data)

## 💡 Tips

- Use `nodemon` for development (automatic restart)
- Test your APIs with Postman or `curl`
- Organize your code into separate route files
- Use environment variables for configuration
- Useful logs for debugging (`morgan` middleware)
- Always validate and sanitize user input

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
