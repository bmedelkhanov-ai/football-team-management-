PRAGMA foreign_keys = ON;

-- 1. Рөлдер
CREATE TABLE IF NOT EXISTS roles (
    role_id INTEGER PRIMARY KEY AUTOINCREMENT,
    role_name TEXT NOT NULL UNIQUE
);

-- 2. Қолданушылар
CREATE TABLE IF NOT EXISTS users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    role_id INTEGER NOT NULL,
    phone TEXT,
    email TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

-- 3. Командалар
CREATE TABLE IF NOT EXISTS teams (
    team_id INTEGER PRIMARY KEY AUTOINCREMENT,
    team_name TEXT NOT NULL,
    coach_id INTEGER,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (coach_id) REFERENCES users(user_id)
);

-- 4. Команда мүшелері
CREATE TABLE IF NOT EXISTS team_members (
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,
    team_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    position TEXT,
    join_date DATE,
    FOREIGN KEY (team_id) REFERENCES teams(team_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 5. Жаттығулар
CREATE TABLE IF NOT EXISTS trainings (
    training_id INTEGER PRIMARY KEY AUTOINCREMENT,
    team_id INTEGER NOT NULL,
    coach_id INTEGER NOT NULL,
    training_date DATE NOT NULL,
    training_time TIME NOT NULL,
    location TEXT,
    description TEXT,
    FOREIGN KEY (team_id) REFERENCES teams(team_id),
    FOREIGN KEY (coach_id) REFERENCES users(user_id)
);

-- 6. Қатысу
CREATE TABLE IF NOT EXISTS training_attendance (
    attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    training_id INTEGER NOT NULL,
    player_id INTEGER NOT NULL,
    status TEXT NOT NULL
      CHECK(status IN ('Қатысты', 'Қатыспады', 'Кешікті')),
    note TEXT,
    FOREIGN KEY (training_id) REFERENCES trainings(training_id),
    FOREIGN KEY (player_id) REFERENCES users(user_id)
);

-- 7. Матчтар
CREATE TABLE IF NOT EXISTS matches (
    match_id INTEGER PRIMARY KEY AUTOINCREMENT,
    team_id INTEGER NOT NULL,
    opponent_name TEXT NOT NULL,
    match_date DATE NOT NULL,
    location TEXT,
    result TEXT,
    goals_scored INTEGER DEFAULT 0,
    goals_conceded INTEGER DEFAULT 0,
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

-- 8. Ойыншылар статистикасы
CREATE TABLE IF NOT EXISTS player_statistics (
    stat_id INTEGER PRIMARY KEY AUTOINCREMENT,
    player_id INTEGER NOT NULL,
    match_id INTEGER,
    goals INTEGER DEFAULT 0,
    assists INTEGER DEFAULT 0,
    yellow_cards INTEGER DEFAULT 0,
    red_cards INTEGER DEFAULT 0,
    minutes_played INTEGER DEFAULT 0,
    FOREIGN KEY (player_id) REFERENCES users(user_id),
    FOREIGN KEY (match_id) REFERENCES matches(match_id)
);

-- 9. Хабарламалар
CREATE TABLE IF NOT EXISTS notifications (
    notification_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    message TEXT NOT NULL,
    is_read INTEGER DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- МӘЛІМЕТТЕРДІ ЕНГІЗУ

-- 1. Рөлдер
INSERT INTO roles VALUES
(1, 'Жаттықтырушы'),
(2, 'Футболшы'),
(3, 'Әкімші');

-- 2. Қолданушылар
-- Құпиясөздер тек оқу мақсатындағы мысалдар
INSERT INTO users
(user_id, full_name, username, password, role_id, phone, email)
VALUES
(1, 'Арман Қасымов', 'arman', 'demo123', 1, '87010000001', 'arman@example.com'),
(2, 'Айбек Нұрланов', 'aibek', 'demo123', 2, '87010000002', 'aibek@example.com'),
(3, 'Данияр Ермеков', 'daniyar', 'demo123', 2, '87010000003', 'daniyar@example.com'),
(4, 'Ерасыл Болат', 'erassyl', 'demo123', 2, '87010000004', 'erassyl@example.com'),
(5, 'Нұрсұлтан Әли', 'nursultan', 'demo123', 2, '87010000005', 'nursultan@example.com'),
(6, 'Мұрат Серік', 'murat', 'demo123', 3, '87010000006', 'murat@example.com');

-- 3. Командалар
INSERT INTO teams (team_id, team_name, coach_id) VALUES
(1, 'Almaty FC', 1),
(2, 'Almaty Junior', 1);

-- 4. Команда мүшелері
INSERT INTO team_members VALUES
(1, 1, 2, 'Шабуылшы', '2026-09-01'),
(2, 1, 3, 'Қорғаушы', '2026-09-01'),
(3, 1, 4, 'Жартылай қорғаушы', '2026-09-02'),
(4, 2, 5, 'Қақпашы', '2026-09-03');

-- 5. Жаттығулар
INSERT INTO trainings VALUES
(1, 1, 1, '2026-10-16', '16:00', 'Орталық стадион', 'Жылдамдық жаттығуы'),
(2, 1, 1, '2026-10-18', '17:00', 'Футбол алаңы', 'Тактикалық жаттығу'),
(3, 2, 1, '2026-10-20', '15:00', 'Жасөспірімдер алаңы', 'Доппен жұмыс');

-- 6. Жаттығуға қатысу
INSERT INTO training_attendance VALUES
(1, 1, 2, 'Қатысты', 'Белсенді қатысты'),
(2, 1, 3, 'Қатыспады', 'Ауырып қалды'),
(3, 1, 4, 'Кешікті', '10 минут кешікті'),
(4, 2, 2, 'Қатысты', 'Жақсы дайындалды'),
(5, 3, 5, 'Қатысты', 'Толық қатысты');

-- 7. Матчтар
INSERT INTO matches VALUES
(1, 1, 'Astana FC', '2026-10-10', 'Алматы', 'Жеңіс', 3, 1),
(2, 1, 'Kairat Junior', '2026-10-12', 'Алматы', 'Тең ойын', 2, 2),
(3, 2, 'Shymkent FC', '2026-10-14', 'Шымкент', 'Жеңіліс', 1, 2);

-- 8. Ойыншы статистикасы
INSERT INTO player_statistics VALUES
(1, 2, 1, 2, 1, 0, 0, 90),
(2, 3, 1, 0, 0, 1, 0, 90),
(3, 4, 1, 1, 1, 0, 0, 85),
(4, 2, 2, 1, 0, 0, 0, 90),
(5, 5, 3, 0, 0, 0, 0, 90);

-- 9. Хабарламалар
INSERT INTO notifications
(notification_id, user_id, message, is_read)
VALUES
(1, 2, 'Ертең сағат 16:00-де жаттығу болады', 0),
(2, 3, 'Жаттығуға қатысуыңызды растаңыз', 0),
(3, 4, 'Команда жиналысы өтеді', 1),
(4, 5, 'Келесі жаттығу 20 қазанда', 0);

-- БАРЛЫҚ КЕСТЕЛЕРДІ ТЕКСЕРУ

SELECT * FROM roles;
SELECT * FROM users;
SELECT * FROM teams;
SELECT * FROM team_members;
SELECT * FROM trainings;
SELECT * FROM training_attendance;
SELECT * FROM matches;
SELECT * FROM player_statistics;
SELECT * FROM notifications;