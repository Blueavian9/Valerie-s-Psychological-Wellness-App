import type { D1Database } from "@cloudflare/workers-types";

export type Env = {
	DB: D1Database;
};