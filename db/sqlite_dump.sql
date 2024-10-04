-- PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
-- Commented out duplicate entries
-- INSERT INTO schema_migrations VALUES('20240910170819');
-- INSERT INTO schema_migrations VALUES('20240910203017');
-- Other inserts as needed...

-- Commented out duplicate metadata entry
-- INSERT INTO ar_internal_metadata VALUES('environment','development','2024-09-10 17:24:34.953798','2024-09-10 17:24:34.953798');

CREATE TABLE IF NOT EXISTS "articles" ("id" SERIAL PRIMARY KEY, "title" varchar, "body" text, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "status" varchar, "user_id" integer);
INSERT INTO articles VALUES(1,'1st Blog','From API i think it is fixed now','2024-09-10 17:32:06','2024-09-23 17:43:01','public',NULL);
INSERT INTO articles VALUES(8,'New Blog','First Creation from the API','2024-09-23 17:52:29','2024-09-23 17:52:29','public',NULL);

CREATE TABLE IF NOT EXISTS "comments" ("id" SERIAL PRIMARY KEY, "commenter" varchar, "body" text, "article_id" integer NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "status" varchar, CONSTRAINT "fk_rails_3bf61a60d3" FOREIGN KEY ("article_id") REFERENCES "articles" ("id"));
INSERT INTO comments VALUES(6,'Akshat','this is a comment',1,'2024-09-16 23:45:17','2024-09-16 23:45:17','public');


COMMIT;
