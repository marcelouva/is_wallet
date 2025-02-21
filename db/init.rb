require 'sqlite3'

db = SQLite3::Database.new 'db/development_wallet.sqlite3'
rows = db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY,
    name TEXT,
    password TEXT,
    email TEXT
  );
SQL
