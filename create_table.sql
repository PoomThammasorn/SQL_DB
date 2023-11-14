CREATE TABLE users (
  user_id VARCHAR(10) PRIMARY KEY ,
  username VARCHAR(16) NOT NULL CHECK (LENGTH(username) >= 4),
  password VARCHAR(255) NOT NULL CHECK (LENGTH(password) >= 8),
  citizen_ID VARCHAR(45) NOT NULL,
  email VARCHAR(255) NOT NULL,
  name VARCHAR (36) NOT NULL,
  address VARCHAR(36) NOT NULL,
  picture VARCHAR(180) DEFAULT NULL,
  gender VARCHAR(255) NOT NULL,
  age INT NOT NULL,
  also_know_as VARCHAR(36) DEFAULT NULL
);

CREATE TABLE user_hobby (
    user_id VARCHAR(10) NOT NULL,
    hobby VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (user_id, hobby),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE customer (
    user_id VARCHAR(10) PRIMARY KEY,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE provider (
    provider_id VARCHAR(10) PRIMARY KEY,
    avg_rating_score NUMERIC(2,1) NOT NULL,
    FOREIGN KEY (provider_id) REFERENCES users(user_id)
);

CREATE TABLE provider_review (
    provider_id VARCHAR(10) PRIMARY KEY,
    review_message VARCHAR(1000) DEFAULT NULL,
    rating_score INT NOT NULL CHECK (rating_score BETWEEN 1 AND 10),
    FOREIGN KEY (provider_id) REFERENCES provider(provider_id)
);


CREATE TABLE appointment (
    appointment_id VARCHAR(10) PRIMARY KEY,
    date_and_time Timestamp without time zone NOT NULL,
    price INT NOT NULL,
    details VARCHAR(180) DEFAULT NULL,
    activity VARCHAR(30) NOT NULL,
    start_time Timestamp without time zone NOT NULL,
    end_time Timestamp without time zone NOT NULL,
    location VARCHAR(30) NOT NULL,
    rating_id VARCHAR(10) NOT NULL UNIQUE,
    transaction_id VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE appointment_rating (
    rating_id VARCHAR(10) PRIMARY KEY,
    review VARCHAR(300) DEFAULT NULL,
    score INT NOT NULL CHECK (score BETWEEN 1 AND 10),
    FOREIGN KEY (rating_id) REFERENCES appointment(rating_id)
);

CREATE TABLE appointment_transaction (
    tansaction_id VARCHAR(8) PRIMARY KEY,
    payment_method VARCHAR(13) NOT NULL,
    amount INT NOT NULL,
    timestamp TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    FOREIGN KEY (tansaction_id) REFERENCES appointment(tansaction_id)
);

CREATE TABLE make_appointment (
    provider_id VARCHAR(10) NOT NULL,
    customer_id VARCHAR(10) NOT NULL,
    appointment_id VARCHAR(10) NOT NULL,
    PRIMARY KEY (provider_id, customer_id, appointment_id),
    FOREIGN KEY (provider_id) REFERENCES provider(provider_id),
    FOREIGN KEY (customer_id) REFERENCES customer(user_id),
    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id)
);

CREATE TABLE filter (
    provider_id VARCHAR(10) NOT NULL,  
    location VARCHAR(30) NOT NULL,
    status BOOLEAN NOT NULL,
    PRIMARY KEY (provider_id, location),
    FOREIGN KEY (provider_id) REFERENCES provider(provider_id)
);

CREATE TABLE activity_filter (
    provider_id VARCHAR(10) NOT NULL,
    location VARCHAR(30) NOT NULL,
    activity_type VARCHAR(30) NOT NULL,
    PRIMARY KEY (provider_id, location, activity_type),
    FOREIGN KEY (provider_id) REFERENCES provider(provider_id)
);

CREATE TABLE search_by (
    provider_id VARCHAR(10) NOT NULL,
    customer_id VARCHAR(10) NOT NULL,
    location ARCHAR(30) NOT NULL,
    PRIMARY KEY (provider_id, customer_id, location),
    FOREIGN KEY (provider_id) REFERENCES provider(provider_id),
    FOREIGN KEY (customer_id) REFERENCES customer(user_id)
);

CREATE TABLE chatroom (
    chatroom_id VARCHAR(10) PRIMARY KEY
);

CREATE TABLE chat (
    provider_id VARCHAR(10) NOT NULL,
    customer_id VARCHAR(10) NOT NULL,
    chatroom_id VARCHAR(10) NOT NULL,
    PRIMARY KEY (provider_id, customer_id, chatroom_id),
    FOREIGN KEY (provider_id) REFERENCES provider(provider_id),
    FOREIGN KEY (customer_id) REFERENCES customer(user_id),
    FOREIGN KEY (chatroom_id) REFERENCES chatroom(chatroom_id)
);

CREATE TABLE message (
    sender VARCHAR(10) NOT NULL,
    date_time TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    chatroom_id VARCHAR(10) NOT NULL,
    image VARCHAR(300) DEFAULT NULL,
    text VARCHAR(300) DEFAULT NULL,
    PRIMARY KEY (sender, date_time, chatroom_id),
    FOREIGN KEY (chatroom_id) REFERENCES chatroom(chatroom_id)
);

-- CREATE TABLE message_info (
--     sender VARCHAR(10) NOT NULL,
--     date_time TIMESTAMP WITHOUT TIME ZONE NOT NULL,
--     image VARCHAR(300) NULL,
--     text VARCHAR(300) NULL,
--     PRIMARY KEY (sender, date_time),
--     FOREIGN KEY (sender) REFERENCES message(sender),
--     FOREIGN KEY (date_time) REFERENCES message(date_time)
-- );
-- I'm not sure if 'message_info' is still needed.
