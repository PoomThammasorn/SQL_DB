---------------- Stored Procedures ----------------

-- Change password
INSERT INTO users VALUES
('9876543211','Fishstop','password','6498305768888',
'Moon@gmail.com','Anfield Road, Liverpool, L4 0TH',
'Fishstop',null,'M',40,'Master');

CALL change_password( '9876543211' , 'new_password' );

SELECT * FROM users WHERE user_id = '9876543211';

-- Insert activity filter
INSERT INTO provider VALUES ('9876543211');

CALL add_activity_filter('9876543211','Chula Uni','Date');
CALL add_activity_filter('9876543211','Dream World','Study');

SELECT * FROM activity_filter WHERE user_id = '9876543211';


---------------- Stored Functions ----------------

-- Function 1: get_provider_avg_rating
SELECT  provider_id,
(get_provider_avg_rating(provider_id)).avg_rating,
(get_provider_avg_rating(provider_id)).rating
FROM provider
WHERE provider_id = '9876543211';

-- Function 2: is_provider_reserved
SELECT provider_id,'2023-11-16 12:00:00' AS start_time , '2023-11-16 13:00:00' AS end_time,
is_provider_reserved(provider_id, '2023-11-16 12:00:00', '2023-11-16 13:00:00')
FROM provider WHERE provider_id = '9876543211'
UNION ALL
SELECT provider_id, '2023-11-16 10:30:00' AS start_time, '2023-11-16 10:40:00' AS end_time,
is_provider_reserved(provider_id, '2023-11-16 10:30:00', '2023-11-16 10:40:00')
FROM provider WHERE provider_id = '9876543211'


---------------- Trigger ----------------

-- Trigger 1: trigger_check_password_length
INSERT INTO users VALUES
('9999999999','Fishstop','passwo','6498305768888',
'Moon@gmail.com','Anfield Road','Fishstop',null,'M',40,'Master');

-- Trigger 2: trigger_update_date_time
INSERT INTO message (sender, chatroom_id, text) VALUES ('P010', 'CHAT001', 'SIUUUUUU!!!');