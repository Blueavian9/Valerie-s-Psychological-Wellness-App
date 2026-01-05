import type { D1Database } from "@cloudflare/workers-types";

/**
 * Environment bindings injected by Cloudflare Workers
 */
export type Env = {
  DB: D1Database;
};
