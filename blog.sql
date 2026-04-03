-- ============================================================
-- BDD BLOG - Création des tables
-- ============================================================

-- TABLE users
-- Chaque user a un id (auto-incrémenté) et un nom
CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
);

-- TABLE articles
-- Chaque article appartient à un user via user_id (clé étrangère)
CREATE TABLE IF NOT EXISTS articles (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- TABLE categories
-- Chaque catégorie a un titre
CREATE TABLE IF NOT EXISTS categories (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL
);

-- TABLE tags
-- Chaque tag a un titre et une couleur
CREATE TABLE IF NOT EXISTS tags (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  color TEXT NOT NULL
);

-- TABLE de JOINTURE articles_categories
-- Relie articles et categories (relation many-to-many)
-- Un article peut avoir plusieurs catégories, une catégorie peut avoir plusieurs articles
CREATE TABLE IF NOT EXISTS articles_categories (
  article_id INTEGER NOT NULL,
  category_id INTEGER NOT NULL,
  FOREIGN KEY (article_id) REFERENCES articles(id),
  FOREIGN KEY (category_id) REFERENCES categories(id),
  PRIMARY KEY (article_id, category_id)
);

-- TABLE de JOINTURE categories_tags
-- Relie categories et tags (relation many-to-many)
-- Une catégorie peut avoir plusieurs tags, un tag peut appartenir à plusieurs catégories
CREATE TABLE IF NOT EXISTS categories_tags (
  category_id INTEGER NOT NULL,
  tag_id INTEGER NOT NULL,
  FOREIGN KEY (category_id) REFERENCES categories(id),
  FOREIGN KEY (tag_id) REFERENCES tags(id),
  PRIMARY KEY (category_id, tag_id)
);

-- ============================================================
-- INSERTION - 1 élément par table principale
-- ============================================================

-- 1 user
INSERT INTO users (name) VALUES ('Sadio');

-- 1 article (créé par le user avec id=1)
INSERT INTO articles (title, user_id) VALUES ('Ma première licorne africaine', 1);

-- 1 catégorie
INSERT INTO categories (title) VALUES ('Tech & Startups');

-- 1 tag
INSERT INTO tags (title, color) VALUES ('Innovation', '#FF6B35');

-- On relie l'article à la catégorie
INSERT OR IGNORE INTO articles_categories (article_id, category_id) VALUES (1, 2);

-- On relie la catégorie au tag
INSERT INTO categories_tags (category_id, tag_id) VALUES (1, 1);