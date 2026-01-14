/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : PostgreSQL
 Source Server Version : 160004 (160004)
 Source Host           : localhost:5432
 Source Catalog        : portfolio_db
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 160004 (160004)
 File Encoding         : 65001

 Date: 13/01/2026 21:12:14
*/


-- ----------------------------
-- Table structure for education
-- ----------------------------
DROP TABLE IF EXISTS "education";
CREATE TABLE "education" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "degree" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "institution" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "location" varchar(255) COLLATE "pg_catalog"."default",
  "start_year" varchar(4) COLLATE "pg_catalog"."default",
  "end_year" varchar(4) COLLATE "pg_catalog"."default",
  "year" varchar(20) COLLATE "pg_catalog"."default",
  "description" text COLLATE "pg_catalog"."default",
  "display_order" int4 DEFAULT 0,
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;

-- ----------------------------
-- Records of education
-- ----------------------------
BEGIN;
INSERT INTO "education" ("id", "degree", "institution", "location", "start_year", "end_year", "year", "description", "display_order", "created_at") VALUES ('f4b08a2f-46ed-441e-b9dc-6c7aed2921d6', 'Bachelor of Science in Computer Science', 'Tarlac State University', 'Tarlac City, Philippines', NULL, NULL, '2020-2024', NULL, 1, '2026-01-09 21:49:05.654515'), ('7efb9044-22d0-4823-860f-5cdd27667c73', 'Senior High School - TVL (ICT)', 'AMA Computer College', 'Tarlac City, Philippines', NULL, NULL, '2018-2020', NULL, 2, '2026-01-09 21:49:05.654515');
COMMIT;

-- ----------------------------
-- Table structure for experience
-- ----------------------------
DROP TABLE IF EXISTS "experience";
CREATE TABLE "experience" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "position" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "company" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "location" varchar(255) COLLATE "pg_catalog"."default",
  "start_year" varchar(4) COLLATE "pg_catalog"."default",
  "end_year" varchar(4) COLLATE "pg_catalog"."default",
  "period" varchar(50) COLLATE "pg_catalog"."default",
  "description" text COLLATE "pg_catalog"."default",
  "skills" jsonb,
  "type" varchar(50) COLLATE "pg_catalog"."default" DEFAULT 'Work'::character varying,
  "display_order" int4 DEFAULT 0,
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;

-- ----------------------------
-- Records of experience
-- ----------------------------
BEGIN;
INSERT INTO "experience" ("id", "position", "company", "location", "start_year", "end_year", "period", "description", "skills", "type", "display_order", "created_at") VALUES ('9528b538-9c58-4cfb-bc92-9fb2c472e929', 'Web Developer / Web Designer', 'ITBS Corporation', 'San Fernando City, Pampanga', NULL, NULL, '2024', 'Lead front-end development with Vue.js and Quasar Framework. Designed and implemented responsive, accessible web applications and optimized performance across projects.', '["Vue.js", "Quasar", "JavaScript", "UI/UX", "REST API"]', 'Work', 1, '2026-01-09 21:49:05.649688'), ('60e3fe2f-c8ff-4a8f-b31e-e62ae7faf701', 'Student Intern', 'Kaizenaire Pte. Ltd.', 'Siglap V, Singapore', NULL, NULL, '2023', 'Gained valuable experience in web development through hands-on training and project-based learning. Collaborated with senior developers on real-world applications.', '["Web Development", "HTML/CSS", "JavaScript", "Vue.js"]', 'Work', 2, '2026-01-09 21:49:05.649688'), ('9f47f619-1eb1-417f-b611-39ea618e6bd9', 'Office Assistant', 'Registry of Deeds', 'Tarlac City, Philippines', NULL, NULL, '2020', 'Assisted in office administration and document management. Developed organizational skills and attention to detail in a professional environment.', '["Office Administration", "Documentation", "Data Entry"]', 'Work', 3, '2026-01-09 21:49:05.649688'), ('df4aa432-0902-4297-b306-eacb71642ffc', 'Office Assistant - SPES', 'Tarlac Provincial Capitol', 'Tarlac City, Philippines', NULL, NULL, '2017', 'Participated in the Special Program for Employment of Students (SPES). Gained early professional experience in a government office setting.', '["Office Work", "Filing", "Basic Computer Skills"]', 'Work', 4, '2026-01-09 21:49:05.649688');
COMMIT;

-- ----------------------------
-- Table structure for portfolio_config
-- ----------------------------
DROP TABLE IF EXISTS "portfolio_config";
CREATE TABLE "portfolio_config" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "key" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "value" jsonb NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "updated_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;

-- ----------------------------
-- Records of portfolio_config
-- ----------------------------
BEGIN;
INSERT INTO "portfolio_config" ("id", "key", "value", "description", "updated_at") VALUES ('03693ea3-ff47-4c06-8e1a-c6b24d4c20e8', 'site_title', '"Marion Miguel Portfolio"', 'Main title of the portfolio website', '2026-01-09 21:49:05.66265'), ('f6bf8ee6-848d-491e-a523-7a7321b5adbc', 'site_description', '"Full-stack developer and UI/UX designer portfolio"', 'Meta description for SEO', '2026-01-09 21:49:05.66265'), ('7f0c5954-d2bd-42a5-8aa7-69210e6b158b', 'contact_email', '"miguelmarionray@gmail.com"', 'Primary contact email', '2026-01-09 21:49:05.66265'), ('774fb79d-7973-44a1-9ebf-e5ef78e2f4a1', 'social_links', '{"github": "https://github.com", "behance": "https://behance.net", "linkedin": "https://linkedin.com"}', 'Social media links', '2026-01-09 21:49:05.66265'), ('ead85a12-84e3-4fbb-8924-336131c226bf', 'hero_title', '"Creative Developer"', 'Hero section main title', '2026-01-09 21:49:05.66265'), ('7151e195-0376-4509-9b1c-043e95a68a4a', 'hero_subtitle', '"Building digital experiences with Vue.js & modern design"', 'Hero section subtitle', '2026-01-09 21:49:05.66265');
COMMIT;

-- ----------------------------
-- Table structure for project_images
-- ----------------------------
DROP TABLE IF EXISTS "project_images";
CREATE TABLE "project_images" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "project_id" uuid NOT NULL,
  "image_url" text COLLATE "pg_catalog"."default" NOT NULL,
  "image_data" bytea,
  "image_name" varchar(255) COLLATE "pg_catalog"."default",
  "image_type" varchar(50) COLLATE "pg_catalog"."default",
  "is_primary" bool DEFAULT false,
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;

-- ----------------------------
-- Records of project_images
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for projects
-- ----------------------------
DROP TABLE IF EXISTS "projects";
CREATE TABLE "projects" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "title" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default" NOT NULL,
  "full_description" text COLLATE "pg_catalog"."default",
  "tech" jsonb NOT NULL,
  "image_url" text COLLATE "pg_catalog"."default",
  "live_url" text COLLATE "pg_catalog"."default",
  "code_url" text COLLATE "pg_catalog"."default",
  "category" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "duration" varchar(50) COLLATE "pg_catalog"."default",
  "client" varchar(255) COLLATE "pg_catalog"."default",
  "year" varchar(4) COLLATE "pg_catalog"."default",
  "accent_color" varchar(7) COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;

-- ----------------------------
-- Records of projects
-- ----------------------------
BEGIN;
INSERT INTO "projects" ("id", "title", "description", "full_description", "tech", "image_url", "live_url", "code_url", "category", "duration", "client", "year", "accent_color", "created_at", "updated_at") VALUES ('3172ec29-29a0-41a0-a6f7-efe9ab840480', 'HRIS Launcher', 'A comprehensive Human Resource Information System with advanced features for employee management, payroll, attendance tracking, and analytics.', NULL, '["Vue.js", "Quasar", "REST API"]', 'https://via.placeholder.com/600x400/667eea/ffffff?text=HRIS+Launcher', 'https://itbs.solutions', '#', 'Web Apps', '6 weeks', NULL, NULL, NULL, '2026-01-09 21:49:05.636773', '2026-01-09 21:49:05.636773'), ('75b29e8a-572d-43d5-b901-d8b388528b3c', 'ITBS Solutions', 'Company website with interactive interface and service showcase, featuring integration with various business tools and CMS capabilities.', NULL, '["Vue.js", "Quasar", "Firebase"]', 'https://via.placeholder.com/600x400/00f2fe/ffffff?text=ITBS+Solutions', 'https://itbs.solutions', '#', 'Corporate Site', '4 weeks', NULL, NULL, NULL, '2026-01-09 21:49:05.636773', '2026-01-09 21:49:05.636773'), ('2a894d3e-c9c0-4cb5-b3d4-c7cc7b56234d', 'Kiosk Landing Page', 'Interactive kiosk interface designed for public spaces with touch functionality, user-friendly navigation, and information display.', NULL, '["Vue.js", "Quasar", "HTML5"]', 'https://via.placeholder.com/600x400/764ba2/ffffff?text=Kiosk+Landing', '#', '#', 'UI/UX', '3 weeks', NULL, NULL, NULL, '2026-01-09 21:49:05.636773', '2026-01-09 21:49:05.636773'), ('f821aba6-d648-4137-afb6-a2f415be03b8', 'LWUA Landing Page', 'Modern landing page for Local Water Utilities Administration with service information, interactive elements, and responsive design.', NULL, '["Vue.js", "Quasar", "Responsive Design"]', 'https://via.placeholder.com/600x400/f5576c/ffffff?text=LWUA+Landing', '#', '#', 'Landing Page', '2 weeks', NULL, NULL, NULL, '2026-01-09 21:49:05.636773', '2026-01-09 21:49:05.636773'), ('42997331-213f-4e8a-94a9-1205906c5825', 'NLEX Landing Page', 'High-performance landing page for North Luzon Expressway with traffic updates, toll information, and interactive map integration.', NULL, '["Vue.js", "Quasar", "Maps API"]', 'https://via.placeholder.com/600x400/667eea/ffffff?text=NLEX+Landing', '#', '#', 'Landing Page', '3 weeks', NULL, NULL, NULL, '2026-01-09 21:49:05.636773', '2026-01-09 21:49:05.636773'), ('cfd1bef0-2c5a-44ec-acc3-6f6c6be533df', 'UNMS Monitoring', 'Unified Network Management System for real-time monitoring, alerting, and management of network infrastructure with interactive dashboards.', NULL, '["Vue.js", "Quasar", "Chart.js"]', 'https://via.placeholder.com/600x400/00f2fe/ffffff?text=UNMS+Monitoring', '#', '#', 'Monitoring System', '8 weeks', NULL, NULL, NULL, '2026-01-09 21:49:05.636773', '2026-01-09 21:49:05.636773'), ('26d5d80a-855c-4239-a4de-6da14a14cfa9', 'NHA Accounting', 'Comprehensive accounting system for National Housing Authority with financial reporting, budget tracking, and audit capabilities.', NULL, '["Vue.js", "Quasar", "Database Integration"]', 'https://via.placeholder.com/600x400/764ba2/ffffff?text=NHA+Accounting', '#', '#', 'Accounting System', '10 weeks', NULL, NULL, NULL, '2026-01-09 21:49:05.636773', '2026-01-09 21:49:05.636773'), ('aa047b1e-7616-4cd4-b722-f74c8baf47ce', 'DICT Speedtest', 'Web and mobile application for internet speed testing with data collection, analytics, and regional performance comparison.', NULL, '["Vue.js", "Quasar", "PWA", "Mobile App"]', 'https://via.placeholder.com/600x400/f5576c/ffffff?text=DICT+Speedtest', '#', '#', 'Web & Mobile Apps', '5 weeks', NULL, NULL, NULL, '2026-01-09 21:49:05.636773', '2026-01-09 21:49:05.636773'), ('74a00608-2b24-41d9-8841-5b0f78e56579', 'Cebu Monitoring', 'Regional monitoring system for Cebu with real-time data visualization, alerts, and performance metrics tracking.', NULL, '["Vue.js", "Quasar", "Real-time Data"]', 'https://via.placeholder.com/600x400/667eea/ffffff?text=Cebu+Monitoring', '#', '#', 'Monitoring System', '6 weeks', NULL, NULL, NULL, '2026-01-09 21:49:05.636773', '2026-01-09 21:49:05.636773'), ('a72df927-b647-43ab-944c-42e8a69f58ce', 'BPLS Client Side', 'Business Permit and Licensing System client interface with streamlined application process, status tracking, and document management.', NULL, '["Vue.js", "Quasar", "API Integration"]', 'https://via.placeholder.com/600x400/00f2fe/ffffff?text=BPLS+Client', '#', '#', 'Government System', '7 weeks', NULL, NULL, NULL, '2026-01-09 21:49:05.636773', '2026-01-09 21:49:05.636773'), ('32eafc12-d260-495b-ae63-4c7d03573982', 'BPLS Baguio & Caloocan', 'Customized Business Permit and Licensing System for Baguio and Caloocan cities with localized requirements and workflow.', NULL, '["Vue.js", "Quasar", "Custom Workflows"]', 'https://via.placeholder.com/600x400/764ba2/ffffff?text=BPLS+Cities', '#', '#', 'Government System', '8 weeks', NULL, NULL, NULL, '2026-01-09 21:49:05.636773', '2026-01-09 21:49:05.636773'), ('86e26c52-0a9f-49e9-b2fe-6fc3db91fcfb', 'Inspector App', 'Mobile application for field inspectors with offline capabilities, photo documentation, form submission, and synchronization.', NULL, '["Vue.js", "Quasar", "Mobile App"]', 'https://via.placeholder.com/600x400/f5576c/ffffff?text=Inspector+App', '#', '#', 'Mobile App', '4 weeks', NULL, NULL, NULL, '2026-01-09 21:49:05.636773', '2026-01-09 21:49:05.636773');
COMMIT;

-- ----------------------------
-- Table structure for skill_categories
-- ----------------------------
DROP TABLE IF EXISTS "skill_categories";
CREATE TABLE "skill_categories" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "title" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "display_order" int4 DEFAULT 0,
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;

-- ----------------------------
-- Records of skill_categories
-- ----------------------------
BEGIN;
INSERT INTO "skill_categories" ("id", "name", "title", "display_order", "created_at") VALUES ('54e5b76e-95d7-40f5-9bfe-c8bc50f09dd3', 'development', 'Development', 1, '2026-01-09 21:49:05.596737'), ('a31c1c0b-153f-4da5-b54a-ddd5f86091f0', 'design', 'Design', 2, '2026-01-09 21:49:05.596737'), ('0ce8e67b-8ae3-4c5c-9759-b5e705dea740', 'other', 'Other Skills', 3, '2026-01-09 21:49:05.596737');
COMMIT;

-- ----------------------------
-- Table structure for skills
-- ----------------------------
DROP TABLE IF EXISTS "skills";
CREATE TABLE "skills" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "category_id" uuid NOT NULL,
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "level" int4,
  "icon" varchar(10) COLLATE "pg_catalog"."default",
  "display_order" int4 DEFAULT 0,
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;

-- ----------------------------
-- Records of skills
-- ----------------------------
BEGIN;
INSERT INTO "skills" ("id", "category_id", "name", "level", "icon", "display_order", "created_at") VALUES ('59b7b32b-629c-4694-ba96-a6f6624aee12', '54e5b76e-95d7-40f5-9bfe-c8bc50f09dd3', 'HTML 5', NULL, NULL, 1, '2026-01-09 21:49:05.6098'), ('9fdd1c3e-b59a-4c79-aeaa-5d5302cbf788', '54e5b76e-95d7-40f5-9bfe-c8bc50f09dd3', 'Rest API', NULL, NULL, 2, '2026-01-09 21:49:05.6098'), ('7525bb12-169e-46ce-bf59-73ff5bd3a4c1', '54e5b76e-95d7-40f5-9bfe-c8bc50f09dd3', 'CSS/ SCSS', NULL, NULL, 3, '2026-01-09 21:49:05.6098'), ('6172a08c-2ec3-4459-a6bf-21579e31eb26', '54e5b76e-95d7-40f5-9bfe-c8bc50f09dd3', 'Tailwind', NULL, NULL, 4, '2026-01-09 21:49:05.6098'), ('1827c41f-c7df-4b26-bf65-151958efb593', '54e5b76e-95d7-40f5-9bfe-c8bc50f09dd3', 'Bootstrap', NULL, NULL, 5, '2026-01-09 21:49:05.6098'), ('f5498b0e-68cb-440e-bff7-8a352c7cc321', '54e5b76e-95d7-40f5-9bfe-c8bc50f09dd3', 'JavaScript', NULL, NULL, 6, '2026-01-09 21:49:05.6098'), ('1377d03f-bc59-459d-928a-8d405ebfe6e0', '54e5b76e-95d7-40f5-9bfe-c8bc50f09dd3', 'Vue.js', NULL, NULL, 7, '2026-01-09 21:49:05.6098'), ('5b98bd51-a998-424c-bba7-f838cbf38566', '54e5b76e-95d7-40f5-9bfe-c8bc50f09dd3', 'Typescript', NULL, NULL, 8, '2026-01-09 21:49:05.6098'), ('58adf787-74fb-402d-b553-00575df7d6ed', '54e5b76e-95d7-40f5-9bfe-c8bc50f09dd3', 'Quasar Framework', NULL, NULL, 9, '2026-01-09 21:49:05.6098'), ('6ab45547-84f4-493a-bace-ddaeccfed80d', '54e5b76e-95d7-40f5-9bfe-c8bc50f09dd3', 'Mysql', NULL, NULL, 10, '2026-01-09 21:49:05.6098'), ('aae4bb92-06a5-4d10-9c7f-6e0b1a876a19', '54e5b76e-95d7-40f5-9bfe-c8bc50f09dd3', 'SQL', NULL, NULL, 11, '2026-01-09 21:49:05.6098'), ('7e9d1eab-998e-409e-ae31-484bbe55cf6e', '54e5b76e-95d7-40f5-9bfe-c8bc50f09dd3', 'Navicat', NULL, NULL, 12, '2026-01-09 21:49:05.6098'), ('ebf86896-469f-4226-ac1a-de235562c51a', '54e5b76e-95d7-40f5-9bfe-c8bc50f09dd3', 'POSTGRESQL', NULL, NULL, 13, '2026-01-09 21:49:05.6098'), ('f16072b1-85a4-4ca5-b7da-87678b99aa51', 'a31c1c0b-153f-4da5-b54a-ddd5f86091f0', 'Figma', NULL, NULL, 1, '2026-01-09 21:49:05.6098'), ('8b1bc9a0-814d-48e2-ac3e-a194176ba5bf', 'a31c1c0b-153f-4da5-b54a-ddd5f86091f0', 'Adobe Illustrator', NULL, NULL, 2, '2026-01-09 21:49:05.6098'), ('5a51a353-85fb-4ef7-9673-160a35535fd0', 'a31c1c0b-153f-4da5-b54a-ddd5f86091f0', 'UI/UX Principles', NULL, NULL, 3, '2026-01-09 21:49:05.6098'), ('171ac0f4-a0dd-4df3-943c-64b333bdb1de', 'a31c1c0b-153f-4da5-b54a-ddd5f86091f0', 'Caricature/ Drawing', NULL, NULL, 4, '2026-01-09 21:49:05.6098'), ('4d4232ef-59d9-4362-ac9d-b23fa1d95c9f', '0ce8e67b-8ae3-4c5c-9759-b5e705dea740', 'Git/GitHub', NULL, NULL, 1, '2026-01-09 21:49:05.6098'), ('16a73ed3-e7b0-4fe8-8b42-07c7b031c97f', '0ce8e67b-8ae3-4c5c-9759-b5e705dea740', 'Responsive Design', NULL, NULL, 2, '2026-01-09 21:49:05.6098'), ('99ad98fc-ad61-4d78-910b-919d4cd521ec', '0ce8e67b-8ae3-4c5c-9759-b5e705dea740', 'Performance Optimization', NULL, NULL, 3, '2026-01-09 21:49:05.6098'), ('4f22f4e9-f6f3-43d9-b848-fb343f6b0c36', '0ce8e67b-8ae3-4c5c-9759-b5e705dea740', 'SEO Basics', NULL, NULL, 4, '2026-01-09 21:49:05.6098'), ('f15e3776-06d7-4147-8ff5-fe57bc5394cc', '0ce8e67b-8ae3-4c5c-9759-b5e705dea740', 'Mobile App', NULL, NULL, 5, '2026-01-09 21:49:05.6098'), ('26d6eb9b-3b9d-4bb5-b260-1c54c61ec242', '0ce8e67b-8ae3-4c5c-9759-b5e705dea740', 'Software App', NULL, NULL, 6, '2026-01-09 21:49:05.6098'), ('c01a9cb8-a05f-4f06-8e84-222665e4bca9', '0ce8e67b-8ae3-4c5c-9759-b5e705dea740', 'Concept Web Creator', NULL, NULL, 7, '2026-01-09 21:49:05.6098'), ('f5a4fdda-14a3-4ae3-9b43-f4bb1425059a', '0ce8e67b-8ae3-4c5c-9759-b5e705dea740', 'Web Designer', NULL, NULL, 8, '2026-01-09 21:49:05.6098'), ('caf1a0db-9285-4709-8dc0-13e47c236ffe', '0ce8e67b-8ae3-4c5c-9759-b5e705dea740', 'Quality Assurance Tester', NULL, NULL, 9, '2026-01-09 21:49:05.6098');
COMMIT;

-- ----------------------------
-- Table structure for timeline
-- ----------------------------
DROP TABLE IF EXISTS "timeline";
CREATE TABLE "timeline" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "title" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "organization" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "period" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "display_order" int4 DEFAULT 0,
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;

-- ----------------------------
-- Records of timeline
-- ----------------------------
BEGIN;
INSERT INTO "timeline" ("id", "type", "title", "organization", "period", "description", "display_order", "created_at") VALUES ('0ed50d43-1688-4045-803d-da67e978b3c2', 'Work', 'Web Developer / Web Designer', 'ITBS Corporation', '2024', 'Lead front-end development with Vue.js and Quasar Framework. Designed and implemented responsive, accessible web applications and optimized performance across projects.', 1, '2026-01-09 21:49:05.657411'), ('0ca5612f-5d09-4f10-8089-bbd919a32e89', 'Work', 'Student Intern', 'Kaizenaire Pte. Ltd.', '2023', 'Gained valuable experience in web development through hands-on training and project-based learning. Collaborated with senior developers on real-world applications.', 2, '2026-01-09 21:49:05.657411'), ('9db2f738-f597-4bc4-af06-fbce8020dcf3', 'Education', 'Bachelor of Science in Computer Science', 'Tarlac State University', '2020-2024', 'Completed comprehensive studies in Computer Science with focus on software development, database management, and system design.', 3, '2026-01-09 21:49:05.657411'), ('96571b1f-b41e-4505-9642-6a5b5e65957e', 'Work', 'Office Assistant', 'Registry of Deeds', '2020', 'Assisted in office administration and document management. Developed organizational skills and attention to detail in a professional environment.', 4, '2026-01-09 21:49:05.657411'), ('cac388d1-0817-4a4b-bd4b-2d672f8656d1', 'Education', 'Senior High School - TVL (ICT)', 'AMA Computer College', '2018-2020', 'Specialized in Information and Communication Technology track with focus on technical and vocational learning.', 5, '2026-01-09 21:49:05.657411'), ('08ec5b56-95ae-4e09-b7e8-6a5860473601', 'Work', 'Office Assistant - SPES', 'Tarlac Provincial Capitol', '2017', 'Participated in the Special Program for Employment of Students (SPES). Gained early professional experience in a government office setting.', 6, '2026-01-09 21:49:05.657411');
COMMIT;

-- ----------------------------
-- Function structure for update_updated_at_column
-- ----------------------------
DROP FUNCTION IF EXISTS "update_updated_at_column"();
CREATE OR REPLACE FUNCTION "update_updated_at_column"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for uuid_generate_v1
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_generate_v1"();
CREATE OR REPLACE FUNCTION "uuid_generate_v1"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v1'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_generate_v1mc
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_generate_v1mc"();
CREATE OR REPLACE FUNCTION "uuid_generate_v1mc"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v1mc'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_generate_v3
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_generate_v3"("namespace" uuid, "name" text);
CREATE OR REPLACE FUNCTION "uuid_generate_v3"("namespace" uuid, "name" text)
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v3'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_generate_v4
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_generate_v4"();
CREATE OR REPLACE FUNCTION "uuid_generate_v4"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v4'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_generate_v5
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_generate_v5"("namespace" uuid, "name" text);
CREATE OR REPLACE FUNCTION "uuid_generate_v5"("namespace" uuid, "name" text)
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v5'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_nil
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_nil"();
CREATE OR REPLACE FUNCTION "uuid_nil"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_nil'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_ns_dns
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_ns_dns"();
CREATE OR REPLACE FUNCTION "uuid_ns_dns"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_ns_dns'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_ns_oid
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_ns_oid"();
CREATE OR REPLACE FUNCTION "uuid_ns_oid"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_ns_oid'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_ns_url
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_ns_url"();
CREATE OR REPLACE FUNCTION "uuid_ns_url"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_ns_url'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_ns_x500
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_ns_x500"();
CREATE OR REPLACE FUNCTION "uuid_ns_x500"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_ns_x500'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Indexes structure for table education
-- ----------------------------
CREATE INDEX "idx_education_display_order" ON "education" USING btree (
  "display_order" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table education
-- ----------------------------
ALTER TABLE "education" ADD CONSTRAINT "education_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table experience
-- ----------------------------
CREATE INDEX "idx_experience_display_order" ON "experience" USING btree (
  "display_order" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_experience_type" ON "experience" USING btree (
  "type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table experience
-- ----------------------------
ALTER TABLE "experience" ADD CONSTRAINT "experience_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table portfolio_config
-- ----------------------------
CREATE TRIGGER "update_portfolio_config_updated_at" BEFORE UPDATE ON "portfolio_config"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_at_column"();

-- ----------------------------
-- Uniques structure for table portfolio_config
-- ----------------------------
ALTER TABLE "portfolio_config" ADD CONSTRAINT "portfolio_config_key_key" UNIQUE ("key");

-- ----------------------------
-- Primary Key structure for table portfolio_config
-- ----------------------------
ALTER TABLE "portfolio_config" ADD CONSTRAINT "portfolio_config_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table project_images
-- ----------------------------
CREATE INDEX "idx_project_images_primary" ON "project_images" USING btree (
  "is_primary" "pg_catalog"."bool_ops" ASC NULLS LAST
);
CREATE INDEX "idx_project_images_project_id" ON "project_images" USING btree (
  "project_id" "pg_catalog"."uuid_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table project_images
-- ----------------------------
ALTER TABLE "project_images" ADD CONSTRAINT "project_images_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table projects
-- ----------------------------
CREATE INDEX "idx_projects_category" ON "projects" USING btree (
  "category" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_projects_year" ON "projects" USING btree (
  "year" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table projects
-- ----------------------------
CREATE TRIGGER "update_projects_updated_at" BEFORE UPDATE ON "projects"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_updated_at_column"();

-- ----------------------------
-- Primary Key structure for table projects
-- ----------------------------
ALTER TABLE "projects" ADD CONSTRAINT "projects_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table skill_categories
-- ----------------------------
ALTER TABLE "skill_categories" ADD CONSTRAINT "skill_categories_name_key" UNIQUE ("name");

-- ----------------------------
-- Primary Key structure for table skill_categories
-- ----------------------------
ALTER TABLE "skill_categories" ADD CONSTRAINT "skill_categories_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table skills
-- ----------------------------
CREATE INDEX "idx_skills_category_id" ON "skills" USING btree (
  "category_id" "pg_catalog"."uuid_ops" ASC NULLS LAST
);
CREATE INDEX "idx_skills_display_order" ON "skills" USING btree (
  "display_order" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table skills
-- ----------------------------
ALTER TABLE "skills" ADD CONSTRAINT "skills_level_check" CHECK (level >= 0 AND level <= 100);

-- ----------------------------
-- Primary Key structure for table skills
-- ----------------------------
ALTER TABLE "skills" ADD CONSTRAINT "skills_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table timeline
-- ----------------------------
CREATE INDEX "idx_timeline_display_order" ON "timeline" USING btree (
  "display_order" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_timeline_type" ON "timeline" USING btree (
  "type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table timeline
-- ----------------------------
ALTER TABLE "timeline" ADD CONSTRAINT "timeline_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table project_images
-- ----------------------------
ALTER TABLE "project_images" ADD CONSTRAINT "project_images_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "projects" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table skills
-- ----------------------------
ALTER TABLE "skills" ADD CONSTRAINT "skills_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "skill_categories" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
