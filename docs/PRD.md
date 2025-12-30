
# Holistic Psychology Booking Platform (PRD.md)

1. Product Overview

The Holistic Psychology Booking Platform is a privacy-first, SEO-optimized online booking system for holistic psychologists. It enables practitioners to manage availability and bookings securely, while allowing clients to book sessions without creating accounts.

The system is designed to be HIPAA-aware, self-hosted, and scalable, using Cloudflare’s edge stack for performance and future growth.

2. Problem Statement

Current booking tools for holistic psychology practices:

Are difficult to use for vulnerable populations

Do not prioritize privacy or HIPAA considerations

Lack SEO optimization, reducing discoverability

Require heavy SaaS lock-in with limited data ownership

This platform solves those issues with a lightweight, transparent, and practitioner-owned solution.

3. Target Users
Primary Users

Holistic psychologists

Small psychology practices

Secondary Users

Families

Survivors of domestic violence

Single mothers

Low-income individuals seeking therapy

4. Product Goals

Enable account-free client bookings

Ensure secure practitioner-only access

Maintain HIPAA-aware data handling

Optimize for SEO and accessibility

Deploy using edge-native infrastructure

Be extensible for future features (payments, insurance, multi-practitioner)

5. Technical Stack
Layer	Technology
Frontend	Vite + React 19 + TypeScript + shadcn/ui
Backend	Hono on Cloudflare Workers
Database	Cloudflare D1 (SQLite at edge)
Auth	Magic Links / JWT (Resend)
Email	Resend
SEO	Hono SSR + React Helmet
Hosting	Cloudflare Workers
CI/CD	Wrangler
6. Development Methodology (Chaining Prompt Rule)

Every task must follow this pattern:

State Now – What exists currently?

Change State – What command or code changes it?

Verify State – How do we confirm success?

This rule applies to:

Git

Database migrations

API routes

UI components

Deployments

EPIC 0: Repository & Environment Setup
Goal

Prepare a clean, reproducible development environment.

Tasks

 Clone repository

 Install dependencies

 Verify local dev server runs

 Commit baseline state

Acceptance Criteria

npm run dev works

No TypeScript errors

Repo builds without warnings

EPIC 1: Database Foundation (Cloudflare D1)
Goal

Create a secure, auditable database structure.

Feature 1.1: Initialize D1 Database

 Create D1 database

 Bind database in wrangler.json

 Generate types

Verify:
npx wrangler d1 execute <db> --local --command "SELECT 1"

Feature 1.2: Core Tables
Tables

practitioners

availability

appointments

audit_logs

Tasks

 Create 0001_initial.sql

 Apply locally

 Apply to production

Verify:
SELECT name FROM sqlite_master WHERE type='table'

EPIC 2: Backend API (Hono)
Goal

Expose secure, predictable APIs.

Feature 2.1: Health & Test Routes

 /api/health

 /api/hello

Feature 2.2: Practitioner Authentication

 Magic link login

 JWT validation middleware

 Protected routes

Feature 2.3: Booking APIs
Endpoints

GET /api/availability

POST /api/appointments

GET /api/appointments/:id

Each endpoint must:

Validate input

Log audit entry

Return typed responses

EPIC 3: Frontend UI (React)
Goal

Deliver a calm, accessible booking experience.

Feature 3.1: Public Booking Pages

 Landing page (SEO-first)

 Practitioner profile page

 Availability calendar

 Booking confirmation page

Feature 3.2: Practitioner Dashboard

 Login screen

 Availability editor

 Appointment list

 Logout flow

EPIC 4: SEO & Accessibility
Goal

Maximize discoverability and trust.

Tasks

 SSR with Hono

 React Helmet metadata

 Semantic HTML

 Accessibility checks

EPIC 5: Email Notifications
Goal

Confirm bookings securely.

Tasks

 Integrate Resend

 Booking confirmation email

 Practitioner notification email

EPIC 6: Security & Compliance (HIPAA-Aware)
Goal

Minimize risk and exposure.

Tasks

 No PHI in URLs

 No client accounts

 Encrypted transport (HTTPS)

 Audit logs for data access

 Privacy notice page

EPIC 7: Deployment & Hosting
Goal

Ship to production.

Tasks

 Apply migrations to production

 Build frontend

 Deploy Worker

 Verify live endpoints

Verify:

Booking flow works end-to-end

Emails are delivered

Database records persist

EPIC 8: Scalability & Future Enhancements
Planned (Post-MVP)

Payments (Stripe)

Multi-practitioner support

Admin roles

Insurance workflows

Calendar sync (Google/Apple)

Analytics dashboard

7. Success Metrics

100+ bookings in first month

<2s page load time

Zero unauthorized data access

Positive practitioner feedback

8. Non-Goals (Explicitly Out of Scope for MVP)

Video therapy

Insurance billing

Mobile apps

Client user accounts

9. Final Notes

This PRD is intentionally modular and junior-friendly.
Each EPIC can be completed independently, tested locally, and deployed incrementally.

Rule: Never jump to the final line.

Always validate the state before and after each change.


