CREATE TABLE IF NOT EXISTS users (
    id VARCHAR(60) DEFAULT RANDOM_UUID() PRIMARY KEY,
    name VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    userpassword VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS tasks (
    id VARCHAR(60) DEFAULT RANDOM_UUID() PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    task_hour TIME NOT NULL,
    task_day DATE,
    user_id VARCHAR(60),
    FOREIGN KEY(user_id) REFERENCES users(id)
);