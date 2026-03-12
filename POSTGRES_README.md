# PostgreSQL Database Setup

This directory contains a Docker Compose setup for a PostgreSQL database instance with sample data.

## Quick Start

### Start the Database
```bash
docker-compose up -d
```

This will:
- Start a PostgreSQL container on port 5432
- Create a database named `mattermost`

### Connect to the Database

**Connection Details:**
- Host: `localhost`
- Port: `5432`
- Database: `mattermost`
- User: `mmuser`
- Password: `mmuser`

**Using psql CLI:**
```bash
psql -h localhost -U postgres -d mattermost
```

**Connection String:**
```
postgresql://mmuser:mmuser@localhost:5432/mattermost
```

### Stop the Database
```bash
docker-compose down
```

### View Logs
```bash
docker-compose logs -f postgres
```

## Database Schema

The database includes three sample tables:

### users
- id (PRIMARY KEY)
- username (UNIQUE)
- email (UNIQUE)
- password_hash
- created_at
- updated_at

### projects
- id (PRIMARY KEY)
- user_id (FOREIGN KEY → users.id)
- name
- description
- status
- created_at
- updated_at

### tasks
- id (PRIMARY KEY)
- project_id (FOREIGN KEY → projects.id)
- title
- description
- status
- priority
- due_date
- created_at
- updated_at

## Sample Queries

```sql
-- Get all users
SELECT * FROM users;

-- Get all projects for a user
SELECT * FROM projects WHERE user_id = 1;

-- Get all tasks with their project names
SELECT t.*, p.name AS project_name 
FROM tasks t 
JOIN projects p ON t.project_id = p.id;

-- Get tasks by status
SELECT * FROM tasks WHERE status = 'pending';
```

## Resetting the Database

To reset the database and start fresh:
```bash
docker-compose down -v
docker-compose up -d
```

The `-v` flag removes the volume, so the database will be re-initialized on the next startup.

## Modifying the Schema

To modify the initial schema or sample data:
1. Edit `init.sql`
2. Run `docker-compose down -v` to remove the volume
3. Run `docker-compose up -d` to recreate with new schema

## Connecting from Applications

### Node.js
```javascript
const { Pool } = require('pg');
const pool = new Pool({
  host: 'localhost',
  port: 5432,
  database: 'dev_db',
  user: 'postgres',
  password: 'postgres',
});
```

### Python
```python
import psycopg2
conn = psycopg2.connect(
    host="localhost",
    database="dev_db",
    user="postgres",
    password="postgres"
)
```
