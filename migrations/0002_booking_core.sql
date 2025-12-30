-- 0002_booking_core.sql
-- Incremental updates after 0001_initial.sql
PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;

-- 1) Add practitioner email (cannot add NOT NULL safely in SQLite if table already has rows)
ALTER TABLE practitioners ADD COLUMN email TEXT;

-- Unique index for email (allows NULLs)
CREATE UNIQUE INDEX IF NOT EXISTS idx_practitioners_email
  ON practitioners(email)
  WHERE email IS NOT NULL;

-- 2) Add practitioner is_active flag
ALTER TABLE practitioners ADD COLUMN is_active INTEGER NOT NULL DEFAULT 1;

-- 3) Optional: add helpful indexes (safe)
CREATE INDEX IF NOT EXISTS idx_bookings_status
  ON bookings(status);

CREATE INDEX IF NOT EXISTS idx_availability_day
  ON availability_rules(day_of_week);

COMMIT;
