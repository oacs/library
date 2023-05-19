import { InferModel } from "drizzle-orm";
import {
  integer,
  pgTable,
  primaryKey,
  serial,
  text,
} from "drizzle-orm/pg-core";

export const books = pgTable("books", {
  id: serial("id").primaryKey(),
  fullName: text("full_name").notNull(),
  isbn: text("isbn"),
  img: text("img"),
  authorId: integer("author_id").references(() => authors.id),
});

export const tags = pgTable("tags", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
});

export const booksTags = pgTable(
  "books_tags",
  {
    bookId: integer("book_id").references(() => books.id),
    authorId: integer("tag_id").references(() => tags.id),
  },
  (table) => ({
    cpk: primaryKey(table.bookId, table.authorId),
  })
);

export const authors = pgTable("authors", {
  id: serial("id").primaryKey(),
  fullName: text("full_name").notNull(),
});

export type Book = InferModel<typeof books>;
export type Tags = InferModel<typeof tags>;

export type NewBook = InferModel<typeof books, "insert">;
export type NewTag = InferModel<typeof tags, "insert">;
