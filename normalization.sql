-- the database is compliant to normal forms from n1 to n3
-- how ever there is a potential BCNF violation
-- Starting with Agents table 
--    AgentID INT PRIMARY KEY,
--    FirstName VARCHAR(50),
--    LastName VARCHAR(50),
--    Email VARCHAR(100) UNIQUE,
--    PhoneNumber VARCHAR(20),
--    HireDate DATE,
--    OfficeLocation VARCHAR(100),
--    Status ENUM('Active', 'Inactive') DEFAULT 'Active'
-- ://dbdiagram.io/d/683cdee4bd74709cb794878e uml


USE Agent_Performance;
-- Split into two tables
CREATE TABLE Agent_Emails (
    Email VARCHAR(100) PRIMARY KEY,
    AgentID INT UNIQUE,
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID)

);

-- Split into two tables
CREATE TABLE Client_Emails (
    Email VARCHAR(100) PRIMARY KEY,
    ClientID INT UNIQUE,
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);



ALTER TABLE Properties ADD UNIQUE KEY address_zip (Address, ZipCode);

ALTER TABLE Metrics
ADD UNIQUE KEY agent_period (AgentID, PeriodStart, PeriodEnd);
