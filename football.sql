
CREATE DATABASE FootballDB;
GO

USE FootballDB;
GO

CREATE TABLE Teams (
    TeamID INT PRIMARY KEY IDENTITY(1,1),
    TeamName NVARCHAR(100) NOT NULL,
    CoachName NVARCHAR(100)
);

CREATE TABLE Players (
    PlayerID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Age INT,
    Position NVARCHAR(50),
    TeamID INT FOREIGN KEY REFERENCES Teams(TeamID)
);

CREATE TABLE Trainings (
    TrainingID INT PRIMARY KEY IDENTITY(1,1),
    TeamID INT FOREIGN KEY REFERENCES Teams(TeamID),
    TrainingDate DATE NOT NULL,
    Location NVARCHAR(100)
);

INSERT INTO Teams (TeamName, CoachName)
VALUES (N'Қайрат', N'Жаттықтырушы');

INSERT INTO Players (FullName, Age, Position, TeamID)
VALUES (N'Бағыжан', 19, N'Шабуылшы', 1);

INSERT INTO Trainings (TeamID, TrainingDate, Location)
VALUES (1, '2026-10-15', N'Алматы');

SELECT * FROM Teams;
SELECT * FROM Players;
SELECT * FROM Trainings;
