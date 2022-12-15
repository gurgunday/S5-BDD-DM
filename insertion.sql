------------------------------------------;
 -----insertion person (members)-----------;
------------------------------------------;

INSERT INTO person VALUES (1,'labyedh', 'slimen'); 
INSERT INTO person VALUES (2,'lkahla', 'naeema');
INSERT INTO person VALUES (3,'labyedh', 'sboui'); 
INSERT INTO person VALUES (4,'daoud', 'kalthoum'); 
INSERT INTO person VALUES (5,'labyedh', 'ameni'); 

 ------------------------------------------;
 -----     insertion account   ------------;
 ------------------------------------------;

INSERT INTO account VALUES ('premiercompte@gmail.com','mdp1'); 
INSERT INTO account VALUES ('deuxièmecompte@gmail.com','mdp2'); 
INSERT INTO account VALUES ('troisièmecompte@live.com','mdp3'); 

 ------------------------------------------;
 ----- insertion free_account   -----------;
 ------------------------------------------;

INSERT INTO free_account VALUES ('premiercompte@gmail.com','house tools'); 

 ------------------------------------------;
 ----- insertion premium_account-----------;
 ------------------------------------------;

INSERT INTO premium_account VALUES ('deuxièmecompte@gmail.com','2022-05-09', 'MONTHLY'); 
INSERT INTO premium_account VALUES ('troisièmecompte@live.com','2022-06-02', 'YEARLY');

 ------------------------------------------;
 -------- insertion member ---------------;
 ------------------------------------------; 

INSERT INTO member VALUES (1, 'premiercompte@gmail.com','2022-07-02 01:23:56'); 
INSERT INTO member VALUES (3, 'premiercompte@gmail.com','2022-08-01 01:23:56'); 
INSERT INTO member VALUES (5, 'premiercompte@gmail.com','2022-09-03 01:23:56'); 
INSERT INTO member VALUES (2, 'deuxièmecompte@gmail.com','2022-11-04 01:23:56'); 
INSERT INTO member VALUES (4, 'troisièmecompte@live.com','2022-11-05 01:23:56'); 

 ------------------------------------------;
 -----insertion person (actors)------------;
 ------------------------------------------; 

INSERT INTO person VALUES (6,'deniz', 'burak'); 
INSERT INTO person VALUES (7,'khalil', 'maxim');
INSERT INTO person VALUES (8,'yildirim', 'murat'); 
INSERT INTO person VALUES (9,'zarrouk', 'dorra'); 
INSERT INTO person VALUES (10,'feray', 'leyla'); 

 ------------------------------------------;
 -----insertion person (directors)---------;
 ------------------------------------------; 

INSERT INTO person VALUES (11,'ali', 'hatem'); 
INSERT INTO person VALUES (12,'yazji', 'liwaa');
INSERT INTO person VALUES (13,'derki', 'talal'); 
INSERT INTO person VALUES (14,'lahham', 'duraid'); 
INSERT INTO person VALUES (15,'amiralay', 'omar'); 

 ------------------------------------------;
 -------- insertion actor   ---------------;
 ------------------------------------------; 

INSERT INTO actor VALUES (6,'turkish'); 
INSERT INTO actor VALUES (7,'syrian');
INSERT INTO actor VALUES (8,'turkish'); 
INSERT INTO actor VALUES (9,'tunisian'); 
INSERT INTO actor VALUES (10,'turkish'); 

 ------------------------------------------;
 -------- insertion director --------------;
 ------------------------------------------; 

INSERT INTO director VALUES (11); 
INSERT INTO director VALUES (12);
INSERT INTO director VALUES (13); 
INSERT INTO director VALUES (14); 
INSERT INTO director VALUES (15); 

 ------------------------------------------;
 -------- insertion producer --------------;
 ------------------------------------------; 

INSERT INTO producer VALUES (1, 'gms'); 
INSERT INTO producer VALUES (2, 'pixar');
INSERT INTO producer VALUES (3, 'universal'); 
INSERT INTO producer VALUES (4, 'bbc'); 
INSERT INTO producer VALUES (5, 'sony'); 


 ------------------------------------------;
 -------- insertion content  --------------;
 ------------------------------------------; 

INSERT INTO content VALUES (1,'movie','romantic', 'love story' , ' a girl and a boy fall in love, will destiny allow them to be together?'); 

INSERT INTO content VALUES (2,'movie','comedy', 'welcome to the city' , ' when a person decides to live in a new country, the live a wholesome experience, this movie is about sunnys fun experience when she decided to leave everything and discover the world'); 

INSERT INTO content VALUES (3,'series','horror', 'vampire in town' , 'vampires are usually seen in romantic movies, but its not the case here when the a town is invaded by them and only a group of friends are left alive having to survive'); 

INSERT INTO content VALUES (4,'movie','action', 'warriors in Narnia' , 'a movie full of action and entertainment'); 
 
 ------------------------------------------;
 -------- insertion produce  --------------;
 ------------------------------------------; 

INSERT INTO produce VALUES (1,1); 
INSERT INTO produce VALUES (4,2);
INSERT INTO produce VALUES (3,1);  

 ------------------------------------------;
 -------- insertion direct   --------------;
 ------------------------------------------;

INSERT INTO direct VALUES (11,1); 
INSERT INTO direct VALUES (12,1); 
INSERT INTO direct VALUES (13,2);
INSERT INTO direct VALUES (14,3);  

 ------------------------------------------;
 -------- insertion play_in  --------------;
 ------------------------------------------;

-- acteur 7 ne participe dans aucun film

INSERT INTO play_in VALUES (6,1); 
INSERT INTO play_in VALUES (8,1);
INSERT INTO play_in VALUES (9,1);
INSERT INTO play_in VALUES (10,1);

INSERT INTO play_in VALUES (6,2);
INSERT INTO play_in VALUES (9,2);
INSERT INTO play_in VALUES (10,2);


INSERT INTO play_in VALUES (6,3);
INSERT INTO play_in VALUES (8,3);
INSERT INTO play_in VALUES (9,3);

 ------------------------------------------;
 -------- insertion watch -----------------;
 ------------------------------------------;

INSERT INTO watch VALUES (1,3,'2022-05-05 01:23:56');
INSERT INTO watch VALUES (2,3,'2022-05-05 01:33:56');
INSERT INTO watch VALUES (5,3,'2022-05-05 01:43:56');

INSERT INTO watch VALUES (3,1,'2022-11-09 01:23:56');
INSERT INTO watch VALUES (4,2,'2022-11-08 01:23:56');

 ------------------------------------------;
 -------- insertion review ----------------;
 ------------------------------------------;

INSERT INTO review VALUES (1,3,10,'very scary, couldnt go to the bathroom at night');

INSERT INTO review VALUES (5,3,9,'surprised by the quality of this movie');

INSERT INTO review VALUES (2,3,0,'I would give it less than 0 if I could, even my cat wont get scared watching this movie' );

INSERT INTO review VALUES (4,1,5,'nice overall, nothing new though' );
