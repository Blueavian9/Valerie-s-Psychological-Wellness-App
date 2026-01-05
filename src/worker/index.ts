import { Hono } from "hono";
import helloRouter from "../server/routes/hello.js";
import healthRouter from "../server/routes/health.js";
import type { Env } from "../server/types/env.js";

const app = new Hono<{ Bindings: Env }>();

// API routes
app.route("/api", healthRouter);
app.route("/api", helloRouter);

// Optional: simple root
app.get("/api", (c) => c.json({ ok: true, name: "Valerie Psych Booking API" }));

export default app;
