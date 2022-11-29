DROP DATABASE IF EXISTS gmsflix;

CREATE DATABASE gmsflix;

USE gmsflix;


CREATE TABLE account (
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    CONSTRAINT pk_account PRIMARY KEY(email)
);

CREATE TABLE free_account (
    id VARCHAR(255) NOT NULL,
    prefered_ad_category VARCHAR(255),
    CONSTRAINT fk_account FOREIGN KEY(id) REFERENCES account(email),
    CONSTRAINT pk_premium_account PRIMARY KEY(id)
);

CREATE TABLE premium_account (
    id VARCHAR(255) NOT NULL,
    premium_end_date DATETIME,
    billing_interval VARCHAR(255),
    CONSTRAINT fk_account FOREIGN KEY(id) REFERENCES account(email),
    CONSTRAINT pk_premium_account PRIMARY KEY(id),
    CONSTRAINT billing_interval_type CHECK (billing_interval IN ('MONTHLY', 'YEARLY'))
);

CREATE TABLE person (
    id BIGINT NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    CONSTRAINT pk_person PRIMARY KEY(id)
);

CREATE TABLE member (
    id BIGINT NOT NULL,
    email VARCHAR(255) NOT NULL,
    last_login DATETIME,
    CONSTRAINT fkP_member FOREIGN KEY(id) REFERENCES person(id),
    CONSTRAINT fkA_member FOREIGN KEY(email) REFERENCES account(email),
    CONSTRAINT pk_member PRIMARY KEY(id, email)
);

CREATE TABLE actor (
    id BIGINT NOT NULL,
    ethnicity VARCHAR(255),
    CONSTRAINT fk_actor FOREIGN KEY(id) REFERENCES person(id),
    CONSTRAINT pk_actor PRIMARY KEY(id)
);

CREATE TABLE director (
    id BIGINT NOT NULL,
    CONSTRAINT fk_director FOREIGN KEY(id) REFERENCES person(id),
    CONSTRAINT pk_director PRIMARY KEY(id)
);

CREATE TABLE producer (
    id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    CONSTRAINT pk_producer PRIMARY KEY(id)
);

CREATE TABLE content (
    id BIGINT NOT NULL,
    type VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    CONSTRAINT pk_content PRIMARY KEY(id)
);

-- TODO: ADD PRIMARY KEYS

CREATE TABLE produce (
    idP BIGINT NOT NULL,
    idC BIGINT NOT NULL,
    CONSTRAINT fkP_produce FOREIGN KEY(idP) REFERENCES producer(id),
    CONSTRAINT fkC_produce FOREIGN KEY(idC) REFERENCES content(id)
);

CREATE TABLE direct (
    idD BIGINT NOT NULL,
    idC BIGINT NOT NULL,
    CONSTRAINT fkD_direct FOREIGN KEY(idD) REFERENCES director(id),
    CONSTRAINT fkC_direct FOREIGN KEY(idC) REFERENCES content(id)
);

CREATE TABLE play_in (
    idA BIGINT NOT NULL,
    idC BIGINT NOT NULL,
    CONSTRAINT fkA_play_in FOREIGN KEY(idA) REFERENCES actor(id),
    CONSTRAINT fkC_play_in FOREIGN KEY(idC) REFERENCES content(id)
);

CREATE TABLE watch (
    idM BIGINT NOT NULL,
    idC BIGINT NOT NULL,
    date DATETIME NOT NULL,
    CONSTRAINT fkM_watch FOREIGN KEY(idM) REFERENCES member(id),
    CONSTRAINT fkC_watch FOREIGN KEY(idC) REFERENCES content(id)
);

CREATE TABLE review (
    idM BIGINT NOT NULL,
    idC BIGINT NOT NULL,
    rating INT NOT NULL,
    comment TEXT,
    CONSTRAINT fkM_review FOREIGN KEY(idM) REFERENCES member(id),
    CONSTRAINT fkC_review FOREIGN KEY(idC) REFERENCES content(id),
    CONSTRAINT rating_range CHECK (rating >= 0 AND rating <= 10)
);
