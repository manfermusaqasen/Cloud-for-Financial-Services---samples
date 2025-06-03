-- SQL DDL representing the appointment starter kit data model

-- Table storing branch addresses
CREATE TABLE Address (
    id SERIAL PRIMARY KEY,
    street_one      VARCHAR(100),
    street_two      VARCHAR(100),
    city            VARCHAR(50),
    state           VARCHAR(50),
    country         VARCHAR(50),
    postcode        VARCHAR(20),
    phone_number    VARCHAR(50),
    email           VARCHAR(100)
);

-- Branches reference an Address record
CREATE TABLE Branch (
    id VARCHAR(50) PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    address_id  INTEGER REFERENCES Address(id)
);

-- Advisors that can be assigned to meetings or time slots
CREATE TABLE Advisor (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50)
);

-- Meeting topics provide high level categories
CREATE TABLE MeetingTopic (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Meeting types extend topics with additional settings
CREATE TABLE MeetingType (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    duration INTEGER,
    channel_limitation INTEGER,
    meeting_type_topic_id VARCHAR(50) REFERENCES MeetingTopic(id),
    customer_instructions TEXT
);

-- Individual meeting records with scheduling information
CREATE TABLE Meeting (
    id VARCHAR(50) PRIMARY KEY,
    meeting_type_id VARCHAR(50) REFERENCES MeetingType(id),
    branch_id       VARCHAR(50) REFERENCES Branch(id),
    agent_id        VARCHAR(50) REFERENCES Advisor(id),
    note TEXT,
    is_virtual BOOLEAN,
    virtual_meeting_link TEXT,
    start_time TIMESTAMP NOT NULL,
    end_time   TIMESTAMP NOT NULL
);

-- Basic user account information
CREATE TABLE UserAccount (
    id VARCHAR(50) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    is_logged_in BOOLEAN
);

-- Available time slots and advisors assigned to them
CREATE TABLE TimeSlot (
    id SERIAL PRIMARY KEY,
    start_time TIMESTAMP NOT NULL,
    end_time   TIMESTAMP NOT NULL
);

CREATE TABLE TimeSlotAdvisor (
    time_slot_id INTEGER REFERENCES TimeSlot(id),
    advisor_id   VARCHAR(50) REFERENCES Advisor(id),
    PRIMARY KEY (time_slot_id, advisor_id)
);
