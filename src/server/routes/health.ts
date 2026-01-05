import { Hono } from "hono";

const healthRouter = new Hono();

healthRouter.get("/health", (c) => {
  return c.json({ ok: true, service: "valerie-psych-booking", ts: Date.now() });
});

export default healthRouter;
