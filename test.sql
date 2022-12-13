INSERT INTO person VALUES (1, 'hey', 'hey');
INSERT INTO person VALUES (2, 'hey', 'hey');
INSERT INTO person VALUES (3, 'hey', 'hey');
INSERT INTO person VALUES (4, 'hey', 'hey');
INSERT INTO person VALUES (5, 'hey', 'hey');
INSERT INTO account VALUES ('em', 'pass');

INSERT INTO member VALUES (1, 'em', NULL);
INSERT INTO member VALUES (2, 'em', NULL);
INSERT INTO member VALUES (3, 'em', NULL);
INSERT INTO member VALUES (4, 'em', NULL);
-- INSERT INTO member VALUES (5, 'em', NULL); -- ERROR

INSERT INTO free_account VALUES ('em', NULL);
-- INSERT INTO premium_account VALUES ('em', '1000-01-02', 'YEARLY'); -- ERROR

INSERT INTO director VALUES (1);
-- INSERT INTO actor VALUES (1); -- ERROR
