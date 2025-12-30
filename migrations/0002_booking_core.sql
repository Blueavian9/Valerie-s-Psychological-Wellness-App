-- Migration: Booking core tables
-- Created: 2025-12-30

PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;

-- Practitioners (therapists/admin users)
CREATE TABLE IF NOT EXISTS practitioners (
  id TEXT PRIMARY KEY,                    -- uuid
  email TEXT NOT NULL UNIQUE,
  display_name TEXT NOT NULL,
  timezone TEXT NOT NULL DEFAULT 'America/Los_Angeles',
  is_active INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ','now')),
  updated_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ','now'))
);

CREATE INDEX IF NOT EXISTS idx_practitioners_email ON practitioners(email);

-- Service types (session offerings)
CREATE TABLE IF NOT EXISTS service_types (
  id TEXT PRIMARY KEY,                    -- uuid
  practitioner_id TEXT NOT NULL,
  name TEXT NOT NULL,
  duration_minutes INTEGER NOT NULL,      -- 30/50/60 etc
  price_cents INTEGER,                    -- optional
  is_active INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ','now')),
  updated_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ','now')),
  FOREIGN KEY (practitioner_id) REFERENCES practitioners(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_service_types_practitioner ON service_types(practitioner_id);

-- Availability rules (recurring weekly windows)
CREATE TABLE IF NOT EXISTS availability_rules (
  id TEXT PRIMARY KEY,                    -- uuid
  practitioner_id TEXT NOT NULL,
  day_of_week INTEGER NOT NULL,           -- 0=Sun ... 6=Sat
  start_time TEXT NOT NULL,               -- "09:00"
  end_time TEXT NOT NULL,                 -- "17:00"
  is_active INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ','now')),
  updated_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ','now')),
  FOREIGN KEY (practitioner_id) REFERENCES practitioners(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_availability_practitioner ON availability_rules(practitioner_id);
CREATE INDEX IF NOT EXISTS idx_availability_day ON availability_rules(day_of_week);

-- Bookings (client appointments) — store minimal PHI
CREATE TABLE IF NOT EXISTS bookings (
  id TEXT PRIMARY KEY,                    -- uuid
  practitioner_id TEXT NOT NULL,
  service_type_id TEXT NOT NULL,
  client_name TEXT NOT NULL,
  client_email TEXT NOT NULL,
  start_at TEXT NOT NULL,                 -- ISO UTC
  end_at TEXT NOT NULL,                   -- ISO UTC
  status TEXT NOT NULL DEFAULT 'confirmed',  -- confirmed|cancelled|completed
  notes TEXT,                             -- avoid PHI if possible
  created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ','now')),
  updated_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ','now')),
  FOREIGN KEY (practitioner_id) REFERENCES practitioners(id) ON DELETE CASCADE,
  FOREIGN KEY (service_type_id) REFERENCES service_types(id) ON DELETE RESTRICT
);

CREATE INDEX IF NOT EXISTS idx_bookings_practitioner_start ON bookings(practitioner_id, start_at);
CREATE INDEX IF NOT EXISTS idx_bookings_status ON bookings(status);

-- Audit logs (who changed what)
CREATE TABLE IF NOT EXISTS audit_logs (
  id TEXT PRIMARY KEY,                    -- uuid
  actor_practitioner_id TEXT,             -- nullable for system actions
  action TEXT NOT NULL,                   -- e.g. "BOOKING_CREATED"
  entity_type TEXT NOT NULL,              -- e.g. "booking"
  entity_id TEXT NOT NULL,
  metadata_json TEXT NOT NULL DEFAULT '{}',
  created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ','now')),
  FOREIGN KEY (actor_practitioner_id) REFERENCES practitioners(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_audit_entity ON audit_logs(entity_type, entity_id);

COMMIT;
