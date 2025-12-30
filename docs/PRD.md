<<<<<<< HEAD

# Holistic Psychology Booking Platform (PRD.md)
=======
# PRD.md
# Holistic Psychology Booking Platform
>>>>>>> 5fff434 (created PRD.md file)

1. Product Overview

The Holistic Psychology Booking Platform is a privacy-first, SEO-optimized online booking system for holistic psychologists. It enables practitioners to manage availability and bookings securely while allowing clients to book sessions without creating accounts.

The platform is built on a Cloudflare edge-native stack to ensure performance, scalability, and future extensibility.

2. Core Principles

HIPAA-aware by design (data minimization, auditability)

Practitioner-owned data

Account-free client booking

SEO-first public pages

Incremental, testable development

Junior-developer friendly execution

3. Target Users
Practitioners

Holistic psychologists

Small private practices

Clients

Families

Survivors of domestic violence

Single mothers

Low-income individuals seeking therapy

4. Out of Scope (MVP Guardrails)

The MVP explicitly excludes:

Video therapy

Insurance billing

Mobile apps

Client user accounts

Payments

These are planned future epics, not MVP blockers.

5. Technical Stack (Locked)
Layer	Technology
Frontend	Vite + React 19 + TypeScript + shadcn/ui
Backend	Hono on Cloudflare Workers
Database	Cloudflare D1
Auth	Magic Links + JWT
Email	Resend
SEO	Hono SSR + React Helmet
Hosting	Cloudflare Workers
CLI	Wrangler
6. Required Reading (Before Coding)

Before starting EPIC 0, the developer MUST complete:

📄 Setup.md
This document defines:

Repository creation

Cloudflare setup

D1 database creation

Wrangler configuration

Local + production workflows

👉 This PRD assumes Setup.md has been completed successfully.

7. Development Rule: Chaining Prompt Standard

Every task must follow this execution pattern:

State Now – What exists?

Change State – What code or command changes it?

Verify State – How do we confirm success?

❌ Never jump directly to deployment
✅ Always validate locally first

EPIC 0: Project Initialization (Post-Setup)
Goal

Confirm baseline project health after Setup.md.

Tasks

 Run npm install

 Run npm run dev

 Verify local server loads

 Commit baseline state

Verify

No TypeScript errors

App loads at localhost:5173

EPIC 1: Database Architecture (D1)
Goal

Create secure, minimal, auditable persistence.

Feature 1.1: Core Tables
Tables

practitioners

availability

appointments

audit_logs

Tasks

 Create 0001_initial.sql

 Apply locally (--local)

 Verify tables exist

 Apply to production (--remote)

Verify

SELECT name FROM sqlite_master WHERE type='table';

Feature 1.2: Data Rules

No PHI in URLs

No client passwords

All writes logged in audit_logs

EPIC 2: Backend API (Hono)
Goal

Expose predictable, typed APIs.

Feature 2.1: Health & Test Routes
Routes

GET /api/health

GET /api/hello

Verify

Returns JSON

No database dependency

Feature 2.2: Practitioner Authentication
Tasks

 Magic link request endpoint

 JWT verification middleware

 Protected routes

Verify

Unauthenticated access denied

Token expires correctly

Feature 2.3: Booking APIs
Endpoints

GET /api/availability

POST /api/appointments

GET /api/appointments/:id

Requirements

Input validation

Audit logging

Typed responses

EPIC 3: Frontend (React)
Goal

Deliver a calm, accessible booking experience.

Feature 3.1: Public Pages (SEO)

Landing page

Practitioner profile

Availability calendar

Booking confirmation

Verify

Indexed metadata

No auth required

Mobile responsive

Feature 3.2: Practitioner Dashboard

Login screen

Availability editor

Booking list

Logout flow

Verify

Auth protected

Data matches DB state

EPIC 4: SEO & Accessibility
Tasks

 Hono SSR enabled

 React Helmet metadata

 Semantic HTML

 Accessible forms

EPIC 5: Email Notifications
Tasks

 Booking confirmation email

 Practitioner notification

 Resend integration

Verify

Email sent on booking

No sensitive data exposed

EPIC 6: Security & Compliance
Requirements

HTTPS only

No client accounts

Audit logs for all writes

Privacy notice page

EPIC 7: Deployment
Tasks

 Run production migrations

 Build frontend

 Deploy Worker

 Verify endpoints

Verify

Booking works end-to-end

Data persists

Emails deliver

EPIC 8: Scalability (Post-MVP)

Planned future enhancements:

Payments (Stripe)

Multi-practitioner orgs

Admin roles

Calendar sync

Analytics

Insurance workflows

8. Success Metrics

100+ bookings in first month

<2s page load time

Zero unauthorized data access

Practitioner retention

9. Final Notes

Setup.md = HOW

<<<<<<< HEAD
Rule: Never jump to the final line.

Always validate the state before and after each change.


=======
PRD.md = WHAT & WHY

Every EPIC is independently testable

Junior developers should complete EPICS sequentially

Rule:
Never jump to the final line.
Always confirm the state before and after.
>>>>>>> 5fff434 (created PRD.md file)
