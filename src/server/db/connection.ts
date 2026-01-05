import type { Env } from "../types/env.js";
import type { D1Database } from "@cloudflare/workers-types";

export function getDatabase(env: Env): D1Database {
  if (!env.DB) {
    throw new Error("DB binding missing. Check wrangler.json d1_databases binding is 'DB'.");
  }
  return env.DB;
}
