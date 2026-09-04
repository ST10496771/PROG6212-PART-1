CREATE DATABASE RaceDayDB;

CREATE TABLE Organiser (
    OrganiserID         INT NOT NULL PRIMARY KEY,
    OrganiserFirstName  VARCHAR(50)  NOT NULL,
    OrganiserLastName   VARCHAR(50)  NOT NULL,
    OrganiserEmailAddress VARCHAR(100) NOT NULL,
    OrganiserContactNumber VARCHAR(20) NULL,
    PasswordHash        VARCHAR(255) NOT NULL,
    CreatedAt            DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE Participant (
    ParticipantID   INT NOT NULL PRIMARY KEY,
    FirstName       VARCHAR(50)  NOT NULL,
    LastName        VARCHAR(50)  NOT NULL,
    EmailAddress    VARCHAR(100) NOT NULL,
    PasswordHash    VARCHAR(255) NOT NULL,
    CreatedAt       DATETIME NOT NULL DEFAULT GETDATE(),
);

CREATE TABLE Event (
    EventID      INT NOT NULL PRIMARY KEY,
    EventName    VARCHAR(100) NOT NULL,
    EventDate    DATE NOT NULL,
    OrganiserID  INT NOT NULL,
    CreatedAt    DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Event_Organiser FOREIGN KEY (OrganiserID)
        REFERENCES Organiser (OrganiserID)
);

CREATE TABLE Category (
    CategoryID          INT NOT NULL PRIMARY KEY,
    CategoryName         VARCHAR(100) NOT NULL,
    CategoryDescription  VARCHAR(255) NULL,
    EventID              INT NOT NULL,
    CONSTRAINT FK_Category_Event FOREIGN KEY (EventID)
        REFERENCES Event (EventID),
);

CREATE TABLE EventEntrance (
    EventEntranceID           INT NOT NULL PRIMARY KEY,
    ParticipantID              INT NOT NULL,
    CategoryID                 INT NOT NULL,
    EventEntranceDescription   VARCHAR(255) NULL,
    EntryDate                  DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_EventEntrance_Participant FOREIGN KEY (ParticipantID)
        REFERENCES Participant (ParticipantID),
    CONSTRAINT FK_EventEntrance_Category FOREIGN KEY (CategoryID)
        REFERENCES Category (CategoryID),);

CREATE TABLE Result (
    ResultID            INT NOT NULL PRIMARY KEY,
    ResultDescription   VARCHAR(255) NULL,
    FinishTime          TIME NULL,
    EventEntranceID     INT NOT NULL,
    RecordedAt          DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Result_EventEntrance FOREIGN KEY (EventEntranceID)
        REFERENCES EventEntrance (EventEntranceID),
);

INSERT INTO Organiser ( OrganiserID, OrganiserFirstName, OrganiserLastName, 
OrganiserEmailAddress, OrganiserContactNumber, PasswordHash)
VALUES
    (1, 'Thabo', 'Mokoena', 'thabo.mokoena@raceday.co.za', '0712345678', 'HASHED_PASSWORD_1'),
    (2, 'Lindiwe', 'Nkosi',  'lindiwe.nkosi@raceday.co.za', '0823456789', 'HASHED_PASSWORD_2');

INSERT INTO Participant (ParticipantID, FirstName, LastName, EmailAddress, PasswordHash)
VALUES
    (1, 'Sipho',  'Dlamini', 'sipho.dlamini@example.com', 'HASHED_PASSWORD_3'),
    (2, 'Amahle', 'Botha',   'amahle.botha@example.com',  'HASHED_PASSWORD_4');

INSERT INTO Event (EventID, EventName, EventDate, OrganiserID)
VALUES
    (1, 'Johannesburg City Marathon', '2026-10-10', 1),
    (2, 'Durban Beachfront Fun Run',  '2026-11-02', 1),
    (3, 'Cape Town Trail Challenge',  '2026-11-22', 2);

INSERT INTO Category (CategoryID, CategoryName, CategoryDescription, EventID)
VALUES
    (1, '10km Run',        'Standard 10 kilometre road race', 1),
    (2, '21km Half Marathon', 'Half marathon distance road race', 1),
    (3, '5km Fun Run',      'Family-friendly 5 kilometre run/walk', 2),
    (4, '10km Run',         'Beachfront 10 kilometre run', 2),
    (5, '15km Trail',       'Mixed-terrain 15 kilometre trail run', 3),
    (6, '30km Trail',       'Advanced 30 kilometre trail run', 3);

INSERT INTO EventEntrance (EventEntranceID, CategoryID, EventEntranceDescription)
VALUES
    (1, 1, 'Sipho entered the 10km Run at Johannesburg City Marathon'),
    (1, 5, 'Sipho entered the 15km Trail at Cape Town Trail Challenge'),
    (2, 3, 'Amahle entered the 5km Fun Run at Durban Beachfront Fun Run'),
    (2, 2, 'Amahle entered the 21km Half Marathon at Johannesburg City Marathon');

INSERT INTO Result (ResultID, ResultDescription, FinishTime, EventEntranceID)
VALUES
    (1, 'Sipho finished the 10km Run', '00:48:23', 1),
    (2, 'Amahle finished the 5km Fun Run', '00:26:10', 3);

 SELECT * FROM Organiser;
 SELECT * FROM Participant;
 SELECT * FROM Event;
 SELECT * FROM Category;
 SELECT * FROM EventEntrance;
 SELECT * FROM Result;
