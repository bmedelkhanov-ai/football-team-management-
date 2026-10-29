
from flask import Flask, jsonify, request, send_file
import sqlite3
from pathlib import Path

app = Flask(__name__)
DB = Path(__file__).resolve().parent / "9football.db"


def connect():
    conn = sqlite3.connect(DB)
    conn.row_factory = sqlite3.Row
    return conn


def init_db():
    with connect() as conn:
        conn.execute("""
            CREATE TABLE IF NOT EXISTS teams (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                coach TEXT NOT NULL
            )
        """)

        count = conn.execute(
            "SELECT COUNT(*) FROM teams"
        ).fetchone()[0]

        if count == 0:
            conn.executemany(
                "INSERT INTO teams (name, coach) VALUES (?, ?)",
                [
                    ("Қайрат", "Рафаэль Уразбахтин"),
                    ("Астана", "Жаттықтырушы"),
                    ("Ақтөбе", "Жаттықтырушы")
                ]
            )


@app.route("/")
def home():
    return send_file("9index.html")


@app.route("/api/teams", methods=["GET"])
def get_teams():
    with connect() as conn:
        rows = conn.execute(
            "SELECT * FROM teams ORDER BY id"
        ).fetchall()

    return jsonify([dict(row) for row in rows])


@app.route("/api/teams", methods=["POST"])
def add_team():
    data = request.get_json(silent=True) or {}
    name = str(data.get("name") or "").strip()
    coach = str(data.get("coach") or "").strip()

    if not name or not coach:
        return jsonify({"error": "Барлық өрісті толтыр!"}), 400

    with connect() as conn:
        cursor = conn.execute(
            "INSERT INTO teams (name, coach) VALUES (?, ?)",
            (name, coach)
        )
        team_id = cursor.lastrowid

    return jsonify({
        "id": team_id,
        "name": name,
        "coach": coach
    }), 201


init_db()

if __name__ == "__main__":
    app.run(port=5000, debug=True)
