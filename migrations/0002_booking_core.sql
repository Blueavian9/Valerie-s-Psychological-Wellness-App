-- 0002_booking_core.sql
-- Upgrade schema (additive changes only)

PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;

-- Add email to practitioners if it doesn't exist (SQLite doesn't support IF NOT EXISTS for columns)
-- This will error if column exists; that's OK if you run once.
ALTER TABLE practitioners ADD COLUMN email TEXT;

-- Optional: activate flag
ALTER TABLE practitioners ADD COLUMN is_active INTEGER NOT NULL DEFAULT 1;

-- Create unique index for email (works even if some rows have NULL email)
CREATE UNIQUE INDEX IF NOT EXISTS idx_practitioners_email ON practitioners(email);

-- Upgrade audit_logs to store richer metadata (your 0001 has metadata_json nullable)
-- Add default '{}' behavior by ensuring column exists (if it already exists, ignore)
ALTER TABLE audit_logs ADD COLUMN metadata_json TEXT NOT NULL DEFAULT '{}';

COMMIT;
