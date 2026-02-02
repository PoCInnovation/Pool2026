# 🌐 Day 04 - Web Track: Databases

Welcome to Day 4 of the Software Pool 2026! 🚀

Today, you'll learn to store and manage data with databases. You'll connect your backend APIs (Day 3) to databases, making your applications persistent and production-ready. **This completes the backend stack that powers your React applications!**

## Day Purposes

✔️ Understand relational databases (SQL)

✔️ Master basic SQL queries

✔️ Use PostgreSQL or MySQL

✔️ Discover MongoDB (NoSQL)

✔️ Connect your backend API to a database

✔️ Use an ORM (Object-Relational Mapping)

✔️ **Make your APIs persistent and ready for React integration**

## Introduction

### Why Databases?

Databases are essential for storing and managing application data:
- **Persistent storage** - Data survives application restarts (unlike in-memory arrays)
- **Data integrity** - Constraints ensure data quality
- **Efficient queries** - Fast data retrieval
- **Relationships** - Model complex data relationships
- **Scalability** - Handle large amounts of data
- **Production-ready** - Your React apps need real data storage, not just localStorage

### The Full Stack Picture

By the end of today, you'll have:
- **React Frontend** (Day 2) → Makes API calls →
- **Express Backend** (Day 3) → Queries database →
- **PostgreSQL/MongoDB** (Day 4) → Returns data →
- **Back to React** → Displays data to users

This is a complete, production-ready architecture!

### SQL vs NoSQL

**SQL (Relational)**:
- Structured data with relationships
- ACID transactions
- Strong consistency
- Examples: PostgreSQL, MySQL, SQLite

**NoSQL (Document/Key-Value)**:
- Flexible schema
- Horizontal scaling
- Fast writes
- Examples: MongoDB, Redis, Cassandra

## Warm Up

Before starting, familiarize yourself with:

1. **SQL Basics**:
   - SELECT, INSERT, UPDATE, DELETE
   - WHERE clauses
   - JOINs
   - Aggregations

2. **Database Concepts**:
   - Tables, rows, columns
   - Primary keys, foreign keys
   - Indexes
   - Normalization

3. **ORM Concepts**:
   - What is an ORM?
   - Models and migrations
   - Query builders

Here are useful links:

- [PostgreSQL Tutorial](https://www.postgresqltutorial.com/)
- [MySQL Tutorial](https://www.mysqltutorial.org/)
- [MongoDB University](https://university.mongodb.com/)
- [SQLBolt](https://sqlbolt.com/) - Interactive SQL exercises

## Step 0 - Setup

📑 **Description:**

Set up your database environment.

📌 **Tasks:**

1. **Install PostgreSQL or MySQL**:
   - PostgreSQL: https://www.postgresql.org/download/
   - MySQL: https://dev.mysql.com/downloads/

2. **Install MongoDB** (optional):
   - https://www.mongodb.com/try/download/community

3. **Install database clients**:
   - pgAdmin (PostgreSQL)
   - MySQL Workbench
   - MongoDB Compass

4. **Create a test database**:
```sql
CREATE DATABASE test_db;
```

📚 **Documentation:**

- [PostgreSQL Installation](https://www.postgresql.org/docs/current/tutorial-install.html)
- [MySQL Installation](https://dev.mysql.com/doc/refman/8.0/en/installing.html)

✔️ **Validation:**

You should be able to connect to your database.

## Step 1 - Understanding SQL Databases

📑 **Description:**

Learn the fundamentals of SQL databases. Understand how relational databases work before connecting your Todo API.

📌 **What you need to do:**

### Step 1.1 - Learn SQL Basics

Practice basic SQL operations:
- **CREATE TABLE** - Create tables with columns and data types
- **INSERT** - Add data to tables
- **SELECT** - Query data from tables
- **UPDATE** - Modify existing data
- **DELETE** - Remove data from tables
- **WHERE** - Filter data with conditions

### Step 1.2 - Understand Database Concepts

Learn key concepts:
- **Tables, Rows, Columns** - Basic structure
- **Primary Keys** - Unique identifiers
- **Foreign Keys** - Relationships between tables
- **Indexes** - Speed up queries
- **Data Types** - INTEGER, VARCHAR, BOOLEAN, TIMESTAMP, etc.

### Step 1.3 - Practice with Simple Queries

Create a simple example database:
- Create a `users` table (id, name, email, created_at)
- Insert sample data
- Write SELECT queries with WHERE clauses
- Practice UPDATE and DELETE operations

### Step 1.4 - Learn Relationships

Understand table relationships:
- **One-to-Many** - One user has many tasks
- **Many-to-Many** - Users and roles (requires junction table)
- **Foreign Keys** - Link tables together
- **JOINs** - Combine data from multiple tables

**What to understand:**
- How relational databases organize data
- SQL syntax and commands
- Table relationships and foreign keys
- Basic query patterns

📚 **Documentation:**

- [SQLBolt](https://sqlbolt.com/) - Interactive SQL tutorial
- [PostgreSQL Tutorial](https://www.postgresqltutorial.com/)
- [W3Schools SQL](https://www.w3schools.com/sql/)

✔️ **Validation:**

You should be able to:
- ✅ Create tables with SQL
- ✅ Insert, select, update, and delete data
- ✅ Use WHERE clauses to filter data
- ✅ Understand primary and foreign keys
- ✅ Write basic JOIN queries

## Step 2 - Connect Your Todo API to PostgreSQL

📑 **Description:**

Connect your Todo API from Day 3 to a PostgreSQL database. Learn to use an ORM (Prisma) or raw SQL queries.

📌 **What you need to do:**

### Step 2.1 - Set up Database Connection

Choose your approach:
- **Option A**: Use Prisma (recommended, easier, type-safe)
- **Option B**: Use `node-postgres` directly (more control, learn SQL)

### Step 2.2 - Design Your Database Schema

Design the database schema for your Todo API:
- **users** table: id, email, password_hash, name, created_at
- **tasks** table: id, user_id (foreign key), title, completed, created_at, updated_at

Understand:
- Primary keys
- Foreign keys (user_id references users.id)
- Data types (INTEGER, VARCHAR, BOOLEAN, TIMESTAMP)
- Constraints (NOT NULL, UNIQUE)

### Step 2.3 - Create Tables

Create tables using:
- **With Prisma**: Define schema in `schema.prisma`, run migrations
- **With raw SQL**: Write CREATE TABLE statements

### Step 2.4 - Update Your API Endpoints

Replace in-memory storage with database queries:
- `GET /api/tasks` → SELECT from database
- `POST /api/tasks` → INSERT into database
- `PUT /api/tasks/:id` → UPDATE in database
- `DELETE /api/tasks/:id` → DELETE from database

### Step 2.5 - Handle Database Operations

Learn to:
- Connect to database
- Execute queries
- Handle errors (connection errors, query errors)
- Use connection pooling
- Handle transactions

**What to understand:**
- Database connections
- SQL queries or ORM queries
- Error handling
- Connection pooling
- Transactions

**Constraints to follow:**
- Use environment variables for connection string
- Handle all database errors
- Keep API endpoints the same (for React compatibility)
- Filter tasks by user_id (users see only their tasks)

📚 **Documentation:**

- [Prisma Getting Started](https://www.prisma.io/docs/getting-started)
- [node-postgres](https://node-postgres.com/)
- [Prisma Schema](https://www.prisma.io/docs/concepts/components/prisma-schema)

✔️ **Validation:**

Your API should:
- ✅ Connect to PostgreSQL database
- ✅ Persist data in database
- ✅ Handle database errors gracefully
- ✅ Work with your React app
- ✅ Filter tasks by authenticated user

## Step 3 - Advanced SQL Queries and Relationships

📑 **Description:**

Learn advanced SQL concepts: JOINs, aggregations, and complex queries. Apply these to your Todo API.

📌 **What you need to do:**

### Step 3.1 - Learn JOINs

Understand different JOIN types:
- **INNER JOIN** - Only matching rows
- **LEFT JOIN** - All rows from left table
- **RIGHT JOIN** - All rows from right table
- **FULL OUTER JOIN** - All rows from both tables

Practice with your Todo database:
- JOIN tasks with users
- Get user info with each task
- Understand when to use each JOIN type

### Step 3.2 - Aggregations

Learn aggregation functions:
- **COUNT** - Count rows
- **SUM** - Sum values
- **AVG** - Average values
- **MAX/MIN** - Maximum/minimum values
- **GROUP BY** - Group results

Apply to your Todo API:
- Count total tasks per user
- Count completed vs pending tasks
- Calculate completion percentage

### Step 3.3 - Complex Queries

Write complex queries:
- Subqueries
- Multiple WHERE conditions (AND, OR)
- ORDER BY multiple columns
- LIMIT and OFFSET for pagination

### Step 3.4 - Indexes

Understand indexes:
- What are indexes?
- When to use indexes
- Create indexes on frequently queried columns
- Indexes on foreign keys

**What to understand:**
- How JOINs work
- Aggregation functions
- Complex query patterns
- Index optimization

📚 **Documentation:**

- [SQL JOINs](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-joins/)
- [SQL Aggregations](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-aggregate-functions/)
- [SQL Indexes](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-indexes/)

✔️ **Validation:**

You should be able to:
- ✅ Write JOIN queries
- ✅ Use aggregation functions
- ✅ Write complex queries with multiple conditions
- ✅ Understand indexes and their purpose

## Step 4 - Discovering NoSQL and MongoDB

📑 **Description:**

Discover NoSQL databases and MongoDB. Understand when to use SQL vs NoSQL, and learn MongoDB basics.

📌 **What you need to do:**

### Step 4.1 - Understand NoSQL Concepts

Learn about NoSQL databases:
- **What is NoSQL?** - Non-relational databases
- **Document databases** - Store data as documents (JSON-like)
- **Key differences from SQL**:
  - No fixed schema
  - No JOINs (embedded documents instead)
  - Horizontal scaling
  - Flexible data structure

### Step 4.2 - SQL vs NoSQL: When to Use What?

Understand use cases:
- **SQL (PostgreSQL)** - Structured data, relationships, transactions, consistency
- **NoSQL (MongoDB)** - Flexible schema, rapid development, large scale, document storage

### Step 4.3 - MongoDB Basics

Learn MongoDB concepts:
- **Collections** - Like tables in SQL
- **Documents** - Like rows in SQL (but JSON-like)
- **Fields** - Like columns
- **Embedded documents** - Store related data together
- **References** - Link documents (like foreign keys)

### Step 4.4 - Practice MongoDB Queries

Install MongoDB and practice:
- Create a database
- Create collections
- Insert documents
- Query documents (find, filter)
- Update documents
- Delete documents

### Step 4.5 - Mongoose ODM

Learn Mongoose (Object Document Mapper):
- Install Mongoose
- Define schemas
- Create models
- Perform CRUD operations
- Understand the difference between ODM (Mongoose) and ORM (Prisma)

**What to understand:**
- NoSQL vs SQL differences
- MongoDB document structure
- MongoDB query syntax
- Mongoose ODM
- When to choose SQL vs NoSQL

📚 **Documentation:**

- [MongoDB University](https://university.mongodb.com/) - Free courses
- [MongoDB Manual](https://docs.mongodb.com/manual/)
- [Mongoose Guide](https://mongoosejs.com/docs/guide.html)

✔️ **Validation:**

You should be able to:
- ✅ Understand differences between SQL and NoSQL
- ✅ Create MongoDB databases and collections
- ✅ Insert and query documents
- ✅ Use Mongoose for MongoDB operations
- ✅ Decide when to use SQL vs NoSQL

## Step 5 - Migrate Your Todo API Authentication to Database

📑 **Description:**

Upgrade your authentication system from Day 3 to use a database. Store users in PostgreSQL instead of memory.

📌 **What you need to do:**

### Step 5.1 - Create Users Table

Create a `users` table in PostgreSQL:
- `id` (primary key, auto-increment)
- `email` (unique, required, indexed)
- `password_hash` (required)
- `name` (optional)
- `created_at` (timestamp)
- `updated_at` (timestamp)

### Step 5.2 - Update Registration Endpoint

Modify `POST /api/auth/register`:
- Check if email already exists (database query)
- Hash password with bcrypt
- Insert user into database
- Return user data (without password)

### Step 5.3 - Update Login Endpoint

Modify `POST /api/auth/login`:
- Find user by email in database
- Compare password with bcrypt
- Generate JWT token
- Return token and user data

### Step 5.4 - Update User Profile Endpoint

Modify `GET /api/auth/me`:
- Query user from database using user ID from JWT
- Return user data

**What to understand:**
- Database user management
- Password hashing and verification
- Querying users from database
- Handling database errors (user not found, duplicate email)

**Constraints to follow:**
- Never return password hashes
- Always hash passwords before storing
- Validate email uniqueness at database level
- Handle all database errors gracefully

📚 **Documentation:**

- [Prisma User Model](https://www.prisma.io/docs/concepts/components/prisma-schema/models)
- [Password Hashing](https://www.npmjs.com/package/bcrypt)
- [Database Constraints](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-check-constraint/)

✔️ **Validation:**

Your authentication should:
- ✅ Store users in PostgreSQL database
- ✅ Handle duplicate emails
- ✅ Hash passwords properly
- ✅ Query users from database
- ✅ Handle all error cases

## Step 6 - Database Migrations and Schema Management

📑 **Description:**

Learn to manage database schema changes with migrations. This is essential for production applications.

📌 **What you need to do:**

### Step 6.1 - Understand Migrations

Learn about migrations:
- **What are migrations?** - Version control for database schema
- **Why use migrations?** - Track schema changes, rollback changes, team collaboration
- **Migration files** - SQL scripts that modify schema

### Step 6.2 - Create Initial Migration

Create your first migration:
- **With Prisma**: `npx prisma migrate dev --name init`
- **With raw SQL**: Create migration files manually
- Create initial schema (users and tasks tables)

### Step 6.3 - Add a New Migration

Add a feature (e.g., task categories):
- Create new migration
- Add `category` column to tasks table
- Run migration
- Understand how migrations work

### Step 6.4 - Seed Data

Create seed scripts:
- Insert test data
- Create sample users and tasks
- Use seed scripts for development

### Step 6.5 - Rollback Migrations

Learn to rollback:
- Undo last migration
- Understand when rollbacks are needed
- Practice rollback operations

**What to understand:**
- Migration concepts
- How to create and run migrations
- Schema versioning
- Seed data management
- Rollback strategies

📚 **Documentation:**

- [Prisma Migrate](https://www.prisma.io/docs/concepts/components/prisma-migrate)
- [Database Migrations Best Practices](https://www.prisma.io/docs/guides/migrate)

✔️ **Validation:**

You should be able to:
- ✅ Create and run migrations
- ✅ Understand migration files
- ✅ Create seed scripts
- ✅ Rollback migrations if needed

## Step 7 - Database Performance and Optimization

📑 **Description:**

Learn to optimize database queries and improve performance. Essential for production applications.

📌 **What you need to do:**

### Step 7.1 - Query Optimization

Optimize your Todo API queries:
- Use SELECT only needed columns (not SELECT *)
- Add WHERE clauses to filter early
- Use LIMIT for pagination
- Avoid N+1 queries (fetch related data efficiently)

### Step 7.2 - Indexes

Add indexes to improve performance:
- Index on `user_id` (frequently queried)
- Index on `completed` (for filtering)
- Index on `created_at` (for sorting)
- Understand when indexes help vs hurt

### Step 7.3 - Connection Pooling

Set up connection pooling:
- Understand connection pooling
- Configure pool size
- Reuse connections efficiently
- Handle connection errors

### Step 7.4 - Query Analysis

Analyze query performance:
- Use EXPLAIN ANALYZE (PostgreSQL)
- Identify slow queries
- Optimize slow queries
- Monitor query performance

### Step 7.5 - Best Practices

Learn database best practices:
- Normalize data appropriately
- Use transactions for critical operations
- Handle errors properly
- Monitor database health

**What to understand:**
- Query optimization techniques
- Index usage and impact
- Connection pooling
- Performance monitoring
- Database best practices

📚 **Documentation:**

- [PostgreSQL Performance](https://www.postgresql.org/docs/current/performance-tips.html)
- [Query Optimization](https://use-the-index-luke.com/)
- [Connection Pooling](https://node-postgres.com/features/pooling)

✔️ **Validation:**

You should:
- ✅ Have optimized queries
- ✅ Added appropriate indexes
- ✅ Set up connection pooling
- ✅ Understand performance implications

## Step 8 - Comparing SQL and NoSQL: Todo API in Both

📑 **Description:**

Implement your Todo API with both PostgreSQL (SQL) and MongoDB (NoSQL) to understand the differences practically.

📌 **What you need to do:**

### Step 8.1 - Current Implementation (SQL)

Your current Todo API uses PostgreSQL:
- Structured schema (users table, tasks table)
- Foreign keys (tasks.user_id → users.id)
- JOINs to get user info with tasks
- Transactions for data integrity

### Step 8.2 - MongoDB Implementation

Create a MongoDB version:
- **Users collection** - Store user documents
- **Tasks collection** - Store task documents
- **Embedded vs Referenced** - Decide when to embed user info vs reference user_id
- Use Mongoose for ODM

### Step 8.3 - Compare Approaches

Compare both implementations:
- **Schema flexibility** - MongoDB allows flexible schema
- **Queries** - SQL JOINs vs MongoDB lookups
- **Relationships** - Foreign keys vs references
- **Performance** - When each performs better

### Step 8.4 - Choose the Right Database

Understand when to use each:
- **Use SQL (PostgreSQL)** when:
  - You need relationships and JOINs
  - Data integrity is critical
  - You need transactions
  - Schema is well-defined

- **Use NoSQL (MongoDB)** when:
  - Schema is flexible or unknown
  - Rapid development needed
  - Horizontal scaling required
  - Document-based data fits better

**What to understand:**
- Practical differences between SQL and NoSQL
- When to choose each database type
- Trade-offs between approaches
- Real-world decision making

📚 **Documentation:**

- [SQL vs NoSQL](https://www.mongodb.com/nosql-explained)
- [When to Use MongoDB](https://www.mongodb.com/use-cases)
- [PostgreSQL Use Cases](https://www.postgresql.org/about/)

✔️ **Validation:**

You should:
- ✅ Understand SQL and NoSQL differences
- ✅ Have implemented Todo API in both
- ✅ Know when to use each database type
- ✅ Understand trade-offs

## Bonus Challenge - Advanced Database Concepts

📑 **Description:**

Explore advanced database concepts to deepen your understanding.

📌 **Choose one or more challenges:**

### Challenge 1: Full-Text Search

Implement full-text search in your Todo API:
- Search tasks by title (PostgreSQL full-text search or MongoDB text index)
- Rank results by relevance
- Handle search queries efficiently

### Challenge 2: Database Transactions

Learn transactions:
- Use transactions for multi-step operations
- Understand ACID properties
- Handle transaction rollbacks
- Example: Create user and default tasks atomically

### Challenge 3: Database Views

Create database views:
- Create a view for user statistics
- Create a view for task summaries
- Understand when views are useful

### Challenge 4: Database Backup and Restore

Learn backup strategies:
- Export database to SQL file
- Import database from backup
- Understand backup best practices

**Estimated time**: 2-3 hours per challenge

## 📚 Additional Resources

- [Database Design](https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/)
- [SQL Performance](https://use-the-index-luke.com/)
- [MongoDB Best Practices](https://www.mongodb.com/docs/manual/administration/production-notes/)

## ✅ End of Day Checklist

- [ ] I understand SQL databases and basic queries
- [ ] I've connected my Todo API to PostgreSQL
- [ ] I understand JOINs and aggregations
- [ ] I've learned about NoSQL and MongoDB
- [ ] I understand when to use SQL vs NoSQL
- [ ] I've implemented migrations for schema management
- [ ] I've optimized database queries and added indexes
- [ ] I've compared SQL and NoSQL implementations
- [ ] My Todo API persists data in a database
- [ ] I understand database best practices

## 💡 Tips

- Use migrations to manage schema changes
- Think about indexing for performance
- Always validate data before insertion
- Use transactions for critical operations
- Watch out for SQL injection (use parameterized queries)
- Normalize your database design
- Use connection pooling for production

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
