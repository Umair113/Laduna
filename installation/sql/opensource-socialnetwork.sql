/*
File name: C:\Users\vric\Documents\insert.sql
Creation date: 05/12/2017
Created by MySQL to PostgreSQL 3.3 [Demo]
--------------------------------------------------
More conversion tools at http://www.convert-in.com
*/

/*
Table structure for table 'public.ossn_annotations'
*/

DROP TABLE IF EXISTS "public"."ossn_annotations" CASCADE;
CREATE TABLE "public"."ossn_annotations" (
	"id" SERIAL NOT NULL,
	"owner_guid" BIGINT NOT NULL,
	"subject_guid" BIGINT NOT NULL,
	"type" VARCHAR(20)  NOT NULL,
	"time_created" INTEGER NOT NULL
) WITH OIDS;

/*
Dumping data for table 'public.ossn_annotations'
*/


/*
Table structure for table 'public.ossn_components'
*/

DROP TABLE IF EXISTS "public"."ossn_components" CASCADE;
CREATE TABLE "public"."ossn_components" (
	"id" SERIAL NOT NULL,
	"com_id" VARCHAR(20)  NOT NULL,
	"active" INTEGER NOT NULL
) WITH OIDS;

/*
Dumping data for table 'public.ossn_components'
*/

INSERT INTO "public"."ossn_components"("id", "com_id", "active") VALUES (1, 'OssnProfile', 1);
INSERT INTO "public"."ossn_components"("id", "com_id", "active") VALUES (2, 'OssnWall', 1);
INSERT INTO "public"."ossn_components"("id", "com_id", "active") VALUES (3, 'OssnComments', 1);
INSERT INTO "public"."ossn_components"("id", "com_id", "active") VALUES (4, 'OssnLikes', 1);
INSERT INTO "public"."ossn_components"("id", "com_id", "active") VALUES (5, 'OssnPhotos', 1);
INSERT INTO "public"."ossn_components"("id", "com_id", "active") VALUES (6, 'OssnNotifications', 1);
INSERT INTO "public"."ossn_components"("id", "com_id", "active") VALUES (7, 'OssnSearch', 1);
INSERT INTO "public"."ossn_components"("id", "com_id", "active") VALUES (8, 'OssnMessages', 1);
INSERT INTO "public"."ossn_components"("id", "com_id", "active") VALUES (9, 'OssnAds', 1);
INSERT INTO "public"."ossn_components"("id", "com_id", "active") VALUES (10, 'OssnGroups', 1);
INSERT INTO "public"."ossn_components"("id", "com_id", "active") VALUES (11, 'OssnSitePages', 1);
INSERT INTO "public"."ossn_components"("id", "com_id", "active") VALUES (12, 'OssnBlock', 1);
INSERT INTO "public"."ossn_components"("id", "com_id", "active") VALUES (13, 'OssnChat', 1);
INSERT INTO "public"."ossn_components"("id", "com_id", "active") VALUES (14, 'OssnPoke', 1);
INSERT INTO "public"."ossn_components"("id", "com_id", "active") VALUES (15, 'OssnInvite', 1);
INSERT INTO "public"."ossn_components"("id", "com_id", "active") VALUES (16, 'OssnEmbed', 1);
INSERT INTO "public"."ossn_components"("id", "com_id", "active") VALUES (17, 'OssnSmilies', 1);

/*
Table structure for table 'public.ossn_entities'
*/

DROP TABLE IF EXISTS "public"."ossn_entities" CASCADE;
CREATE TABLE "public"."ossn_entities" (
	"guid" SERIAL NOT NULL,
	"owner_guid" BIGINT NOT NULL,
	"type" TEXT NOT NULL,
	"subtype" TEXT NOT NULL,
	"time_created" INTEGER NOT NULL,
	"time_updated" INTEGER,
	"permission" INTEGER NOT NULL,
	"active" INTEGER NOT NULL
) WITH OIDS;

/*
Dumping data for table 'public.ossn_entities'
*/


/*
Table structure for table 'public.ossn_entities_metadata'
*/

DROP TABLE IF EXISTS "public"."ossn_entities_metadata" CASCADE;
CREATE TABLE "public"."ossn_entities_metadata" (
	"id" SERIAL NOT NULL,
	"guid" BIGINT NOT NULL,
	"value" TEXT NOT NULL
) WITH OIDS;

/*
Dumping data for table 'public.ossn_entities_metadata'
*/


/*
Table structure for table 'public.ossn_likes'
*/

DROP TABLE IF EXISTS "public"."ossn_likes" CASCADE;
CREATE TABLE "public"."ossn_likes" (
	"id" SERIAL NOT NULL,
	"subject_id" BIGINT NOT NULL,
	"guid" BIGINT NOT NULL,
	"type" VARCHAR(20)  NOT NULL
) WITH OIDS;

/*
Dumping data for table 'public.ossn_likes'
*/


/*
Table structure for table 'public.ossn_messages'
*/

DROP TABLE IF EXISTS "public"."ossn_messages" CASCADE;
CREATE TABLE "public"."ossn_messages" (
	"id" SERIAL NOT NULL,
	"message_from" BIGINT NOT NULL,
	"message_to" BIGINT NOT NULL,
	"message" TEXT NOT NULL,
	"viewed" VARCHAR(1) ,
	"time" INTEGER NOT NULL
) WITH OIDS;

/*
Dumping data for table 'public.ossn_messages'
*/


/*
Table structure for table 'public.ossn_notifications'
*/

DROP TABLE IF EXISTS "public"."ossn_notifications" CASCADE;
CREATE TABLE "public"."ossn_notifications" (
	"guid" SERIAL NOT NULL,
	"type" TEXT NOT NULL,
	"poster_guid" BIGINT NOT NULL,
	"owner_guid" BIGINT NOT NULL,
	"subject_guid" BIGINT NOT NULL,
	"viewed" VARCHAR(1) ,
	"time_created" INTEGER NOT NULL,
	"item_guid" BIGINT NOT NULL
) WITH OIDS;

/*
Dumping data for table 'public.ossn_notifications'
*/


/*
Table structure for table 'public.ossn_object'
*/

DROP TABLE IF EXISTS "public"."ossn_object" CASCADE;
CREATE TABLE "public"."ossn_object" (
	"guid" SERIAL NOT NULL,
	"owner_guid" BIGINT NOT NULL,
	"type" VARCHAR(20)  NOT NULL,
	"time_created" INTEGER NOT NULL,
	"title" TEXT NOT NULL,
	"description" TEXT NOT NULL,
	"subtype" TEXT NOT NULL
) WITH OIDS;

/*
Dumping data for table 'public.ossn_object'
*/


/*
Table structure for table 'public.ossn_relationships'
*/

DROP TABLE IF EXISTS "public"."ossn_relationships" CASCADE;
CREATE TABLE "public"."ossn_relationships" (
	"relation_id" SERIAL NOT NULL,
	"relation_from" BIGINT NOT NULL,
	"relation_to" BIGINT NOT NULL,
	"type" VARCHAR(20)  NOT NULL,
	"time" INTEGER NOT NULL
) WITH OIDS;

/*
Dumping data for table 'public.ossn_relationships'
*/


/*
Table structure for table 'public.ossn_site_settings'
*/

DROP TABLE IF EXISTS "public"."ossn_site_settings" CASCADE;
CREATE TABLE "public"."ossn_site_settings" (
	"setting_id" SERIAL NOT NULL,
	"name" TEXT NOT NULL,
	"value" TEXT NOT NULL
) WITH OIDS;

/*
Dumping data for table 'public.ossn_site_settings'
*/

INSERT INTO "public"."ossn_site_settings"("setting_id", "name", "value") VALUES (1, 'theme', 'goblue');
INSERT INTO "public"."ossn_site_settings"("setting_id", "name", "value") VALUES (2, 'site_name', '<<sitename>>');
INSERT INTO "public"."ossn_site_settings"("setting_id", "name", "value") VALUES (3, 'language', 'en');
INSERT INTO "public"."ossn_site_settings"("setting_id", "name", "value") VALUES (4, 'cache', '0');
INSERT INTO "public"."ossn_site_settings"("setting_id", "name", "value") VALUES (5, 'owner_email', '<<owner_email>>');
INSERT INTO "public"."ossn_site_settings"("setting_id", "name", "value") VALUES (6, 'notification_email', '<<notification_email>>');
INSERT INTO "public"."ossn_site_settings"("setting_id", "name", "value") VALUES (7, 'upgrades', '["1410545706.php","1411396351.php", "1412353569.php","1415553653.php","1415819862.php", "1423419053.php", "1423419054.php", "1439295894.php", "1440716428.php", "1440867331.php", "1440603377.php", "1443202118.php", "1443211017.php", "1443545762.php", "1443617470.php", "1446311454.php", "1448807613.php", "1453676400.php", "1459411815.php", "1468010638.php", "1470127853.php", "1480759958.php"]');
INSERT INTO "public"."ossn_site_settings"("setting_id", "name", "value") VALUES (9, 'display_errors', 'off');
INSERT INTO "public"."ossn_site_settings"("setting_id", "name", "value") VALUES (10, 'site_key', '<<screat>>');
INSERT INTO "public"."ossn_site_settings"("setting_id", "name", "value") VALUES (11, 'last_cache', '');
INSERT INTO "public"."ossn_site_settings"("setting_id", "name", "value") VALUES (12, 'site_version', '4.3.1');

/*
Table structure for table 'public.ossn_users'
*/

DROP TABLE IF EXISTS "public"."ossn_users" CASCADE;
CREATE TABLE "public"."ossn_users" (
	"guid" SERIAL NOT NULL,
	"type" TEXT NOT NULL,
	"username" TEXT NOT NULL,
	"email" TEXT NOT NULL,
	"password" TEXT NOT NULL,
	"salt" VARCHAR(8)  NOT NULL,
	"first_name" TEXT NOT NULL,
	"last_name" TEXT NOT NULL,
	"last_login" INTEGER NOT NULL,
	"last_activity" INTEGER NOT NULL,
	"activation" TEXT,
	"time_created" INTEGER NOT NULL
) WITH OIDS;

/*
Dumping data for table 'public.ossn_users'
*/

