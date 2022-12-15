SET GLOBAL log_bin_trust_function_creators = 1;

CREATE TABLE account (
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    CONSTRAINT pk_account PRIMARY KEY(email)
);

CREATE TABLE free_account (
    email VARCHAR(255) NOT NULL,
    prefered_ad_category VARCHAR(255),
    CONSTRAINT fk_free_account FOREIGN KEY(email) REFERENCES account(email),
    CONSTRAINT pk_free_account PRIMARY KEY(email)
);

CREATE TABLE premium_account (
    email VARCHAR(255) NOT NULL,
    premium_end_date DATE NOT NULL,
    billing_interval VARCHAR(255) NOT NULL,
    CONSTRAINT fk_premium_account FOREIGN KEY(email) REFERENCES account(email),
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

--- TRIGGERS PROCS AND FUNCTIONS ---

DELIMITER //

CREATE TRIGGER check_account_free
BEFORE INSERT ON premium_account
FOR EACH ROW
BEGIN
    DECLARE is_free BOOLEAN;

    SELECT COUNT(*) INTO is_free
    FROM free_account
    WHERE email = NEW.email;

    IF is_free THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The account cannot be free and paid at the same time.';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER check_account_premium
BEFORE INSERT ON free_account
FOR EACH ROW
BEGIN
    DECLARE is_premium BOOLEAN;

    SELECT COUNT(*) INTO is_premium
    FROM premium_account
    WHERE email = NEW.email;

    IF is_premium THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The account cannot be free and paid at the same time.';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER check_num_members
BEFORE INSERT ON member
FOR EACH ROW
BEGIN
    DECLARE num_members INT;

    SELECT COUNT(*) INTO num_members
    FROM member
    WHERE email = NEW.email;

    IF num_members >= 4 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The account that this member will be connected to already has 4 members.';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE director_actor(id INT)
BEGIN
  DECLARE does_belong BOOLEAN;
  
  SELECT COUNT(*) INTO does_belong
  FROM actor
  WHERE id = id;
  
  IF does_belong THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Person is already an actor.';
  END IF;

  SELECT COUNT(*) INTO does_belong
  FROM director
  WHERE id = id;

  IF does_belong THEN
  SIGNAL SQLSTATE '45000'
  SET MESSAGE_TEXT = 'Person is already a director.';
  END IF;

END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER check_director_is_actor
BEFORE INSERT ON director
FOR EACH ROW
BEGIN
  CALL director_actor(NEW.id);
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER check_actor_is_director
BEFORE INSERT ON actor
FOR EACH ROW
BEGIN
  CALL director_actor(NEW.id);
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION has_watched(idM INT)
RETURNS BOOLEAN
BEGIN
  DECLARE has_watched BOOLEAN;
  
  SELECT COUNT(*) INTO has_watched
  FROM watch
  WHERE idM = idM;
  
  RETURN has_watched;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER check_watch_before_insert
BEFORE INSERT ON review
FOR EACH ROW
BEGIN
  IF NOT has_watched(NEW.idM) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Member has not watched the content';
  END IF;
END //

DELIMITER ;
