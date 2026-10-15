
PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS Teams (
    TeamID INTEGER PRIMARY KEY AUTOINCREMENT,
    TeamName TEXT NOT NULL,
    CoachName TEXT
);

CREATE TABLE IF NOT EXISTS Players (
    PlayerID INTEGER PRIMARY KEY AUTOINCREMENT,
    FullName TEXT NOT NULL,
    Age INTEGER,
    Position TEXT,
    TeamID INTEGER,
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
);

CREATE TABLE IF NOT EXISTS Trainings (
    TrainingID INTEGER PRIMARY KEY AUTOINCREMENT,
    TeamID INTEGER,
    TrainingDate TEXT NOT NULL,
    Location TEXT,
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
);

INSERT INTO Teams (TeamName, CoachName)
VALUES ('Қайрат', 'Жаттықтырушы');

INSERT INTO Players (FullName, Age, Position, TeamID)
VALUES ('Бағыжан', 19, 'Шабуылшы', 1);

INSERT INTO Trainings (TeamID, TrainingDate, Location)
VALUES (1, '2026-10-15', 'Алматы');

.headers on
.mode column

SELECT * FROM Teams;
SELECT * FROM Players;
SELECT * FROM Trainings;
