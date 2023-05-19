import { db } from "@/db";
import { books } from "@/db/schema";

export default async function Home() {
  const test = await db.select().from(books).execute();
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      {test && test.map((book) => <li>{JSON.stringify(book)}</li>)}
    </main>
  );
}
