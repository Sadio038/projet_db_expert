import sqlite3
import os

# On utilise le dossier actuel pour éviter les erreurs de chemin absolu
dossier_actuel = os.getcwd()
db_path = 'blog.sqlite'
sql_path = 'blog.sql' # Vérifiez bien si c'est .sql ou .SQL

try:
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # Lecture et exécution du script SQL
    with open(sql_path, 'r', encoding='utf-8') as f:
        cursor.executescript(f.read())

    conn.commit()
    print("✅ Base de données créée et initialisée.")

    # Vérification des tables
    print("\n=== TABLES CRÉÉES ===")
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
    for row in cursor.fetchall():
        print(f"  - {row[0]}")

    conn.close()
except FileNotFoundError:
    print(f"❌ Erreur : Le fichier {sql_path} est introuvable dans {dossier_actuel}")
except Exception as e:
    print(f"❌ Une erreur est survenue : {e}")
