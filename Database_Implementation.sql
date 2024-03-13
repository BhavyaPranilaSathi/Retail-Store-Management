CREATE DATABASE Purvakshi_Thakkar_Temp;

USE Purvakshi_Thakkar_Temp;

DROP TABLE IF Exists Customer;
DROP TABLE IF Exists CustomerAddress;
DROP TABLE IF Exists LogInUser;
DROP TABLE IF Exists ProductCategory;
DROP TABLE IF Exists Product;
DROP TABLE IF Exists CustomerFeedback;
DROP TABLE IF Exists [Order];
DROP TABLE IF Exists ProductOrders;
DROP TABLE IF Exists Shipping;
DROP TABLE IF Exists Payment;
DROP TABLE IF Exists Vendor;
DROP TABLE IF Exists ProductVendors;
DROP TABLE IF Exists RetailStore;
DROP TABLE IF Exists RetailStoreVendors;
DROP TABLE IF Exists RetailStoreCustomers;

-- Customer Table
CREATE TABLE dbo.Customer (
    CustomerID INT PRIMARY KEY,
    CustomerFName VARCHAR(45),
    CustomerLName VARCHAR(45),
    CustomerEmail VARCHAR(45),
    CustomerDOB DATE,
    CustomerAge AS DATEDIFF(hour,CustomerDOB, GETDATE())/8766,
    CustomerPhNo VARCHAR(45)
);

-- CustomerAddress Table
CREATE TABLE dbo.CustomerAddress (
    CustomerAddressID INT PRIMARY KEY,
    CustomerAddreessStreet VARCHAR(45),
    CustomerAddressApartment VARCHAR(45),
    CustomerAddressCity VARCHAR(45),
    State VARCHAR(45),
    Country VARCHAR(45),
    ZipCode VARCHAR(20),
    CustomerID INT NOT NULL 
    	REFERENCES Customer(CustomerID)
);

-- LogInUser Table
CREATE TABLE dbo.LogInUser (
    LogInUserID INT PRIMARY KEY,
    LogInUserName VARCHAR(45),
    LogInUserEncryptedPassword VARBINARY(250),
    CustomerID INT NOT NULL 
    	REFERENCES Customer(CustomerID)
);

-- ProductCategory Table
CREATE TABLE dbo.ProductCategory (
    ProductCategoryID INT PRIMARY KEY,
    ProductCategoryName VARCHAR(45),
    ProductCategoryDesc VARCHAR(45)
);

-- Product Table
CREATE TABLE dbo.Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(45),
    ProductDesc VARCHAR(45),
    ProductPrice MONEY,
    ProductUnitInStock INT,
    ProductCategoryID INT NOT NULL 
    	REFERENCES ProductCategory(ProductCategoryID)
);

-- CustomerFeedback Table
CREATE TABLE dbo.CustomerFeedback (
    CustomerFeedbackID INT PRIMARY KEY,
    CustomerFeedbackDate DATETIME,
    CustomerFeedbackRating INT,
    CustomerFeedbackComments VARCHAR(145),
    CustomerID INT NOT NULL 
    	REFERENCES Customer(CustomerID),
    ProductID INT NOT NULL 
    	REFERENCES Product(ProductID)
);

-- Order Table
CREATE TABLE dbo.[Order] (
    OrderID INT PRIMARY KEY,
    OrderAmount MONEY,
    OrderDate DATETIME,
    OrderType VARCHAR(45),
    CustomerID INT NOT NULL 
    	REFERENCES Customer(CustomerID)
);

-- ProductOrders Table
CREATE TABLE dbo.ProductOrders (
    ProductOrderDetailId INT PRIMARY KEY IDENTITY(1,1),
  	OrderQuantity INT,
    ProductUnitPrice MONEY,
    TotalProductOrderPrice AS (OrderQuantity * ProductUnitPrice),
    OrderID INT NOT NULL 
    	REFERENCES [Order](OrderID),
    ProductID INT NOT NULL 
    	REFERENCES Product(ProductID)
);

-- Shipping Table
CREATE TABLE dbo.Shipping (
    ShippingID INT PRIMARY KEY,
    ShippingDestinationStreet VARCHAR(45),
    ShippingDestinationApartment VARCHAR(45),
    ShippingDestinationCity VARCHAR(45),
    ShippingDestinationState VARCHAR(45),
    ShippingDestinationCountry VARCHAR(45),
    ShippingDestinationZipCode VARCHAR(20),
    DeliveryStatus VARCHAR(45),
    ShippingDeliveryStartDate DATETIME,
    ShippingDeliveryEndDate DATETIME,
    ShippingDuration AS DATEDIFF(day, ShippingDeliveryStartDate, ShippingDeliveryEndDate),
    OrderID INT NOT NULL 
    	REFERENCES [Order](OrderID)
);

-- Payment Table
CREATE TABLE dbo.Payment (
    PaymentID INT PRIMARY KEY,
    PaymentDate DATETIME,
    PaymentMode VARCHAR(45),
    PaymentStatus VARCHAR(45),
    PaymentAmount MONEY,
    OrderID INT NOT NULL 
   	REFERENCES [Order](OrderID),
    CustomerID INT NOT NULL 
    REFERENCES Customer(CustomerID)
);

-- Vendor Table
CREATE TABLE dbo.Vendor (
    VendorID INT PRIMARY KEY,
    VendorName VARCHAR(45),
    VendorEmail VARCHAR(45),
    VendorStreet VARCHAR(45),
    VendorCity VARCHAR(45),
    VendorState VARCHAR(45),
    VendorZipCode VARCHAR(20),
    VendorCotractStrtDate DATETIME,
    VendorContractEndDate DATETIME,
    VendorPhoneNo VARCHAR(45)
);

-- ProductVendors Table
CREATE TABLE dbo.ProductVendors (
    ProductID INT NOT NULL 
   		REFERENCES Product(ProductID),
    VendorID INT NOT NULL
    	REFERENCES Vendor(VendorID),
   	PRIMARY KEY (ProductID, VendorID)
);

-- RetailStore Table
CREATE TABLE dbo.RetailStore (
    RetailStoreID INT PRIMARY KEY,
    RetailStoreName VARCHAR(45),
    RetailStoreStreet VARCHAR(45),
    RetailStoreCity VARCHAR(45),
    RetailStoreState VARCHAR(45),
    RetailStoreCountry VARCHAR(45),
    RetailStoreZipCode INT,
    RetailStorePhoneNo VARCHAR(45)
);


-- RetailStoreVendors Table
CREATE TABLE dbo.RetailStoreVendors (
    VendorID INT NOT NULL
    	REFERENCES Vendor(VendorID),
    RetailStoreID INT NOT NULL	
    	REFERENCES RetailStore(RetailStoreID),
   	PRIMARY KEY (RetailStoreID, VendorID)
);


-- RetailStoreCustomers Table
CREATE TABLE dbo.RetailStoreCustomers (
	RetailStoreID INT NOT NULL	
    	REFERENCES RetailStore(RetailStoreID),
    CustomerID INT NOT NULL 
    REFERENCES Customer(CustomerID),
    PRIMARY KEY (RetailStoreID, CustomerID)
);


---------DML Statements-----------------------------------------

----------INSERT INTO CUSTOMER TABLE ---------------------------

INSERT INTO dbo.Customer (CustomerID, CustomerFName, CustomerLName, CustomerEmail, CustomerDOB, CustomerPhNo)
VALUES 
    (1, 'Ken', 'Sánchez', 'ken0@adventure-works.com', NULL, '697-555-0142'),
    (2, 'Terri', 'Duffy', 'terri0@adventure-works.com', NULL, '819-555-0175'),
    (3, 'Roberto', 'Tamburello', 'roberto0@adventure-works.com', NULL, '212-555-0187'),
    (4, 'Rob', 'Walters', 'rob0@adventure-works.com', NULL, '612-555-0100'),
    (5, 'Gail', 'Erickson', 'gail0@adventure-works.com', NULL, '849-555-0139'),
    (6, 'Jossef', 'Goldberg', 'jossef0@adventure-works.com', NULL, '122-555-0189'),
    (7, 'Dylan', 'Miller', 'dylan0@adventure-works.com', NULL, '181-555-0156'),
    (8, 'Diane', 'Margheim', 'diane1@adventure-works.com', NULL, '815-555-0138'),
    (9, 'Gigi', 'Matthew', 'gigi0@adventure-works.com', NULL, '185-555-0186'),
    (10, 'Michael', 'Raheem', 'michael6@adventure-works.com', NULL, '330-555-2568'),
    (11, 'Ovidiu', 'Cracium', 'ovidiu0@adventure-works.com', NULL, '719-555-0181'),
    (12, 'Thierry', 'D''Hers', 'thierry0@adventure-works.com', NULL, '168-555-0183'),
    (13, 'Janice', 'Galvin', 'janice0@adventure-works.com', NULL, '473-555-0117'),
    (14, 'Michael', 'Sullivan', 'michael8@adventure-works.com', NULL, '465-555-0156'),
    (15, 'Sharon', 'Salavaria', 'sharon0@adventure-works.com', NULL, '970-555-0138'),
    (16, 'David', 'Bradley', 'david0@adventure-works.com', NULL, '913-555-0172'),
    (17, 'Kevin', 'Brown', 'kevin0@adventure-works.com', NULL, '150-555-0189'),
    (18, 'John', 'Wood', 'john5@adventure-works.com', NULL, '486-555-0150'),
    (19, 'Mary', 'Dempsey', 'mary2@adventure-works.com', NULL, '124-555-0114'),
    (20, 'Wanida', 'Benshoof', 'wanida0@adventure-works.com', '1949-08-01', '708-555-0141'),
    (21, 'Terry', 'Eminhizer', 'terry0@adventure-works.com', NULL, '138-555-0118'),
    (22, 'Sariya', 'Harnpadoungsataya', 'sariya0@adventure-works.com', NULL, '399-555-0176'),
    (23, 'Mary', 'Gibson', 'mary0@adventure-works.com', NULL, '531-555-0183'),
    (24, 'Jill', 'Williams', 'jill0@adventure-works.com', NULL, '510-555-0121'),
    (25, 'James', 'Hamilton', 'james1@adventure-works.com', NULL, '870-555-0122'),
    (26, 'Peter', 'Krebs', 'peter0@adventure-works.com', NULL, '913-555-0196'),
    (27, 'Jo', 'Brown', 'jo0@adventure-works.com', NULL, '632-555-0129'),
    (28, 'Guy', 'Gilbert', 'guy1@adventure-works.com', NULL, '320-555-0195'),
    (29, 'Mark', 'McArthur', 'mark1@adventure-works.com', NULL, '417-555-0154'),
    (30, 'Britta', 'Simon', 'britta0@adventure-works.com', NULL, '955-555-0169'),
    (31, 'Margie', 'Shoop', 'margie0@adventure-works.com', NULL, '818-555-0128'),
    (32, 'Rebecca', 'Laszlo', 'rebecca0@adventure-works.com', NULL, '314-555-0113'),
    (33, 'Annik', 'Stahl', 'annik0@adventure-works.com', NULL, '499-555-0125'),
    (34, 'Suchitra', 'Mohan', 'suchitra0@adventure-works.com', NULL, '753-555-0129'),
    (35, 'Brandon', 'Heidepriem', 'brandon0@adventure-works.com', NULL, '429-555-0137'),
    (36, 'Jose', 'Lugo', 'jose0@adventure-works.com', NULL, '587-555-0115'),
    (37, 'Chris', 'Okelberry', 'chris2@adventure-works.com', NULL, '315-555-0144'),
    (38, 'Kim', 'Abercrombie', 'kim1@adventure-works.com', '1991-12-24', '208-555-0114'),
    (39, 'Ed', 'Dudenhoefer', 'ed0@adventure-works.com', NULL, '919-555-0140'),
    (40, 'JoLynn', 'Dobney', 'jolynn0@adventure-works.com', NULL, '903-555-0145'),
    (41, 'Bryan', 'Baker', 'bryan0@adventure-works.com', '1958-10-23', '712-555-0113'),
    (42, 'James', 'Kramer', 'james0@adventure-works.com', NULL, '119-555-0117'),
    (43, 'Nancy', 'Anderson', 'nancy0@adventure-works.com', '1984-05-26', '970-555-0118'),
    (44, 'Simon', 'Rapier', 'simon0@adventure-works.com', NULL, '963-555-0134'),
    (45, 'Thomas', 'Michaels', 'thomas0@adventure-works.com', NULL, '278-555-0118'),
    (46, 'Eugene', 'Kogan', 'eugene1@adventure-works.com', NULL, '173-555-0179'),
    (47, 'Andrew', 'Hill', 'andrew0@adventure-works.com', NULL, '908-555-0159'),
    (48, 'Ruth', 'Ellerbrock', 'ruth0@adventure-works.com', NULL, '145-555-0130'),
    (49, 'Barry', 'Johnson', 'barry0@adventure-works.com', NULL, '206-555-0180'),
    (50, 'Sidney', 'Higa', 'sidney0@adventure-works.com', NULL, '424-555-0189');

   
   

----------INSERT INTO CUSTOMERADDRESS TABLE ---------------------------


INSERT INTO dbo.CustomerAddress 
(CustomerAddressID, CustomerAddreessStreet, CustomerAddressApartment, CustomerAddressCity, State, Country, ZipCode, CustomerID)
VALUES 
    (249, '4350 Minute Dr.', NULL, 'Newport Hills', 'Washington', 'United States', '98006', 1),
    (224, '2137 Birchwood Dr.', NULL, 'Redmond', 'Washington', 'United States', '98052', 3),
    (11387, '5678 Lakeview Blvd.', NULL, 'Minneapolis', 'Minnesota', 'United States', '55402', 4),
    (286, '5670 Bel Air Dr.', NULL, 'Renton', 'Washington', 'United States', '98055', 6),
    (49, '7048 Laurel', NULL, 'Kenmore', 'Washington', 'United States', '98028', 7),
    (230, '475 Santa Maria', NULL, 'Everett', 'Washington', 'United States', '98201', 8),
    (11386, '1234 Seaside Way', NULL, 'San Francisco', 'California', 'United States', '94109', 10),
    (32505, '5458 Gladstone Drive', NULL, 'Kenmore', 'Washington', 'United States', '98028', 11),
    (1, '1970 Napa Ct.', NULL, 'Bothell', 'Washington', 'United States', '98011', 12),
    (219, '3397 Rancho View Drive', NULL, 'Redmond', 'Washington', 'United States', '98052', 13),
    (295, '6510 Hacienda Drive', NULL, 'Renton', 'Washington', 'United States', '98055', 14),
    (287, '7165 Brock Lane', NULL, 'Renton', 'Washington', 'United States', '98055', 15),
    (214, '3768 Door Way', NULL, 'Redmond', 'Washington', 'United States', '98052', 16),
    (174, '6307 Greenbelt Way', NULL, 'Bellevue', 'Washington', 'United States', '98004', 19),
    (191, '6951 Harmony Way', NULL, 'Sammamish', 'Washington', 'United States', '98074', 20),
    (233, '1185 Dallas Drive', NULL, 'Everett', 'Washington', 'United States', '98201', 22),
    (229, '3928 San Francisco', NULL, 'Everett', 'Washington', 'United States', '98201', 23),
    (243, '3238 Laguna Circle', NULL, 'Everett', 'Washington', 'United States', '98201', 24),
    (166, '3670 All Ways Drive', NULL, 'Bellevue', 'Washington', 'United States', '98004', 26),
    (155, '2046 Las Palmas', NULL, 'Edmonds', 'Washington', 'United States', '98020', 30),
    (142, '2080 Sycamore Drive', NULL, 'Edmonds', 'Washington', 'United States', '98020', 31),
    (162, '3197 Thornhill Place', NULL, 'Bellevue', 'Washington', 'United States', '98004', 32),
    (184, '5678 Clear Court', NULL, 'Bellevue', 'Washington', 'United States', '98004', 34),
    (100, '5125 Cotton Ct.', NULL, 'Seattle', 'Washington', 'United States', '98104', 36),
    (93, '4598 Manila Avenue', NULL, 'Seattle', 'Washington', 'United States', '98104', 39),
    (92, '7126 Ending Ct.', NULL, 'Seattle', 'Washington', 'United States', '98104', 40),
    (69, '2275 Valley Blvd.', NULL, 'Monroe', 'Washington', 'United States', '98272', 41),
    (67, '4734 Sycamore Court', NULL, 'Monroe', 'Washington', 'United States', '98272', 42),
    (84, '3421 Bouncing Road', NULL, 'Duvall', 'Washington', 'United States', '98019', 44),
    (150, '7338 Green St.', NULL, 'Edmonds', 'Washington', 'United States', '98020', 45),
    (246, '6629 Polson Circle', NULL, 'Everett', 'Washington', 'United States', '98201', 47),
    (240, '2176 Apollo Way', NULL, 'Everett', 'Washington', 'United States', '98201', 48),
    (56, '3114 Notre Dame Ave.', NULL, 'Snohomish', 'Washington', 'United States', '98296', 49);
   
   
----------INSERT INTO CUSTOMERFEEDBACK TABLE ---------------------------


INSERT INTO dbo.CustomerFeedback 
(CustomerFeedbackID, CustomerFeedbackDate, CustomerFeedbackRating, CustomerFeedbackComments, CustomerID, ProductID)
VALUES 
    (1, '2007-10-20 00:00:00.000', 5, 'I can''t believe I''m singing the praises of a pair of socks', 2, 709),
    (2, '2007-12-15 00:00:00.000', 4, 'A little on the heavy side, but overall the entry/exit is easy in all conditions.', 1, 723),
    (3, '2007-12-17 00:00:00.000', 2, 'I had a terrible time getting used to these pedals.', 3, 710),
    (4, '2007-12-17 00:00:00.000', 5, 'Everything it''s advertised to be.', 33, 720),
    (5, '2008-12-17 00:00:00.000', 3, 'It''s okay.', 31, 711),
    (6, '2008-04-17 00:00:00.000', 2, 'Worse', 7, 712),
    (7, '2008-12-17 00:00:00.000', 5, 'Superbbbbbb!!!!!Lovedddddd it!!!', 18, 716),
    (8, '2005-12-17 00:00:00.000', 1, 'Don''t buy', 9, 715),
    (9, '2005-01-17 00:00:00.000', 2, '-', 30, 723),
    (10, '2005-01-17 00:00:00.000', 1, 'Don''t buy', 23, 712);


----------INSERT INTO LOGINUSER TABLE ---------------------------
   
INSERT INTO loginuser
VALUES
    (11, 'Terri', EncryptByKey(KEY_GUID(N'TestSymmetricKey'), CONVERT(VARBINARY, 'Pass123cvb')), 2),
    (2, 'Gail', EncryptByKey(KEY_GUID(N'TestSymmetricKey'), CONVERT(VARBINARY, 'AlicePass456')), 5),
    (3, 'Dylan', EncryptByKey(KEY_GUID(N'TestSymmetricKey'), CONVERT(VARBINARY, 'BobPass789')), 7),
    (4, 'Rob', EncryptByKey(KEY_GUID(N'TestSymmetricKey'), CONVERT(VARBINARY, 'EmmaPass012')), 4),
    (5, 'Gigi', EncryptByKey(KEY_GUID(N'TestSymmetricKey'), CONVERT(VARBINARY, 'JohnPass345')), 9),
    (6, 'Thierry', EncryptByKey(KEY_GUID(N'TestSymmetricKey'), CONVERT(VARBINARY, 'OliviaPass678')), 12),
    (7, 'Sharon', EncryptByKey(KEY_GUID(N'TestSymmetricKey'), CONVERT(VARBINARY, 'MichaelPass901')), 15),
    (8, 'David', EncryptByKey(KEY_GUID(N'TestSymmetricKey'), CONVERT(VARBINARY, 'SophiaPass234')), 16),
    (9, 'Roberto', EncryptByKey(KEY_GUID(N'TestSymmetricKey'), CONVERT(VARBINARY, 'WilliamPass567')), 3),
    (10, 'Janice', EncryptByKey(KEY_GUID(N'TestSymmetricKey'), CONVERT(VARBINARY, 'EllaPass890')), 13);


----------INSERT INTO PRODUCTCATEGORY TABLE ---------------------------

INSERT INTO dbo.ProductCategory (ProductCategoryID, ProductCategoryName, ProductCategoryDesc)
VALUES 
    (1, 'Accessories', 'Enhance your ride'),
    (2, 'Components', 'Upgrade and personalize'),
    (3, 'Clothing', 'Stay comfortable and stylish'),
    (4, 'Accessories', 'Enhance your ride');

----------INSERT INTO PRODUCT TABLE ---------------------------

INSERT INTO dbo.Product (ProductID, ProductName, ProductDesc, ProductPrice, ProductUnitInStock, ProductCategoryID)
VALUES 
    (680, 'HL Road Frame - Black, 58', 'FR-R92B-58', 1431.5000, 500, 2),
    (706, 'HL Road Frame - Red, 58', 'FR-R92R-58', 1431.5000, 500, 2),
    (707, 'Sport-100 Helmet, Red', 'HL-U509-R', 34.9900, 4, 4),
    (708, 'Sport-100 Helmet, Black', 'HL-U509', 34.9900, 4, 4),
    (709, 'Mountain Bike Socks, M', 'SO-B909-M', 9.5000, 4, 3),
    (710, 'Mountain Bike Socks, L', 'SO-B909-L', 9.5000, 4, 3),
    (711, 'Sport-100 Helmet, Blue', 'HL-U509-B', 34.9900, 4, 4),
    (712, 'AWC Logo Cap', 'CA-1098', 8.9900, 4, 3),
    (713, 'Long-Sleeve Logo Jersey, S', 'LJ-0192-S', 49.9900, 4, 3),
    (714, 'Long-Sleeve Logo Jersey, M', 'LJ-0192-M', 49.9900, 4, 3),
    (715, 'Long-Sleeve Logo Jersey, L', 'LJ-0192-L', 49.9900, 4, 3),
    (716, 'Long-Sleeve Logo Jersey, XL', 'LJ-0192-X', 49.9900, 4, 3),
    (717, 'HL Road Frame - Red, 62', 'FR-R92R-62', 1431.5000, 500, 2),
    (718, 'HL Road Frame - Red, 44', 'FR-R92R-44', 1431.5000, 500, 2),
    (719, 'HL Road Frame - Red, 48', 'FR-R92R-48', 1431.5000, 500, 2),
    (720, 'HL Road Frame - Red, 52', 'FR-R92R-52', 1431.5000, 500, 2),
    (721, 'HL Road Frame - Red, 56', 'FR-R92R-56', 1431.5000, 500, 2),
    (722, 'LL Road Frame - Black, 58', 'FR-R38B-58', 337.2200, 500, 2),
    (723, 'LL Road Frame - Black, 60', 'FR-R38B-60', 337.2200, 500, 2),
    (724, 'LL Road Frame - Black, 62', 'FR-R38B-62', 337.2200, 500, 2),
    (725, 'LL Road Frame - Red, 44', 'FR-R38R-44', 337.2200, 500, 2),
    (726, 'LL Road Frame - Red, 48', 'FR-R38R-48', 337.2200, 500, 2),
    (727, 'LL Road Frame - Red, 52', 'FR-R38R-52', 337.2200, 500, 2),
    (728, 'LL Road Frame - Red, 58', 'FR-R38R-58', 337.2200, 500, 2),
    (729, 'LL Road Frame - Red, 60', 'FR-R38R-60', 337.2200, 500, 2),
    (730, 'LL Road Frame - Red, 62', 'FR-R38R-62', 337.2200, 500, 2),
    (731, 'ML Road Frame - Red, 44', 'FR-R72R-44', 594.8300, 500, 2),
    (732, 'ML Road Frame - Red, 48', 'FR-R72R-48', 594.8300, 500, 2),
    (733, 'ML Road Frame - Red, 52', 'FR-R72R-52', 594.8300, 500, 2),
    (734, 'ML Road Frame - Red, 58', 'FR-R72R-58', 594.8300, 500, 2),
    (735, 'ML Road Frame - Red, 60', 'FR-R72R-60', 594.8300, 500, 2),
    (736, 'LL Road Frame - Black, 44', 'FR-R38B-44', 337.2200, 500, 2),
    (737, 'LL Road Frame - Black, 48', 'FR-R38B-48', 337.2200, 500, 2),
    (738, 'LL Road Frame - Black, 52', 'FR-R38B-52', 337.2200, 500, 2),
    (739, 'HL Mountain Frame - Silver, 42', 'FR-M94S-42', 1364.5000, 500, 2),
    (740, 'HL Mountain Frame - Silver, 44', 'FR-M94S-44', 1364.5000, 500, 2);
   
 ----------INSERT INTO ORDER TABLE ---------------------------

INSERT INTO dbo.[Order] (OrderID, OrderAmount, OrderDate, OrderType, CustomerID)
VALUES 
    (1, 200.0000, '2023-12-05 21:33:11.937', 'INPERSON', 1),
    (72391, 38.6750, '2008-06-07 00:00:00.000', 'DELIVERY', 1),
    (44679, 3756.9890, '2005-11-18 00:00:00.000', 'DELIVERY', 2),
    (57363, 858.9607, '2007-11-03 00:00:00.000', 'IN_PERSON', 2),
    (55485, 167.1644, '2007-10-03 00:00:00.000', 'IN_PERSON', 3),
    (55871, 59.0844, '2007-10-10 00:00:00.000', 'PICKUP', 4),
    (47453, 2563.1349, '2006-09-01 00:00:00.000', 'PICKUP', 4),
    (67509, 57.4158, '2008-04-03 00:00:00.000', 'DELIVERY', 4),
    (63649, 15.4479, '2008-02-06 00:00:00.000', 'DELIVERY', 6),
    (44984, 3953.9884, '2005-12-24 00:00:00.000', 'PICKUP', 6),
    (48373, 43048.7685, '2006-12-01 00:00:00.000', 'IN_PERSON', 12),
    (52058, 2724.8527, '2007-08-04 00:00:00.000', 'DELIVERY', 12),
    (52431, 5.5140, '2007-08-12 00:00:00.000', 'DELIVERY', 13),
    (57598, 16.5529, '2007-11-08 00:00:00.000', 'DELIVERY', 13),
    (55405, 42.9624, '2007-10-02 00:00:00.000', 'DELIVERY', 14);

 ----------INSERT INTO PRODUCTORDERS TABLE ---------------------------
   
INSERT INTO dbo.ProductOrders (OrderQuantity, ProductUnitPrice, OrderID, ProductID)
VALUES 
    (2, 1431.5000, 44679, 680),
    (6, 5.7000, 44679, 709),
    (4, 20.1865, 52431, 711),
    (2, 5.1865, 52431, 712),
    (3, 28.8404, 57598, 714),
    (1, 28.8404, 57598, 716),
    (1, 2039.9940, 55405, 723),
    (1, 2039.9940, 55405, 711),
    (2, 2039.9940, 52431, 707),
    (1, 2039.9940, 52431, 712);

   
 ----------INSERT INTO SHIPPING TABLE ---------------------------


INSERT INTO dbo.Shipping (
    ShippingID,
    ShippingDestinationStreet,
    ShippingDestinationApartment,
    ShippingDestinationCity,
    ShippingDestinationState,
    ShippingDestinationCountry,
    ShippingDestinationZipCode,
    DeliveryStatus,
    ShippingDeliveryStartDate,
    ShippingDeliveryEndDate,
    OrderID
)
VALUES
    (1, '00, rue Saint-Lazare', NULL, 'Dunkerque', 'Nord', 'France', '59140', 'Yet to dispatch', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', 72391),
    (2, '02, place de Fontenoy', NULL, 'Verrieres Le Buisson', 'Essonne', 'France', '91370', 'Delivered', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', 72391),
    (3, '035, boulevard du Montparnasse', NULL, 'Verrieres Le Buisson', 'Essonne', 'France', '91370', 'In transit', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', 72391),
    (4, '081, boulevard du Montparnasse', NULL, 'Saint-Denis', 'Seine Saint Denis', 'France', '93400', 'Delivered', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', 72391),
    (5, '081, boulevard du Montparnasse', NULL, 'Seattle', 'Washington', 'United States', '98104', 'In transit', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', 72391),
    (6, '084, boulevard du Montparnasse', NULL, 'Les Ulis', 'Essonne', 'France', '91940', 'Yet to dispatch', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', 44679),
    (7, '1 Smiling Tree Court', 'Space 55', 'Los Angeles', 'California', 'United States', '90012', 'In transit', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', 44679),
    (8, '1, allée des Princes', NULL, 'Courbevoie', 'Hauts de Seine', 'France', '92400', 'Delivered', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', 44679),
    (9, '1, avenue des Champs-Elysées', NULL, 'Paris', 'Seine (Paris)', 'France', '75017', 'Yet to dispatch', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', 44679),
    (10, '1, boulevard Beau Marchais', NULL, 'Sèvres', 'Hauts de Seine', 'France', '92310', 'Yet to dispatch', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', 44679);


 
----------INSERT INTO RETAILSTORE TABLE ---------------------------
   
INSERT INTO RetailStore
VALUES
    (1, 'Store 1', '123 Main Street', 'New York', 'NY', 'USA', 10001, '123-456-7890'),
    (2, 'Store 2', '456 Oak Avenue', 'Paris', 'Seine', 'France', 90001, '987-654-3210'),
    (3, 'Store 3', '789 Maple Drive', 'Chicago', 'IL', 'USA', 60601, '111-222-3333'),
    (4, 'Store 4', '246 Elm Street', 'Houston', 'TX', 'USA', 77001, '444-555-6666'),
    (5, 'Store 5', '135 Pine Avenue', 'Miami', 'FL', 'USA', 33101, '777-888-9999'),
    (6, 'Store 6', '369 Cedar Road', 'Arizona', 'AZ', 'USA', 98101, '000-111-2222'),
    (7, 'Store 7', '579 Birch Lane', 'Boston', 'MA', 'USA', 02101, '333-444-5555'),
    (8, 'Store 8', '852 Spruce Court', 'Cliffside', 'British Columbia', 'Canada', 94101, '666-777-8888'),
    (9, 'Store 9', '753 Willow Avenue', 'Denver', 'CO', 'USA', 80201, '999-000-1111'),
    (10, 'Store 10', '147 Oakwood Drive', 'Atlanta', 'GA', 'USA', 30301, '222-333-4444');
   
   

----------INSERT INTO VENDORS TABLE ---------------------------
INSERT INTO dbo.Vendor (VendorID,VendorName,VendorEmail,VendorStreet,VendorCity,VendorState,
	VendorZipCode,VendorCotractStrtDate,VendorContractEndDate,VendorPhoneNo
) VALUES
    (1, 'Australia Bike Retailer', 'lindsey18@adventure-works.com', '00, rue Saint-Lazare', 'Dunkerque', 'Nord', '59140', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', '1 (11) 500 555-0155'),
    (2, 'Allenson Cycles', 'kendra14@adventure-works.com', '02, place de Fontenoy', 'Verrieres Le Buisson', 'Essonne', '91370', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', '1 (11) 500 555-0196'),
    (3, 'Advanced Bicycles', 'meredith0@adventure-works.com', '035, boulevard du Montparnasse', 'Verrieres Le Buisson', 'Essonne', '91370', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', '1 (11) 500 555-0194'),
    (4, 'Trikes, Inc.', 'justin22@adventure-works.com', '081, boulevard du Montparnasse', 'Saint-Denis', 'Seine Saint Denis', '93400', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', '1 (11) 500 555-0114'),
    (5, 'Morgan Bike Accessories', 'jeremy15@adventure-works.com', '081, boulevard du Montparnasse', 'Seattle', 'Washington', '98104', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', '517-555-0176'),
    (6, 'Cycling Master', 'colleen17@adventure-works.com', '084, boulevard du Montparnasse', 'Les Ulis', 'Essonne', '91940', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', '1 (11) 500 555-0127'),
    (7, 'Chicago Rent-All', 'amanda16@adventure-works.com', '1 Smiling Tree Court', 'Los Angeles', 'California', '90012', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', '486-555-0148'),
    (8, 'Greenwood Athletic Company', 'damien20@adventure-works.com', '1, allée des Princes', 'Courbevoie', 'Hauts de Seine', '92400', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', '1 (11) 500 555-0162'),
    (9, 'Compete Enterprises, Inc', 'omar40@adventure-works.com', '1, avenue des Champs-Elysées', 'Paris', 'Seine (Paris)', '75017', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', '1 (11) 500 555-0134'),
    (10, 'International', 'bonnie24@adventure-works.com', '1, boulevard Beau Marchais', 'Sèvres', 'Hauts de Seine', '92310', '2005-07-04 00:00:00.000', '2005-07-20 00:00:00.000', '1 (11) 500 555-0113');
   
   
----------INSERT INTO RETAILSTOREVENDORS TABLE ---------------------------
   

	INSERT INTO RetailStoreVendors
	Values (10,2),(1,3),(2,3),(3,6),(2,10),(9,2),(3,4),(2,5),(6,7),(7,8),(9,3),(8,9),(2,7),(6,9);


----------INSERT INTO RETAILSTORECUSTOMERS TABLE ---------------------------



	INSERT INTO RetailStoreCustomers
	Values (10,2),(1,3),(2,3),(1,6),(2,10),(9,2),(3,4),(2,5),(6,7),(7,8),(9,3),(8,9),(2,7),(6,9);

-----------INSERT INTO PRODUCTVENDORS TABLE-----------------------------------

	Insert into ProductVendors
	Values(707,10),(710,9),(711,8),(712,7),(713,6),(714,5),(715,4),(716,3),(717,2),(718,1),(719,2),(720,3);

-----------INSERT INTO PAYMENT TABLE-----------------------------------

INSERT INTO dbo.Payment (PaymentID,PaymentDate,PaymentMode,PaymentStatus,PaymentAmount,OrderID,CustomerID) 
VALUES
    (10000, '2007-09-01 00:00:00.000', 'Cash', 'Pending', 23153.2339, 55871, 28),
    (10001, '2007-09-01 00:00:00.000', 'Credit Card', 'Completed', 23153.2339, 55871, 29),
    (10002, '2007-09-01 00:00:00.000', 'Debit Card', 'Completed', 23153.2339, 55871, 29),
    (10003, '2007-09-01 00:00:00.000', 'UPI', 'Completed', 23153.2339, 55871, 21),
    (10004, '2007-09-01 00:00:00.000', 'UPI', 'Pending', 23153.2339, 55871, 28),
    (10005, '2007-09-01 00:00:00.000', 'Credit Card', 'Pending', 23153.2339, 55871, 21),
    (10006, '2007-09-01 00:00:00.000', 'Debit Card', 'Pending', 23153.2339, 55871, 29),
    (10007, '2007-09-01 00:00:00.000', 'UPI', 'Completed', 23153.2339, 55871, 20),
    (10008, '2007-09-01 00:00:00.000', 'Cash', 'Pending', 23153.2339, 55871, 28),
    (10009, '2007-09-01 00:00:00.000', 'Credit Card', 'Completed', 23153.2339, 55871, 29),
    (10010, '2007-09-01 00:00:00.000', 'Debit Card', 'Completed', 23153.2339, 55871, 29),
    (10011, '2007-09-01 00:00:00.000', 'UPI', 'Completed', 23153.2339, 55871, 10),
    (10012, '2007-09-01 00:00:00.000', 'UPI', 'Pending', 23153.2339, 55871, 25),
    (10013, '2007-09-01 00:00:00.000', 'Credit Card', 'Pending', 23153.2339,55871, 23);





-------------Table-level CHECK Constraints based on a function--------------------------------------


------Product price must be > 0 and stock can not be negative

CREATE FUNCTION dbo.ProductPriceAndQtyCheck(@PPrice DECIMAL, @PUnitInStock DECIMAL)
RETURNS BIT
AS
BEGIN
	DECLARE @Result BIT
	IF @PPrice > 0.0 AND @PUnitInStock >=0.0
		SET @Result = 1
	ELSE 
		SET @Result = 0
	RETURN @Result 
END

ALTER TABLE dbo.Product ADD CONSTRAINT ProductPriceAndQtyCheckStatus 
						CHECK(dbo.ProductPriceAndQtyCheck(ProductPrice, ProductUnitInStock) = 1);

--Test Case
INSERT INTO dbo.Product (ProductID, ProductName, ProductDesc, ProductPrice, ProductUnitInStock, ProductCategoryID)
VALUES
(2, 'Toys', 'Child Play Things', -5.25, 50, 2); 


INSERT INTO dbo.Product (ProductID, ProductName, ProductDesc, ProductPrice, ProductUnitInStock, ProductCategoryID)
VALUES (3, 'Laptop', 'Electronics', 8.75, -20, 3);

------Vendor cannot supply products before contract start date ----------------------------------

CREATE TRIGGER VenderCntrctStrtDateCheck
ON dbo.ProductVendors 
AFTER INSERT AS
BEGIN 
	IF EXISTS (SELECT i.VendorID, i.ProductID 
				FROM Inserted i
				JOIN dbo.ProductVendors pv
				ON i.VendorID = pv.VendorID AND i.ProductID = pv.ProductID 
				WHERE SYSDATETIME() < (SELECT v.VendorCotractStrtDate 
										FROM dbo.Vendor v
										WHERE v.VendorID = i.VendorID))
		BEGIN 
			PRINT 'You can start supplying products only after contract starts!!!'
			ROLLBACK 
		END	
END

-- Test Case
INSERT INTO dbo.Vendor (VendorID, VendorName, VendorCotractStrtDate) 
VALUES (203, 'Vendor A', DATEADD(DAY, 1, GETDATE()));

INSERT INTO dbo.ProductVendors (VendorID, ProductID)
VALUES(203,707);

--- If customer has not bought that product, customer cannot review about that product 

CREATE TRIGGER PreventInvalidProductReview
ON dbo.CustomerFeedback
AFTER INSERT
AS
BEGIN
    IF NOT EXISTS (
        SELECT *
        FROM inserted i
        JOIN dbo.ProductOrders po ON i.ProductID = po.ProductID
        JOIN dbo.[Order] o ON po.OrderID = o.OrderID
        WHERE o.CustomerID = i.CustomerID
    )
    BEGIN
        PRINT 'Error: Customer cannot review a product they have not purchased.'
        ROLLBACK
    END
END


---Test Case

INSERT INTO CustomerFeedback VALUES (18,'2023-07-23',5,'good',20260,680);


-----Computed Columns

----Once delivery end date is recorded mark delivery status as delivered

CREATE TRIGGER updateDeliveryStatus
ON dbo.Shipping 
AFTER UPDATE
AS
BEGIN
	DECLARE @ShippingID INT = 0;
	DECLARE @ShippingDeliveryEndDate DATETIME;
	
	SELECT @ShippingID = ShippingID From Inserted;
	SELECT @ShippingDeliveryEndDate = ShippingDeliveryEndDate FROM Inserted;

	IF @ShippingDeliveryEndDate IS NOT NULL
		BEGIN
			UPDATE dbo.Shipping SET DeliveryStatus = 'Delivered' WHERE ShippingID = @ShippingID;
		END		
END

--Test Case
INSERT INTO dbo.Shipping (ShippingID, ShippingDeliveryStartDate, OrderID)
VALUES (101, '2023-01-01', 1);
SELECT * FROM Shipping WHERE ShippingID=101;

UPDATE dbo.Shipping 
SET ShippingDeliveryEndDate = GETDATE()
WHERE ShippingID = 101;
SELECT * FROM Shipping WHERE ShippingID=101;

----Update ProductUnitPrice in Product Table

CREATE TRIGGER updateProductUnitPriceInProductOrders
ON dbo.ProductOrders 
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @ProductID INT = 0;
	DECLARE @ProductOrderDetailId INT = 0;
	DECLARE @ProductUnitPrice MONEY = 0;
	
	SELECT @ProductOrderDetailId = ProductOrderDetailId From Inserted;
	SELECT @ProductID = ProductID FROM Inserted;
	SELECT @ProductUnitPrice = ProductPrice FROM dbo.Product p 
	WHERE ProductID = @ProductID;

	UPDATE dbo.ProductOrders SET ProductUnitPrice = @ProductUnitPrice 
	WHERE ProductOrderDetailId = @ProductOrderDetailId;		
END


--  Encrytion and Decryption of Password in LogIn User

 CREATE MASTER KEY
 ENCRYPTION BY PASSWORD='Test$$Password';

CREATE CERTIFICATE TestCertificate
With SUBJECT='Password Test Certificate', EXPIRY_DATE='2025-10-9';

CREATE SYMMETRIC KEY TestSymmetricKey
WITH ALGORITHM=AES_128
ENCRYPTION BY CERTIFICATE TestCertificate;

-- Decryption
OPEN SYMMETRIC KEY TestSymmetricKey
DECRYPTION BY CERTIFICATE TestCertificate;

UPDATE LogInUser
		SET LogInUserEncryptedPassword = EncryptByKey(Key_GUID('SSNSymmetricKey'), LogInUserEncryptedPassword);
		
INSERT INTO loginuser
VALUES(3,'aish',EncryptByKey(KEY_GUID(N'TestSymmetricKey'),convert(varbinary,'Pass123cvb')),1);

SELECT * FROM LogInUser;

SELECT LogInUserEncryptedPassword AS 'Encrypted Password',  
		CONVERT(varchar, DecryptByKey(LogInUserEncryptedPassword))   
		AS 'Decrypted Password'  
		FROM LogInUser; 

select * from loginuser;

---Views

-----Loyal Customer View

CREATE VIEW LoyalCustomersView
AS
SELECT 
    C.CustomerID,
    C.CustomerFName,
    C.CustomerLName,
    C.CustomerEmail,
    C.CustomerAge,
    CASE
        WHEN Freq.OrderFrequency > 1 THEN Freq.OrderFrequency
        ELSE 0
    END AS OrderFrequencyInMonth
FROM 
    dbo.Customer C
JOIN 
    dbo.[Order] O ON C.CustomerID = O.CustomerID
LEFT JOIN (
    SELECT 
        CustomerID,
        YEAR(OrderDate) AS OrderYear,
        MONTH(OrderDate) AS OrderMonth,
        COUNT(*) AS OrderFrequency
    FROM 
        dbo.[Order]
    GROUP BY 
        CustomerID,
        YEAR(OrderDate),
        MONTH(OrderDate)
    HAVING 
        COUNT(*) > 1
) AS Freq ON Freq.CustomerID = O.CustomerID 
           AND Freq.OrderYear = YEAR(O.OrderDate)
           AND Freq.OrderMonth = MONTH(O.OrderDate)
WHERE 
    NOT EXISTS (
        SELECT 1
        FROM dbo.[Order] O2
        WHERE 
            O.CustomerID = O2.CustomerID
            AND O2.OrderDate < O.OrderDate
            AND DATEDIFF(MONTH, O2.OrderDate, O.OrderDate) <= 1);



SELECT * FROM LoyalCustomersView ORDER BY OrderFrequencyInMonth DESC;


-----------Top 10 Locations Without Retail Stores


CREATE VIEW TopLocationsWithoutRetailStores AS
SELECT TOP 10
    CA.CustomerAddressCity,
    CA.State AS CustomerAddressState,
    COUNT(*) AS TotalOrders
FROM 
    dbo.CustomerAddress CA
JOIN 
    dbo.[Order] O ON CA.CustomerID = O.CustomerID
WHERE 
    O.OrderType = 'delivery'
    AND NOT EXISTS (
        SELECT 1
        FROM dbo.RetailStore RS
        WHERE 
            RS.RetailStoreCity = CA.CustomerAddressCity
            AND RS.RetailStoreState = CA.State
    )
GROUP BY 
    CA.CustomerAddressCity,
    CA.State
ORDER BY 
    TotalOrders DESC;

SELECT * FROM TopLocationsWithoutRetailStores;
   

-----Low Quantity High Demand Products
  
  
CREATE VIEW LowQuantityHighDemandProducts AS
SELECT 
    P.ProductID,
    P.ProductName,
    P.ProductDesc,
    P.ProductPrice,
    P.ProductUnitInStock,
    OrdersPerProduct.TotalOrders
FROM 
    dbo.Product P
JOIN (
    SELECT 
        PO.ProductID,
        COUNT(*) AS TotalOrders
    FROM 
        dbo.ProductOrders PO
    JOIN 
        dbo.[Order] O ON PO.OrderID = O.OrderID
    GROUP BY 
        PO.ProductID
    HAVING 
        COUNT(*) >= 500
) OrdersPerProduct ON P.ProductID = OrdersPerProduct.ProductID
WHERE 
    P.ProductUnitInStock < 10;
   
 SELECT * FROM LowQuantityHighDemandProducts ORDER BY TotalOrders DESC ;

---Top 2 Products for Each Product Category

CREATE VIEW Top2_ProductsPerCategory AS
SELECT *
FROM (
    SELECT 
        p.ProductCategoryID,pc.ProductCategoryName,p.ProductID,p.ProductName,Sales.NumberOfOrders,TotalSalesAmount,
        DENSE_RANK() OVER (PARTITION BY p.ProductCategoryID ORDER BY TotalSalesAmount DESC) AS Top2Products
    FROM Product p
    JOIN (
        SELECT od.ProductID,COUNT(o.OrderID) AS NumberOfOrders,SUM(o.OrderAmount) AS TotalSalesAmount
		FROM [Order] o
        JOIN ProductOrders od ON o.OrderID = od.OrderID
        GROUP BY od.ProductID
    ) AS Sales ON p.ProductID = Sales.ProductID
	JOIN ProductCategory pc ON pc.ProductCategoryID = p.ProductCategoryID
	
) AS RankedProducts
WHERE Top2Products <= 2;

select * from Top2_ProductsPerCategory;



