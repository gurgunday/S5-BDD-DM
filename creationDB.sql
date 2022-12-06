DROP DATABASE IF EXISTS gmsflix;

CREATE DATABASE gmsflix;

USE gmsflix;

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE review';
EXCEPTION
 WHEN OTHERS THEN
	IF SQLCODE != -942 THEN
	RAISE;
	END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE watch';
EXCEPTION
 WHEN OTHERS THEN
	IF SQLCODE != -942 THEN
	RAISE;
	END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE play_in';
EXCEPTION
 WHEN OTHERS THEN
	IF SQLCODE != -942 THEN
	RAISE;
	END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE direct';
EXCEPTION
 WHEN OTHERS THEN
	IF SQLCODE != -942 THEN
	RAISE;
	END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE produce';
EXCEPTION
 WHEN OTHERS THEN
	IF SQLCODE != -942 THEN
	RAISE;
	END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE content';
EXCEPTION
 WHEN OTHERS THEN
	IF SQLCODE != -942 THEN
	RAISE;
	END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE producer';
EXCEPTION
 WHEN OTHERS THEN
	IF SQLCODE != -942 THEN
	RAISE;
	END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE director';
EXCEPTION
 WHEN OTHERS THEN
	IF SQLCODE != -942 THEN
	RAISE;
	END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE actor';
EXCEPTION
 WHEN OTHERS THEN
	IF SQLCODE != -942 THEN
	RAISE;
	END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE member';
EXCEPTION
 WHEN OTHERS THEN
	IF SQLCODE != -942 THEN
	RAISE;
	END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE person';
EXCEPTION
 WHEN OTHERS THEN
	IF SQLCODE != -942 THEN
	RAISE;
	END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE premium_account';
EXCEPTION
 WHEN OTHERS THEN
	IF SQLCODE != -942 THEN
	RAISE;
	END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE free_account';
EXCEPTION
 WHEN OTHERS THEN
	IF SQLCODE != -942 THEN
	RAISE;
	END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE account';
EXCEPTION
 WHEN OTHERS THEN
	IF SQLCODE != -942 THEN
	RAISE;
	END IF;
END;
/

-------------------------------------

CREATE TABLE account (
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    CONSTRAINT pk_account PRIMARY KEY(email)
);

CREATE TABLE free_account (
    email VARCHAR(255) NOT NULL,
    prefered_ad_category VARCHAR(255),
    CONSTRAINT fk_account FOREIGN KEY(email) REFERENCES account(email),
    CONSTRAINT pk_free_account PRIMARY KEY(email)
);

CREATE TABLE premium_account (
    email VARCHAR(255) NOT NULL,
    premium_end_date DATE NOT NULL,
    billing_interval VARCHAR(255) NOT NULL,
    CONSTRAINT fk_account FOREIGN KEY(email) REFERENCES account(email),
    CONSTRAINT pk_premium_account PRIMARY KEY(email),
    CONSTRAINT billing_interval_type CHECK (billing_interval IN ('MONTHLY', 'YEARLY'))
);

CREATE TABLE person (
    id INT NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    CONSTRAINT pk_person PRIMARY KEY(id)
);

CREATE TABLE member (
    id INT NOT NULL,
    email VARCHAR(255) NOT NULL,
    last_login TIMESTAMP,
    CONSTRAINT fkA_member FOREIGN KEY(email) REFERENCES account(email),
    CONSTRAINT fkP_member FOREIGN KEY(id) REFERENCES person(id),
    CONSTRAINT pk_member PRIMARY KEY(id)
);

CREATE TABLE actor (
    id INT NOT NULL,
    ethnicity VARCHAR(255),
    CONSTRAINT fk_actor FOREIGN KEY(id) REFERENCES person(id),
    CONSTRAINT pk_actor PRIMARY KEY(id)
);

CREATE TABLE director (
    id INT NOT NULL,
    CONSTRAINT fk_director FOREIGN KEY(id) REFERENCES person(id),
    CONSTRAINT pk_director PRIMARY KEY(id)
);

CREATE TABLE producer (
    id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    CONSTRAINT pk_producer PRIMARY KEY(id)
);

CREATE TABLE content (
    id INT NOT NULL,
    type VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    CONSTRAINT pk_content PRIMARY KEY(id)
);

CREATE TABLE produce (
    idP INT NOT NULL,
    idC INT NOT NULL,
    CONSTRAINT fkP_produce FOREIGN KEY(idP) REFERENCES producer(id),
    CONSTRAINT fkC_produce FOREIGN KEY(idC) REFERENCES content(id),
    CONSTRAINT pk_produce PRIMARY KEY(idP, idC)
);

CREATE TABLE direct (
    idD INT NOT NULL,
    idC INT NOT NULL,
    CONSTRAINT fkD_direct FOREIGN KEY(idD) REFERENCES director(id),
    CONSTRAINT fkC_direct FOREIGN KEY(idC) REFERENCES content(id),
    CONSTRAINT pk_direct PRIMARY KEY(idD, idC)
);

CREATE TABLE play_in (
    idA INT NOT NULL,
    idC INT NOT NULL,
    CONSTRAINT fkA_play_in FOREIGN KEY(idA) REFERENCES actor(id),
    CONSTRAINT fkC_play_in FOREIGN KEY(idC) REFERENCES content(id),
    CONSTRAINT pk_play_in PRIMARY KEY(idA, idC)
);

CREATE TABLE watch (
    idM INT NOT NULL,
    idC INT NOT NULL,
    dateW TIMESTAMP NOT NULL,
    CONSTRAINT fkM_watch FOREIGN KEY(idM) REFERENCES member(id),
    CONSTRAINT fkC_watch FOREIGN KEY(idC) REFERENCES content(id),
    CONSTRAINT pk_watch PRIMARY KEY(idM, idC, dateW)
);

CREATE TABLE review (
    idM INT NOT NULL,
    idC INT NOT NULL,
    rating INT NOT NULL,
    commentR VARCHAR(255),
    CONSTRAINT fkM_review FOREIGN KEY(idM) REFERENCES member(id),
    CONSTRAINT fkC_review FOREIGN KEY(idC) REFERENCES content(id),
    CONSTRAINT pk_review PRIMARY KEY(idM, idC),
    CONSTRAINT rating_range CHECK (rating >= 0 AND rating <= 10)
);
