CREATE TABLE IF NOT EXISTS "authors" (
	"id" serial PRIMARY KEY NOT NULL,
	"full_name" text NOT NULL
);

CREATE TABLE IF NOT EXISTS "books_tags" (
	"book_id" integer,
	"tag_id" integer
);
--> statement-breakpoint
ALTER TABLE "books_tags" ADD CONSTRAINT "books_tags_book_id_tag_id" PRIMARY KEY("book_id","tag_id");

CREATE TABLE IF NOT EXISTS "tags" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL
);

ALTER TABLE "books" ALTER COLUMN "full_name" SET NOT NULL;
ALTER TABLE "books" ADD COLUMN "img" text;
ALTER TABLE "books" ADD COLUMN "author_id" integer;
DO $$ BEGIN
 ALTER TABLE "books" ADD CONSTRAINT "books_author_id_authors_id_fk" FOREIGN KEY ("author_id") REFERENCES "authors"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
 ALTER TABLE "books_tags" ADD CONSTRAINT "books_tags_book_id_books_id_fk" FOREIGN KEY ("book_id") REFERENCES "books"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
 ALTER TABLE "books_tags" ADD CONSTRAINT "books_tags_tag_id_tags_id_fk" FOREIGN KEY ("tag_id") REFERENCES "tags"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
