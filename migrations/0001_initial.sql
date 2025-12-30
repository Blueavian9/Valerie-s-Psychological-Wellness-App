CREATE TABLE IF NOT EXISTS messages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT NOT NULL DEFAULT 'Hello World from D1!'
);

INSERT OR IGNORE INTO messages (id, content) VALUES (1, 'Hello World from D1!');

