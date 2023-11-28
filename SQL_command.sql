------ SETUP ------
ALTER TABLE users
DISABLE TRIGGER trigger_check_password_length;

------ INSERT ------

INSERT INTO users VALUES
('9876543211','Fishstop','password','6498305768888',
'Moon@gmail.com','Anfield Road, Liverpool, L4 0TH',
'Fishstop',null,'M',40,'Master');

INSERT INTO provider VALUES ('9876543211');

INSERT INTO provider VALUES ('9876543211');
-- duplicate key value violates unique constraint "provider_pkey"
-- DETAIL:  Key (provider_id)=(9876543211) already exists.

INSERT INTO user_hobby VALUES (0123456789,'เตะบอล, ต่อยมวย');
-- ERROR:  Key (user_id)=(123456789) is not present in table "users".
-- insert or update on table "user_hobby" violates foreign key constraint "user_hobby_user_id_fkey".


------ DELETE ------

DELETE FROM users WHERE user_id = '9876543211';
-- ERROR:  Key (user_id)=(9876543211) is still referenced from table "provider".
-- update or delete on table "users" violates foreign key constraint "provider_provider_id_fkey" 
-- on table "provider".

DELETE FROM provider WHERE provider_id ='9876543211';


------ UPDATE ------

UPDATE users SET password = 'a123' WHERE user_id = '9876543211';
-- ERROR:  new row for relation "users" violates check constraint "users_password_check"
-- DETAIL:  Failing row contains (9876543211, Fishstop, a123, 6498305768888, 
-- Moon@gmail.com, Anfield Road, Liverpool, L4 0TH, Fishstop, null, M, 40, Master).

UPDATE users SET password = 'I_Love_ManU_Forever' WHERE user_id = '9876543211';


------ CLEAR ------
DELETE FROM users WHERE user_id = '9876543211';

ALTER TABLE users
ENABLE TRIGGER trigger_check_password_length;