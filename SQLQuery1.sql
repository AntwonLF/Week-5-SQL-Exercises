USE master;

 

IF DB_ID(N'LifeStyleDB') IS NOT NULL DROP DATABASE LifeStyleDB;

 

CREATE DATABASE LifeStyleDB;

GO

 

USE LifeStyleDB;

GO

 

CREATE SCHEMA HR AUTHORIZATION dbo;

GO

CREATE SCHEMA Sales AUTHORIZATION dbo;

GO

CREATE SCHEMA Purchasing AUTHORIZATION dbo;

GO

 

CREATE TABLE Sales.Customers

(

  CustomerId          INT              NOT NULL IDENTITY,

  CustomerName                  NVARCHAR(50) NOT NULL,

  StreetAddress NVARCHAR(50) NULL,

  City                                          NVARCHAR(20) NULL,

  [State]                                    NVARCHAR(20) NULL,

  PostalCode           NVARCHAR(10) NULL,

  Country                                  NVARCHAR(20) NULL,

  Contact                                  NVARCHAR(50) NULL,

  Email                                       NVARCHAR(50) NULL,

  CONSTRAINT PK_Customers PRIMARY KEY(CustomerId)

);

 

CREATE TABLE HR.Employees

(

  EmployeeId          INT              NOT NULL IDENTITY,

  FirstName                             NVARCHAR(50) NOT NULL,

  LastName                              NVARCHAR(50) NOT NULL,

  BirthDate         DATE             NOT NULL,

  HireDate          DATE             NOT NULL,

  HomeAddress   NVARCHAR(50) NULL,

  City              NVARCHAR(20) NULL,

  [State]           NVARCHAR(20) NULL,

  PostalCode        NVARCHAR(10) NULL,

  Phone             NVARCHAR(20) NULL,

  ManagerId         INT                                                 NULL,

  CONSTRAINT PK_Employees PRIMARY KEY(EmployeeId),

  CONSTRAINT FK_Employees_Employees FOREIGN KEY(ManagerId)

        REFERENCES HR.Employees(EmployeeId),

  CONSTRAINT CHK_BirthDate CHECK(BirthDate <= CAST(SYSDATETIME() AS DATE)),

  CONSTRAINT CHK_HireDate CHECK(BirthDate < HireDate)

);

 

CREATE TABLE Purchasing.Suppliers

(

  SupplierId             INT              NOT NULL IDENTITY,

  SupplierName NVARCHAR(50) NOT NULL,

  StreetAddress NVARCHAR(50) NULL,

  City                                          NVARCHAR(20) NULL,

  [State]                                    NVARCHAR(20) NULL,

  PostalCode           NVARCHAR(10) NULL,

  Country                          NVARCHAR(20) NULL,

  CONSTRAINT PK_Supplier PRIMARY KEY(SupplierId)

);

 

CREATE TABLE Purchasing.Products

(

  ProductId                              INT              NOT NULL IDENTITY,

  ProductName  NVARCHAR(40) NOT NULL,

  supplierid              INT              NOT NULL,

  CONSTRAINT PK_Products PRIMARY KEY(ProductId),

  CONSTRAINT FK_Products_Suppliers FOREIGN KEY(SupplierId)

        REFERENCES Purchasing.Suppliers(SupplierId)

);

 

CREATE TABLE Purchasing.Deliveries

(

                    DeliveryId                               INT                                             NOT NULL IDENTITY,

                    ProductId                                INT                                             NOT NULL,

                    Quantity                                  INT                                             NOT NULL,

                    Price                                          MONEY                    NOT NULL

                                    CONSTRAINT DF_Deliveries_price DEFAULT(0),

                    DeliveryDate          DateTime2              NOT NULL

                                    CONSTRAINT DF_Deliveries_DeliveryDate DEFAULT(SYSDATETIME()),

                    CONSTRAINT PK_Deliveries PRIMARY KEY (DeliveryId),

                    CONSTRAINT FK_Deliveries_Products FOREIGN KEY(ProductId)

                                    REFERENCES Purchasing.Products(ProductId),

                    CONSTRAINT CHK_Deliveries_Price CHECK (Price >= 0)

);

 

CREATE TABLE Sales.Orders

(

  OrderId            INT          NOT NULL IDENTITY,

  CustomerId         INT              NOT NULL,

  EmployeeId         INT              NOT NULL,

  OrderDate          DATE             NOT NULL,

  CONSTRAINT PK_Orders PRIMARY KEY(OrderId),

  CONSTRAINT FK_Orders_Customers FOREIGN KEY(CustomerId)

        REFERENCES Sales.Customers(CustomerId),

  CONSTRAINT FK_Orders_Employees FOREIGN KEY(EmployeeId)

        REFERENCES HR.Employees(EmployeeId)

);

 

CREATE TABLE Sales.OrderDetails

(

  OrderId   INT           NOT NULL,

  ProductId INT               NOT NULL,

  Price                        MONEY         NOT NULL

        CONSTRAINT DF_OrderDetails_price DEFAULT(0),

  quantity  SMALLINT      NOT NULL

        CONSTRAINT DF_OrderDetails_qty DEFAULT(1),

  CONSTRAINT PK_OrderDetails PRIMARY KEY(Orderid, Productid),

  CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY(OrderId)

        REFERENCES Sales.Orders(OrderId),

  CONSTRAINT FK_OrderDetails_Products FOREIGN KEY(ProductId)

        REFERENCES Purchasing.Products(ProductId),

  CONSTRAINT CHK_quantity  CHECK (quantity > 0),

  CONSTRAINT CHK_price CHECK (price >= 0)

);

 

SET IDENTITY_INSERT Sales.Customers ON;

INSERT INTO Sales.Customers(CustomerId, CustomerName, StreetAddress, City, [State], PostalCode, Country, Contact, Email)

                    VALUES(1, 'Just Electronics', '123 Broad way', 'New York', 'NY', '12012', 'USA', 'John White', 'jwhite@je.com');

INSERT INTO Sales.Customers(CustomerId, CustomerName, StreetAddress, City, [State], PostalCode, Country, Contact, Email)

                    VALUES(2, 'Beyond Electronics', '45 Cherry Street', 'Chicago', 'IL', '32302', 'USA', 'Scott Green', 'green@beil.com');

INSERT INTO Sales.Customers(CustomerId, CustomerName, StreetAddress, City, [State], PostalCode, Country, Contact, Email)

                    VALUES(3, 'Beyond Electronics', '6767 GameOver Blvd', 'Atlanta', 'GA', '43347', 'USA', 'Alice Black', 'black1@be.com');

INSERT INTO Sales.Customers(CustomerId, CustomerName, StreetAddress, City, [State], PostalCode, Country, Contact, Email)

                    VALUES(4, 'E Fun', '888  Main Ave.', 'Seattle', 'WA', '69356', 'USA', 'Ben Gold', 'bgold@efun.com');

INSERT INTO Sales.Customers(CustomerId, CustomerName, StreetAddress, City, [State], PostalCode, Country, Contact, Email)

                    VALUES(5, 'Overstock E', '39 Garden Place', 'Los Angeles', 'CA', '32302', 'USA', 'Daniel Yellow', 'dy@os.com');

INSERT INTO Sales.Customers(CustomerId, CustomerName, StreetAddress, City, [State], PostalCode, Country, Contact, Email)

                    VALUES(6, 'E Fun', '915 Market st.', 'London', 'England', 'EC1A 1BB', 'UK', 'Frank Green', 'green@ef.com');

INSERT INTO Sales.Customers(CustomerId, CustomerName, StreetAddress, City, [State], PostalCode, Country, Contact, Email)

                    VALUES(7, 'Electronics4U', '27 Colmore Row', 'Birmingham', 'England', 'B3 2EW', 'UK', 'Grace Smith', 'smith@e4u.com');

INSERT INTO Sales.Customers(CustomerId, CustomerName, StreetAddress, City, [State], PostalCode, Country)

                    VALUES(8, 'Cheap Electronics', '1010 Easy St', 'Ottawa', 'Ontario', 'K1A 0B1', 'Canada');

SET IDENTITY_INSERT Sales.Customers OFF;

 

SET IDENTITY_INSERT HR.Employees ON;

INSERT INTO HR.Employees(EmployeeId, FirstName, LastName, BirthDate, HireDate, HomeAddress, City, [State], PostalCode, Phone, ManagerId)

                    VALUES(1, 'Alex', 'Hall', '19900203', '20150809', '85 Main Ln', 'New Canton', 'VA', '23123', '(434) 290-3322', NULL);

INSERT INTO HR.Employees(EmployeeId, FirstName, LastName, BirthDate, HireDate, HomeAddress, City, [State], PostalCode, Phone, ManagerId)

                    VALUES(2, 'Dianne', 'Hart', '19781203', '20100801', '209 Social Hall Blvd', 'New Canton', 'VA', '23123', '(434) 290-1122', 1);

INSERT INTO HR.Employees(EmployeeId, FirstName, LastName, BirthDate, HireDate, HomeAddress, City, [State], PostalCode, Phone, ManagerId)

                    VALUES(3, 'Maria', 'Law', '19880713', '20120821', '258 Blinkys St', 'New Canton', 'VA', '23123', '(434) 531-5673', 1);

INSERT INTO HR.Employees(EmployeeId, FirstName, LastName, BirthDate, HireDate, HomeAddress, City, [State], PostalCode, Phone, ManagerId)

                    VALUES(4, 'Alice', 'Law', '19881213', '20120422', '300 Vista Valley Blvd', 'Buckingham', 'VA', '23123', '(434) 531-1010', 1);

INSERT INTO HR.Employees(EmployeeId, FirstName, LastName, BirthDate, HireDate, HomeAddress, City, [State], PostalCode, Phone, ManagerId)

                    VALUES(5, 'Black', 'Hart', '19821109', '20150412', '1 Old Fifteen St', 'Buckingham', 'VA', '23123', '(434) 531-1034', 2);

INSERT INTO HR.Employees(EmployeeId, FirstName, LastName, BirthDate, HireDate, HomeAddress, City, [State], PostalCode, ManagerId)

                    VALUES(6, 'Christina', 'Robinson', '19780713', '20140615', '217 Chapel St', 'New Canton', 'VA', '23123', 2);

INSERT INTO HR.Employees(EmployeeId, FirstName, LastName, BirthDate, HireDate, HomeAddress, City, [State], PostalCode, ManagerId)

                    VALUES(7, 'Nicholas', 'Pinkston', '19771005', '20130522', '26 N James Madison Rd', 'Buckingham', 'VA', '23123', 3);

SET IDENTITY_INSERT HR.Employees OFF;

 

SET IDENTITY_INSERT Purchasing.Suppliers ON;

INSERT INTO Purchasing.Suppliers(SupplierId, SupplierName, StreetAddress, City, [State], PostalCode, Country)

                    VALUES(1, 'Pine Apple', '1 Pine Apple St.', 'Idanha', 'CA', '87201', 'USA');

INSERT INTO Purchasing.Suppliers(SupplierId, SupplierName, StreetAddress, City, [State], PostalCode, Country)

                    VALUES(2, 'IMB', '123 International Blvd', 'Los Angeles', 'CA', '89202', 'USA');

INSERT INTO Purchasing.Suppliers(SupplierId, SupplierName, StreetAddress, City, [State], PostalCode, Country)

                    VALUES(3, 'Lonovo', '33 Beijin Square', 'Beijing', 'Beijing', '100201', 'China');

INSERT INTO Purchasing.Suppliers(SupplierId, SupplierName, StreetAddress, City, [State], PostalCode, Country)

                    VALUES(4, 'Samsong', '1 Electronics Road', 'Yeongtong', 'Suwon', '30174', 'South Korea');

INSERT INTO Purchasing.Suppliers(SupplierId, SupplierName, StreetAddress, City, [State], PostalCode, Country)

                    VALUES(5, 'Canan', '12 Camera St', 'Ota', 'Tokyo', '100-0121', 'Japan');

SET IDENTITY_INSERT Purchasing.Suppliers OFF;

 

 

SET IDENTITY_INSERT Purchasing.Products ON;

INSERT INTO Purchasing.Products(ProductId, ProductName, supplierid)

                    VALUES(1, '65-Inch 4K Ultra HD Smart TV', 4);

INSERT INTO Purchasing.Products(ProductId, ProductName, supplierid)

                    VALUES(2, '60-Inch 4K Ultra HD Smart LED TV', 4);

INSERT INTO Purchasing.Products(ProductId, ProductName, supplierid)

                    VALUES(3, '3200 Lumens LED Home Theater Projector', 3);

INSERT INTO Purchasing.Products(ProductId, ProductName, supplierid)

                    VALUES(4, 'Wireless Color Photo Printer', 5);

INSERT INTO Purchasing.Products(ProductId, ProductName, supplierid)

                    VALUES(5, '6Wireless Compact Laser Printer', 2);

INSERT INTO Purchasing.Products(ProductId, ProductName, supplierid)

                    VALUES(6, 'Color Laser Printer', 2);

INSERT INTO Purchasing.Products(ProductId, ProductName, supplierid)

                    VALUES(7, '10" 16GB Android Tablet', 4);

INSERT INTO Purchasing.Products(ProductId, ProductName, supplierid)

                    VALUES(8, 'GPS Android Tablet PC', 2);

INSERT INTO Purchasing.Products(ProductId, ProductName, supplierid)

                    VALUES(9, '20.2 MP Digital Camera', 5);

SET IDENTITY_INSERT Purchasing.Products OFF;                    

 

SET IDENTITY_INSERT Purchasing.Deliveries ON;

INSERT INTO Purchasing.Deliveries(DeliveryId, ProductId, Quantity, Price, DeliveryDate)

                    VALUES(1, 1, 2, 1099.99, '20161001 9:30');

INSERT INTO Purchasing.Deliveries(DeliveryId, ProductId, Quantity, Price, DeliveryDate)

                    VALUES(2, 1, 5, 1199.99, '20161101 10:20');

INSERT INTO Purchasing.Deliveries(DeliveryId, ProductId, Quantity, Price, DeliveryDate)

                    VALUES(3, 2, 10, 1199.99, '20161002 11:10');

INSERT INTO Purchasing.Deliveries(DeliveryId, ProductId, Quantity, Price, DeliveryDate)

                    VALUES(4, 3, 10, 129.99, '20161005 9:15');

INSERT INTO Purchasing.Deliveries(DeliveryId, ProductId, Quantity, Price, DeliveryDate)

                    VALUES(5, 4, 20, 79.99, '20161007 14:00');

INSERT INTO Purchasing.Deliveries(DeliveryId, ProductId, Quantity, Price, DeliveryDate)

                    VALUES(6, 5, 15, 139.99, '20161007 15:30');

INSERT INTO Purchasing.Deliveries(DeliveryId, ProductId, Quantity, Price, DeliveryDate)

                    VALUES(7, 6, 25, 169.99, '20161010 10:30');

INSERT INTO Purchasing.Deliveries(DeliveryId, ProductId, Quantity, Price, DeliveryDate)

                    VALUES(8, 7, 12, 79.99, '20161011 11:10');

INSERT INTO Purchasing.Deliveries(DeliveryId, ProductId, Quantity, Price, DeliveryDate)

                    VALUES(9, 7, 18, 69.99, '20161012 9:50');

SET IDENTITY_INSERT Purchasing.Deliveries OFF;

 

 

SET IDENTITY_INSERT Sales.Orders ON;

INSERT INTO Sales.Orders(OrderId, CustomerId, EmployeeId, OrderDate)

                    VALUES(1, 1, 5, '20170103');

INSERT INTO Sales.Orders(OrderId, CustomerId, EmployeeId, OrderDate)

                    VALUES(2, 1, 3, '20170305');

INSERT INTO Sales.Orders(OrderId, CustomerId, EmployeeId, OrderDate)

                    VALUES(3, 2, 5, '20170223');

INSERT INTO Sales.Orders(OrderId, CustomerId, EmployeeId, OrderDate)

                    VALUES(4, 4, 5, '20170413');

INSERT INTO Sales.Orders(OrderId, CustomerId, EmployeeId, OrderDate)

                    VALUES(5, 1, 4, '20170503');

INSERT INTO Sales.Orders(OrderId, CustomerId, EmployeeId, OrderDate)

                    VALUES(6, 3, 6, '20170508');

INSERT INTO Sales.Orders(OrderId, CustomerId, EmployeeId, OrderDate)

                    VALUES(7, 5, 7, '20161108');

INSERT INTO Sales.Orders(OrderId, CustomerId, EmployeeId, OrderDate)

                    VALUES(8, 7, 2, '20161223');

SET IDENTITY_INSERT Sales.Orders OFF;

 

 

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(1, 1, 1499.99, 1);

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(1, 3, 149.99, 2);

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(2, 1, 1499.99, 1);

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(2, 4, 99.99, 6);

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(2, 6, 189.99, 5);

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(2, 2, 1599.99, 1);

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(3, 6, 199.99, 1);

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(3, 7, 109.99, 2);

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(3, 8, 69.99, 2);

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(3, 3, 159.99, 2);

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(3, 9, 1449.99, 1);

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(4, 8, 69.99, 1);

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(4, 4, 99.99, 2);

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(5, 6, 199.99, 3);

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(5, 3, 149.99, 6);

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(6, 1, 1499.99, 1);

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(7, 2, 999.99, 1);

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(8, 7, 79.99, 1);

INSERT INTO Sales.OrderDetails(OrderId, ProductId, Price, quantity)

                    VALUES(8, 8, 59.99, 2);

                    SELECT 
                        OrderId,
                        SUM(Price * Quantity) AS TotalSalesValue
                    FROM  Sales.OrderDetails
                    WHERE OrderId = 3
                    GROUP BY  OrderId;

                    SELECT 
                        ProductId,
                        SUM(Quantity * Price) AS TotalValue
                    FROM Purchasing.Deliveries
                    WHERE  ProductId = 7
                    GROUP BY  ProductId;

                    SELECT 
                        ProductId, 
                        Price
                    FROM  Sales.OrderDetails
                    WHERE  Price = (SELECT MAX(Price) FROM Sales.OrderDetails);

                    SELECT 
                        ProductId, 
                        Price
                    FROM  Purchasing.Deliveries
                    WHERE  Price = (SELECT MAX(Price) FROM Purchasing.Deliveries);




