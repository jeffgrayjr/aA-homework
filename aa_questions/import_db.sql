CREATE TABLE users (
    id integer PRIMARY KEY
    fname text NOT NULL
    lname text NOT NULL
);

CREATE TABLE questions (
    id integer PRIMARY KEY
    title text
    body text
    associate_author

    FOREIGN KEY(associate_author) REFERENCES users(id)
);

CREATE TABLE question_follows (
    user_id integer NOT NULL
    question_id intger NOT NULL

    FOREIGN KEY user_id REFERENCES users(id)
    FOREIGN KEY question_id REFERENCES questions(id)
);