DELIMITER //

CREATE PROCEDURE AddAgent (
  IN fname VARCHAR(50),
  IN lname VARCHAR(50),
  IN phone VARCHAR(20),
  IN hdate DATE,
  IN office VARCHAR(100),
  IN email VARCHAR(100)
)
BEGIN
  DECLARE new_id INT;

  INSERT INTO Agents (FirstName, LastName, PhoneNumber, HireDate, OfficeLocation)
  VALUES (fname, lname, phone, hdate, office);

  SET new_id = LAST_INSERT_ID();

  INSERT INTO Agent_Emails (Email, AgentID)
  VALUES (email, new_id);
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE DeactivateAgent (
  IN aID INT
)
BEGIN
  UPDATE Agents
  SET Status = 'Inactive'
  WHERE AgentID = aID;

  INSERT INTO Logs (AgentID, Action, Description)
  VALUES (aID, 'Status Change', 'Agent set to Inactive');
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE RecordSale (
  IN aID INT,
  IN cID INT,
  IN pID INT,
  IN sDate DATE,
  IN sPrice DECIMAL(12,2),
  IN commission DECIMAL(10,2)
)
BEGIN
  INSERT INTO Sales (AgentID, ClientID, PropertyID, SaleDate, SalePrice, Commission)
  VALUES (aID, cID, pID, sDate, sPrice, commission);

  UPDATE Properties
  SET Status = 'Sold'
  WHERE PropertyID = pID;
END //

DELIMITER ;



