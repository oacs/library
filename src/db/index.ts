import { drizzle } from "drizzle-orm/vercel-postgres";
import { sql } from "@vercel/postgres";
import { migrate } from "drizzle-orm/node-postgres/migrator";

export const db = drizzle(sql);

// this will automatically run needed migrations on the database
(async () => {
  await migrate(db, { migrationsFolder: "src/db/migrations" });
})();
