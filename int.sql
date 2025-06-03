-- Create Database
CREATE DATABASE IF NOT EXISTS Agent_Performance;
USE Agent_Performance;

-- 1. Create Agents Table
CREATE TABLE Agents (
    AgentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    -- Email VARCHAR(100) UNIQUE, Normalized to Agent_Emails
    PhoneNumber VARCHAR(20),
    HireDate DATE,
    OfficeLocation VARCHAR(100),
    Status ENUM('Active', 'Inactive') DEFAULT 'Active'
);

-- 2. Create Clients Table (referenced by Sales)
CREATE TABLE Clients (
    ClientID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    -- Email VARCHAR(100) UNIQUE, Normalized to Client_Emails
    PhoneNumber VARCHAR(20),
    PreferredContactMethod VARCHAR(50),
    RegistrationDate DATE
);

-- 3. Create Properties Table (referenced by Listings and Sales)
-- Assuming you have a Properties table; define it as needed.
CREATE TABLE Properties (
    PropertyID INT PRIMARY KEY,
    Address VARCHAR(255),
    City VARCHAR(100),
    State CHAR(2),
    ZipCode VARCHAR(10),
    PropertyType VARCHAR(50),
    Bedrooms INT,
    Bathrooms INT,
    SquareFeet INT,
    Status ENUM('For Sale', 'Sold', 'Pending')
);

-- 4. Create Listings Table (references Agents and Properties)
CREATE TABLE Listings (
    ListingID INT PRIMARY KEY,
    PropertyID INT,
    AgentID INT,
    ListingDate DATE,
    ExpiryDate DATE,
    Status ENUM('Active', 'Sold', 'Withdrawn'),
    AskingPrice DECIMAL(12,2),
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID),
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID)
);

-- 5. Create Sales Table (references Agents, Clients, Properties)
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    AgentID INT,
    ClientID INT,
    PropertyID INT,
    SaleDate DATE,
    SalePrice DECIMAL(12,2),
    Commission DECIMAL(10,2),
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID)
);

-- 6. Create Metrics Table
CREATE TABLE Metrics (
    MetricID INT PRIMARY KEY,
    AgentID INT,
    PeriodStart DATE,
    PeriodEnd DATE,
    PropertiesListed INT,
    PropertiesSold INT,
    TotalSales DECIMAL(15,2),
    AverageDaysOnMarket INT,
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID)
);

-- 7. Create Reviews Table
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY,
    AgentID INT,
    ClientID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Feedback TEXT,
    ReviewDate DATE,
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);

-- 8. Create Goals Table
CREATE TABLE Goals (
    GoalID INT PRIMARY KEY,
    AgentID INT,
    StartDate DATE,
    EndDate DATE,
    TargetSales DECIMAL(12,2),
    TargetListings INT,
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID)
);

-- 9. Create Logs Table
CREATE TABLE Logs (
    LogID INT PRIMARY KEY,
    AgentID INT,
    Action VARCHAR(100),
    Description TEXT,
    Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID)
);

-- 10. Create Alerts Table
CREATE TABLE Alerts (
    AlertID INT PRIMARY KEY,
    AgentID INT,
    AlertType VARCHAR(50),
    Message TEXT,
    TriggeredDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Resolved BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID)
);

-- 11. Create Reports Table
CREATE TABLE Reports (
    ReportID INT PRIMARY KEY,
    ReportName VARCHAR(100),
    GeneratedBy INT,
    GeneratedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Content TEXT,
    FOREIGN KEY (GeneratedBy) REFERENCES Agents(AgentID)
);