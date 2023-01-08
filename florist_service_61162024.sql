drop DATABASE if exists florist_serive_61162024;
CREATE DATABASE florist_serive_61162024;
use florist_serive_61162024;

##Strong Entities
CREATE TABLE Employees(
	EmployeeID int auto_increment,
    f_name varchar(50) NOT NULL,
    l_name varchar(50) NOT NULL,
    gender char(1) NOT NULL,
	country varchar(25) NOT NULL,
    address varchar(255) NOT NULL,
    DOB date,
    date_of_employment date NOT NULL,
    date_of_departure date,
    emergency_contact varchar(15),
    ethnicity varchar(15) NOT NULL,
	PRIMARY KEY (EmployeeID)
);
  
CREATE TABLE Customers(
	CustomerID int auto_increment,
    address varchar(255),
    email varchar(50) NOT NULL UNIQUE,
    PRIMARY KEY(CustomerID)
);


CREATE TABLE Vehicles(
	VehicleID int auto_increment,
    manufacturer varchar(25) NOT NULL,
    vehicle_name varchar(25) NOT NULL,
    vehicle_model varchar(25) NOT NULL,
	Vehicle_type varchar(25) NOT NULL,
	plate_number varchar(15) NOT NULL UNIQUE,
    VRN varchar(30) NOT NULL UNIQUE,
    PRIMARY KEY(VehicleID)
);


CREATE TABLE Arrangements(
	ArrangementID int auto_increment,
    arrangement_name varchar(50) NOT NULL UNIQUE,
	color_scheme varchar(100) NOT NULL,
    info varchar(100) NOT NULL,
    price int NOT NULL,
    PRIMARY KEY(ArrangementID)
);


CREATE TABLE Farms(
	FarmID int auto_increment,
	farm_name varchar(50) NOT NULL,
	organic char(1) NOT NULL,
	address varchar(50) NOT NULL UNIQUE,
	city varchar(20) NOT NULL,
	country varchar(20) NOT NULL,
    PRIMARY KEY(FarmID)
);

##Employee specialization
CREATE TABLE Designer(
	EmployeeID int NOT NULL UNIQUE,
    max_qualification varchar(50) NOT NULL,
    FOREIGN KEY(EmployeeID) references Employees(EmployeeID) 
);

CREATE TABLE Horticulturalist(
	EmployeeID int NOT NULL UNIQUE,
    degree varchar(50) NOT NULL,
    FOREIGN KEY(EmployeeID) references Employees(EmployeeID) 
);

CREATE TABLE Manager(
	EmployeeID int NOT NULL UNIQUE,
    start_date date NOT NULL UNIQUE,
    end_date date,
    FOREIGN KEY(EmployeeID) references Employees(EmployeeID) 
);


CREATE TABLE Driver(
	EmployeeID int NOT NULL UNIQUE,
	drivers_license varchar(25) NOT NULL UNIQUE,
	handing char(1) NOT NULL,
	height int NOT NULL,
	sightedness varchar(25) NOT NULL,
    FOREIGN KEY(EmployeeID) references Employees(EmployeeID) 
);

CREATE TABLE Florist(
	EmployeeID int NOT NULL UNIQUE,
	packing_speed int NOT NULL,
    knotting_speed int NOT NULL,
    FOREIGN KEY(EmployeeID) references Employees(EmployeeID) 
);


###Customer specialization
CREATE TABLE IndividualCustomer(
	CustomerID int NOT NULL UNIQUE,
	f_name varchar(25) NOT NULL,
	l_name varchar(25) NOT NULL,
	gender char(1),
	DOB date NOT NULL,
	marital_status char(1),
	ethnicity varchar(25),
    FOREIGN KEY(CustomerID) references Customers(CustomerID) 
);

CREATE TABLE CompanyCustomer(
	CustomerID int NOT NULL UNIQUE,
	comp_name varchar(100) NOT NULL,
    reg_no varchar(50) NOT NULL,
	comp_type char(3)  NOT NULL,
    FOREIGN KEY(CustomerID) references Customers(CustomerID) 
);

###Specialization of Farms
CREATE TABLE InhouseFarm(
	FarmID int NOT NULL UNIQUE,
    species varchar(25) NOT NULL,
	acrage int NOT NULL,
	DOP date NOT NULL,
    exp_harvest_date date NOT NULL,
	soil_type char(5) NOT NULL,
    soil_ph int NOT NULL,
    FOREIGN KEY(FarmID) references Farms(FarmID) 
);

CREATE TABLE ExternalFarm(
	FarmID int NOT NULL UNIQUE,
    email varchar(25) NOT NULL UNIQUE,
    contact_no varchar(15) NOT NULL UNIQUE,
	admin_address varchar(100) NOT NULL,
    FOREIGN KEY(FarmID) references Farms(FarmID) 
);

####Weak entities
CREATE TABLE Products(
	ProductID int auto_increment,
	FarmID int NOT NULL,
	product_name varchar(50) NOT NULL,
	species varchar(50) NOT NULL UNIQUE,
    quantity int NOT NULL,
    price int NOT NULL,
    PRIMARY KEY(ProductID),
    FOREIGN KEY (FarmID) REFERENCES Farms(FarmID)
);

CREATE TABLE Flower(
	ProductID int NOT NULL UNIQUE,
    color varchar(15) NOT NULL,
	scent varchar(10) NOT NULL,
	texture varchar(10) NOT NULL,
	shelf_life int NOT NULL,
    FOREIGN KEY(ProductID) references Products(ProductID) 
);

CREATE TABLE Plant(
	ProductID int NOT NULL UNIQUE,
	DOP date NOT NULL,
	life_cycle varchar(25) NOT NULL,
	climate varchar(15) NOT NULL,
	max_height int NOT NULL,
	flowering char(1) NOT NULL,
    FOREIGN KEY(ProductID) references Products(ProductID) 
);


CREATE TABLE Seed(
	ProductID int NOT NULL UNIQUE,
	Flowering char(1) NOT NULL,
	Fruiting char(1) NOT NULL,
	growth_time int NOT NULL,
	climate varchar(25) NOT NULL,
	max_height int NOT NULL,
    FOREIGN KEY(ProductID) references Products(ProductID) 
);

CREATE TABLE Events(
	EventID int auto_increment,
    CustomerID int NOT NULL,
	DesignerID int NOT NULL,
    event_type varchar(25) NOT NULL,
	date_of_event date NOT NULL,
	total_cost int NOT NULL,
	city varchar(25) NOT NULL,
	country varchar(25),
	address varchar(100),
    PRIMARY KEY(EventID),
    FOREIGN KEY(CustomerID) references Customers(CustomerID),
    FOREIGN KEY(DesignerID) references Designer(EmployeeID)
);


	
####Decompositions
CREATE TABLE EventsArrangements(
	EventID int NOT NULL,
    ArrangementID int NOT NULL,
    ArrangementQuantity int NOT NULL,
	FOREIGN KEY(EventID) references Events(EventID),
    FOREIGN KEY(ArrangementID) references Arrangements(ArrangementID),
    PRIMARY KEY(EventID, ArrangementID)
);

CREATE TABLE ProductArrangements(
	ArrangementID int NOT NULL,
    ProductID int NOT NULL,
    product_quantity int NOT NULL,
    FOREIGN KEY(ProductID) references Products(ProductID),
    FOREIGN KEY(ArrangementID) references Arrangements(ArrangementID),
    PRIMARY KEY(ArrangementID, ProductID)
);
    
    
###Modelling Purchases and it's specializations as tables

CREATE TABLE Instance_of_Purchase(
	PurchaseID int auto_increment,
    CustomerID int NOT NULL,
	quantity int NOT NULL,
	total int NOT NULL,
	date_of_purchase date NOT NULL,
	mode_of_payment varchar(25),
    PRIMARY KEY(PurchaseID),
    FOREIGN KEY(CustomerID) references Customers(CustomerID)
);
	
    
CREATE TABLE Online_Instance_of_Product_Purchase(
	PurchaseID int NOT NULL UNIQUE,
    ProductID int NOT NULL,
    TransactionID varchar(40),
    time_of_purchase time NOT NULL,
    city varchar(25),
    country varchar(25) NOT NULL,
    FOREIGN KEY(PurchaseID) references Instance_of_Purchase(PurchaseID),
    FOREIGN KEY(ProductID) references Products(ProductID)
);

CREATE TABLE Online_Instance_of_Arrangement_Purchase(
	PurchaseID int NOT NULL UNIQUE,
    ArrangementID int NOT NULL,
    TransactionID varchar(40),
    time_of_purchase time NOT NULL,
    city varchar(25)NULL,
    country varchar(25) NOT NULL,
    FOREIGN KEY(PurchaseID) references Instance_of_Purchase(PurchaseID),
    FOREIGN KEY(ArrangementID) references Arrangements(ArrangementID)
);

CREATE TABLE Instore_Instance_of_Product_Purchase(
	PurchaseID int NOT NULL UNIQUE,
    FloristID int NOT NULL,
	ProductID int NOT NULL,
    FOREIGN KEY(PurchaseID) references Instance_of_Purchase(PurchaseID),
    FOREIGN KEY(FloristID) references Florist(EmployeeID),
	FOREIGN KEY(ProductID) references Products(ProductID)
);
    
    
CREATE TABLE Instore_Instance_of_Arrangement_Purchase(
	PurchaseID int NOT NULL UNIQUE,
    FloristID int NOT NULL,
	ArrangementID int NOT NULL,
    FOREIGN KEY(PurchaseID) references Instance_of_Purchase(PurchaseID),
    FOREIGN KEY(FloristID) references Florist(EmployeeID),
	FOREIGN KEY(ArrangementID) references Arrangements(ArrangementID)
);

CREATE TABLE Instance_of_Delivery(
	DeliveryID int auto_increment,
	PurchaseID int NOT NULL UNIQUE,
	VehicleID int NOT NULL,
	DriverID int NOT NULL,
	city varchar(25) NOT NULL,
	destination_address varchar(255) NOT NULL,
	expected_date_of_delivery date NOT NULL,
    date_of_delivery date,
    PRIMARY KEY(DeliveryID),
	FOREIGN KEY(PurchaseID) references Instance_of_Purchase(PurchaseID),
    FOREIGN KEY(VehicleID) references Vehicles(VehicleID),
	FOREIGN KEY(DriverID) references Driver(EmployeeID)
);

##Table representing mamager product request from farm
CREATE TABLE Instance_of_Request(
	RequestID int auto_increment,
    FarmID int NOT NULL,
	ProductID int NOT NULL,
    ManagerID int NOT NULL,
    quantity int NOT NULL,
    total_cost int NOT NULL,
	date_of_request date NOT NULL,
    date_of_delivery date,
    PRIMARY KEY(RequestID),
    FOREIGN KEY(FarmID) references Farms(FarmID),
	FOREIGN KEY(ProductID) references Products(ProductID),
    FOREIGN KEY(ManagerID) references Manager(EmployeeID)
);
    
    
###Creating telephone tables
CREATE TABLE TelephoneCustomer(
	tel_no varchar(15),
    CustomerID int,
    PRIMARY KEY(tel_no),
    FOREIGN KEY(CustomerID) references Customers(CustomerID)
);

CREATE TABLE TelephoneEmployee(
	tel_no varchar(15),
    EmployeeID int,
    PRIMARY KEY(tel_no),
    FOREIGN KEY(EmployeeID) references Employees(EmployeeID)
);
    

#### Creating Indexes
CREATE INDEX idx_destination ON Instance_of_Delivery(destination_address);
CREATE INDEX idx_color ON Flower(color);
CREATE INDEX idx_colorscheme ON Arrangements(color_scheme);
CREATE INDEX idx_ptotal ON Instance_of_purchase(total);
CREATE INDEX idx_sname ON Products(species);


###Populating Employees(6)
INSERT INTO Employees(
f_name, l_name, gender, country, address, DOB, date_of_employment 
,emergency_contact, ethnicity) 
VALUES('Chris', 'Cornell', 'M', 'Nigeria', '13 Montgomery Lane, Villenueve', 
		'1995-01-20', '2022-03-20', '+234050669332', 'Hispanic');
        
        
INSERT INTO Employees(
f_name, l_name, gender, country, address, DOB, date_of_employment 
,emergency_contact, ethnicity) 
VALUES('James', 'Dean', 'M', 'United Kingdom', '15 Ozzy Lane, Lisbourne', 
		'1992-04-22', '2022-03-20', '+10056669999', 'White');


INSERT INTO Employees(
f_name, l_name, gender, country, address, DOB, date_of_employment 
,emergency_contact, ethnicity) 
VALUES('Kurt', 'Cobain', 'M', 'United Kingdom', '2 Manchester Roads, Pits', 
		'1967-02-20', '2021-06-19', '+100544555000', 'White');


 INSERT INTO Employees(
f_name, l_name, gender, country, address, DOB, date_of_employment 
,emergency_contact, ethnicity) 
VALUES('Riley', 'Bourne', 'F', 'United Stated', '4 Cherry Lane, Kits', 
		'2001-12-30', '2022-04-15', '+14455500000', 'Black');
   
INSERT INTO Employees(
f_name, l_name, gender, country, address, DOB, date_of_employment 
,emergency_contact, ethnicity) 
VALUES('Emily', 'Star', 'F', 'Ghana', '14 Bluebird Stree, Legon', 
		'1990-07-11', '2022-04-15', '+233500708343', 'Black');
   


INSERT INTO Employees(
f_name, l_name, gender, country, address, DOB, date_of_employment 
,emergency_contact, ethnicity) 
VALUES('Kerry', 'Stone', 'F', 'China', '14 Bluebird Stree, Legon, Accra, Ghana', 
		'1990-07-11', '2022-04-15', '+233500708343', 'Chineese');
   
INSERT INTO Employees(
f_name, l_name, gender, country, address, DOB, date_of_employment 
,emergency_contact, ethnicity) 
VALUES('George', 'Stone', 'M', 'Ghana', '14 Bluebird Street, Legon, Accra, Ghana', 
		'1990-07-11', '2022-04-15', '+2335007081143', 'White');


INSERT INTO Designer(EmployeeID, max_qualification) values (3, 'Bsc.');
INSERT INTO Manager(EmployeeID, start_date) values (1, '2022-05-05');
INSERT INTO Driver(EmployeeID, drivers_license, handing, height, sightedness) values (2, 'UK-7888-444', 'R', 163, 'Normal');
INSERT INTO Florist(EmployeeID, packing_speed, knotting_speed) values(4, 6, 15);
INSERT INTO Horticulturalist(EmployeeID, degree) values(5, 'Bsc. Agriculture');
INSERT INTO Florist(EmployeeID, packing_speed, knotting_speed) values(6, 6, 12);
INSERT INTO Driver(EmployeeID, drivers_license, handing, height, sightedness) values (7, 'UB-7888-444', 'L', 162, 'Normal');

###Customers

INSERT INTO Customers(address, email) VALUES('23 Dalmatian road, Igando', 'yt.appo@gmail.com');
INSERT INTO Customers(address, email) VALUES('2 Frank road, Igando', 'yt.erin@gmail.com');
INSERT INTO Customers(address, email) VALUES('14 Lily road, Lekki', 'gary300@outlook.com');
INSERT INTO Customers(address, email) VALUES('88 Butter road, Osu', 'musahamidu@gmail.com');
INSERT INTO Customers(address, email) VALUES('25 Letterman street, Ojojo', 'jamesjacq@yahoo.com');

INSERT INTO IndividualCustomer(CustomerID, f_name, l_name, gender, DOB, marital_status, ethnicity) values(
	1, 'Mark', 'Johnson', 'M', '1970-06-09', 'M', 'White');

INSERT INTO IndividualCustomer(CustomerID, f_name, l_name, gender, DOB, marital_status, ethnicity) values(
	2, 'Betty', 'Johnson', 'F', '1980-05-11', 'M', 'Black');

INSERT INTO IndividualCustomer(CustomerID, f_name, l_name, gender, DOB, marital_status, ethnicity) values(
	3, 'Freda', 'Aimsworth', 'F', '1995-12-25', 'U', 'Hispanic');

INSERT INTO CompanyCustomer(CustomerID, comp_name, reg_no, comp_type) values(
	4, 'Harley Davidson', 'YDT-777-099', 'LTD');

INSERT INTO CompanyCustomer(CustomerID, comp_name, reg_no, comp_type) values(
	5, 'Dreamworks', 'BKT-777-099', 'PLC');

###Vehicle
INSERT INTO Vehicles(manufacturer, vehicle_name , vehicle_model, vehicle_type, plate_number, VRN) VALUES(
	'Tesla', 'Mirado', 'X809', 'Truck', 'FB-350-SDK', 'AL-443-7889');

INSERT INTO Vehicles(manufacturer, vehicle_name , vehicle_model, vehicle_type, plate_number, VRN) VALUES(
	'Tesla', 'Mirado', 'X809', 'Truck', 'DE-150-SJK', 'AL-443-7444');

INSERT INTO Vehicles(manufacturer, vehicle_name , vehicle_model, vehicle_type, plate_number, VRN) VALUES(
	'Tesla', 'Guptah', 'VT555', 'Lorry', 'RT-140-SBK', 'IG-222-7774');

INSERT INTO Vehicles(manufacturer, vehicle_name , vehicle_model, vehicle_type, plate_number, VRN) VALUES(
	'Tesla', 'Guptah', 'VT555', 'Lorry', 'BT-190-LLY', 'LK-111-3334');
    
INSERT INTO Vehicles(manufacturer, vehicle_name , vehicle_model, vehicle_type, plate_number, VRN) VALUES(
	'Volkswagen', 'Eco Bubble', 'CRX4', 'Saloon', 'BT-444-IKJ', 'KJ-112-6694');


###Arrangements
INSERT INTO Arrangements(arrangement_name, color_scheme, info, price) VALUES(
	'Peaceful Paradigm', 'PINK, WHITE, BLUE', 'Inspired by Jamaican Independence', 300);
	
INSERT INTO Arrangements(arrangement_name, color_scheme, info, price) VALUES(
	'Ghostly Glory', 'CREAM, WHITE, TAN', 'Inspired by French Revolution', 500);
    
INSERT INTO Arrangements(arrangement_name, color_scheme, info, price) VALUES(
	'Lovers Lake', 'RED, WHITE, PINK', 'Inspired by Romance', 500);
    
INSERT INTO Arrangements(arrangement_name, color_scheme, info, price) VALUES(
	'Forest of Friendship', 'LILAC', 'Inspired by Friendship. Seven distinct flowers', 500);
    
INSERT INTO Arrangements(arrangement_name, color_scheme, info, price) VALUES(
	'Man of Valor', 'BLACK, WHITE, GREEN', 'Inspired by working class men', 300);


###Farms
INSERT INTO Farms(farm_name, organic, address, city, country) VALUES(
	'Bode Farms', 'Y', '55 Dansiki Avenue, Ibeju', 'Lagos', 'Nigeria');

INSERT INTO Farms(farm_name, organic, address, city, country) VALUES(
	'Tillow Farms', 'N', '50 Majekodunmi Avenue, Festac', 'Lagos', 'Nigeria');
   
INSERT INTO Farms(farm_name, organic, address, city, country) VALUES(
	'Ackroyd Farms', 'N', '15 Osiris Close, Aben', 'Bronghafo', 'Ghana');
    
INSERT INTO Farms(farm_name, organic, address, city, country) VALUES(
	'Tepid Farms', 'Y', '50 Ikorodu lane, Festac', 'Lagos', 'Nigeria');
   
INSERT INTO Farms(farm_name, organic, address, city, country) VALUES(
	'Astute Farms', 'Y', '15 Bennington, Rue', 'Bern', 'Switzerland');
    

INSERT INTO InhouseFarm(FarmID, species, acrage, DOP, exp_harvest_date, soil_type, soil_ph) values(
	1, 'Helianthus petiolaris', 5, '2021-12-12', '2022-12-12', 'sandy', 7);
    

INSERT INTO InhouseFarm(FarmID, species, acrage, DOP, exp_harvest_date, soil_type, soil_ph) values(
	2, 'Helianthus tuberosus', 10, '2021-12-12', '2022-12-12', 'sandy', 7);
    
    
INSERT INTO InhouseFarm(FarmID, species, acrage, DOP, exp_harvest_date, soil_type, soil_ph) values(
	3, 'Dracaena trifasciata', 3, '2021-12-12', '2022-12-12', 'clay', 8);
    

INSERT INTO ExternalFarm(FarmID, email, contact_no, admin_address) values (
	4, 'tepid@gmail.com', '+2349098775443', '10 Buford Boulevard, Marina');
    
    
INSERT INTO ExternalFarm(FarmID, email, contact_no, admin_address) values (
	5, 'ackroyd@gmail.com', '+419098875223', '9 Cherry Cove, Hustor');

	
#####Products

##Flowers
INSERT INTO Products(FarmID, product_name, species, quantity, price) VALUES(
	4, 'Pink Rose',  'Rosa Caninae', 50, 60);
    
INSERT INTO Products(FarmID, product_name, species, quantity, price) VALUES(
	4, 'White Lily', 'Lilium Candidum', 30, 90);
    
 INSERT INTO Products(FarmID, product_name, species, quantity, price) VALUES(
	5, 'Red Rose', 'Rosa Rosa', 100, 70);   
    
 INSERT INTO Products(FarmID, product_name, species, quantity, price) VALUES(
	4, 'Lavender', 'Lavandula angustifolia', 50, 75); 
    
##Plants
 INSERT INTO Products(FarmID, product_name, species, quantity, price) VALUES(
	3, 'Mother-in-laws-tongue', 'Dracaena trifasciata', 100, 70);   
    
 INSERT INTO Products(FarmID, product_name, species, quantity, price) VALUES(
	4, 'Anthurium', 'Anthurium actutum', 200, 40);   
    
 INSERT INTO Products(FarmID, product_name, species, quantity, price) VALUES(
	5, 'Dumb Cane', 'Dieffenbachia seguine', 200, 40);   
    
 INSERT INTO Products(FarmID, product_name, species, quantity, price) VALUES(
	4, 'Philodendrom', 'Philodendron appendiculatum ', 60, 150);  
    
##Seeds
 INSERT INTO Products(FarmID, product_name, species, quantity, price) VALUES(
	1, 'Sunflower seed', 'Helianthus petiolaris', 20, 350);  

 INSERT INTO Products(FarmID, product_name, species, quantity, price) VALUES(
	2, 'Sunflower seed', 'Helianthus tuberosus', 20, 350);  

 INSERT INTO Products(FarmID, product_name, species, quantity, price) VALUES(
	5, 'Mum seeds', 'Chrysanthemum indicum', 40, 250);  



INSERT INTO Flower(ProductID, color, scent, texture, shelf_life) values(
1, 'PINK', 'SWEET', 'SMOOTH', 7);

INSERT INTO Flower(ProductID, color, scent, texture, shelf_life) values(
2, 'WHITE', 'LINEN', 'SMOOTH', 7);

 INSERT INTO Flower(ProductID, color, scent, texture, shelf_life) values(
3, 'RED', 'MUSKY', 'SMOOTH', 5);
  
 INSERT INTO Flower(ProductID, color, scent, texture, shelf_life) values(
4, 'LILAC', 'SWEET', 'SMOOTH', 9);
   

###Plants
 INSERT INTO Plant(ProductID, DOP, life_cycle, climate, max_height, flowering) values(
	5, '2022-10-11', 365, 'Tropical', 2, 'N');
	
 INSERT INTO Plant(ProductID, DOP, life_cycle, climate, max_height, flowering) values(
	6, '2022-10-11', 365, 'Tropical', 2, 'Y');

 INSERT INTO Plant(ProductID, DOP, life_cycle, climate, max_height, flowering) values(
	7, '2021-10-11', 800, 'Tropical', 2, 'N');
	
 INSERT INTO Plant(ProductID, DOP, life_cycle, climate, max_height, flowering) values(
	8, '2021-10-11', 800, 'Tropical', 2, 'N');
	

###Seeds

INSERT INTO Seed(ProductID ,Flowering, Fruiting, growth_time, climate, max_height) values(
	9, 'Y', 'N', '150', 'dry', '400');
    
INSERT INTO Seed(ProductID ,Flowering, Fruiting, growth_time, climate, max_height) values(
	10, 'Y', 'N', '150', 'dry', '400');
    
INSERT INTO Seed(ProductID ,Flowering, Fruiting, growth_time, climate, max_height) values(
	11, 'Y', 'N', '150', 'dry', '400');



###Populating events table 

#1
INSERT INTO Events(CustomerID, DesignerID, event_type, date_of_event, total_cost, city, country, address) 
VALUES (1, 3, 'WEDDING', '2022-10-10', 50000, 'Accra', 'Ghana', '45 Tipper road');

#2
INSERT INTO Events(CustomerID, DesignerID, event_type, date_of_event, total_cost, city, country, address) 
VALUES (2, 3, 'WEDDING', '2022-10-10', 70000, 'Accra', 'Ghana', '54 Gold road');

#3
INSERT INTO Events(CustomerID, DesignerID, event_type, date_of_event, total_cost, city, country, address) 
VALUES (2, 3, 'FUNERAL', '2021-10-10', 60000, 'Lagos', 'Nigeria', '84 Silver road');
  
#4
INSERT INTO Events(CustomerID, DesignerID, event_type, date_of_event, total_cost, city, country, address) 
VALUES (3, 3, 'FUNERAL', '2021-10-10', 40000, 'Abuja', 'Nigeria', '1 Becker road');

#5
INSERT INTO Events(CustomerID, DesignerID, event_type, date_of_event, total_cost, city, country, address) 
VALUES (1, 3, 'BABY SHOWER', '2023-09-11', 10000, 'Accra', 'Ghana', '10 Osu road');

#6
INSERT INTO Events(CustomerID, DesignerID, event_type, date_of_event, total_cost, city, country, address) 
VALUES (2, 3, 'BABY SHOWER', '2023-08-11', 20000, 'Accra', 'Ghana', '10 Fairy road');

#7
INSERT INTO Events(CustomerID, DesignerID, event_type, date_of_event, total_cost, city, country, address) 
VALUES (2, 3, 'BABY SHOWER', '2015-04-03', 15000, 'Accra', 'Ghana', '10 Fairy road');

#8
INSERT INTO Events(CustomerID, DesignerID, event_type, date_of_event, total_cost, city, country, address) 
VALUES (4, 3, 'COMPANY ANNIVERSARY', '2020-05-07', 200000, 'Accra', 'Ghana', '5 Happy road');

#9
INSERT INTO Events(CustomerID, DesignerID, event_type, date_of_event, total_cost, city, country, address) 
VALUES (4, 3, 'COMPANY ANNIVERSARY', '2018-05-07', 200000, 'Accra', 'Ghana', '5 Happy road');

#10
INSERT INTO Events(CustomerID, DesignerID, event_type, date_of_event, total_cost, city, country, address) 
VALUES (5, 3, 'WORKERS RETREAT', '2020-05-01', 50000, 'Accra', 'Ghana', '5 Happy road');


####Populating Events Arrangement
INSERT INTO EventsArrangements(EventID, ArrangementID, ArrangementQuantity) VALUES(
	1, 1, 20);
INSERT INTO EventsArrangements(EventID, ArrangementID, ArrangementQuantity) VALUES(
	2, 1, 40);
INSERT INTO EventsArrangements(EventID, ArrangementID, ArrangementQuantity) VALUES(
	2, 2, 40);
INSERT INTO EventsArrangements(EventID, ArrangementID, ArrangementQuantity) VALUES(
	5, 2, 70);
INSERT INTO EventsArrangements(EventID, ArrangementID, ArrangementQuantity) VALUES(
	10, 3, 10);
INSERT INTO EventsArrangements(EventID, ArrangementID, ArrangementQuantity) VALUES(
	10, 1, 5);
INSERT INTO EventsArrangements(EventID, ArrangementID, ArrangementQuantity) VALUES(
	6, 4, 20);
INSERT INTO EventsArrangements(EventID, ArrangementID, ArrangementQuantity) VALUES(
	4, 3, 20);
INSERT INTO EventsArrangements(EventID, ArrangementID, ArrangementQuantity) VALUES(
	7, 5, 10);
INSERT INTO EventsArrangements(EventID, ArrangementID, ArrangementQuantity) VALUES(
	6, 5, 50);


##Populating products arrangement

INSERT INTO ProductArrangements(ArrangementID, ProductID, product_quantity) VALUES(
	1, 2, 4);
INSERT INTO ProductArrangements(ArrangementID, ProductID, product_quantity) VALUES(
	1, 6, 4);
INSERT INTO ProductArrangements(ArrangementID, ProductID, product_quantity) VALUES(
	1, 3, 5);
INSERT INTO ProductArrangements(ArrangementID, ProductID, product_quantity) VALUES(
	2, 2, 3);
INSERT INTO ProductArrangements(ArrangementID, ProductID, product_quantity) VALUES(
	2, 5, 5);
INSERT INTO ProductArrangements(ArrangementID, ProductID, product_quantity) VALUES(
	3, 1, 5);
INSERT INTO ProductArrangements(ArrangementID, ProductID, product_quantity) VALUES(
	4, 2, 4);
INSERT INTO ProductArrangements(ArrangementID, ProductID, product_quantity) VALUES(
	1, 9, 2);
INSERT INTO ProductArrangements(ArrangementID, ProductID, product_quantity) VALUES(
	5, 9, 3);
INSERT INTO ProductArrangements(ArrangementID, ProductID, product_quantity) VALUES(
	4, 8, 1);    


###Filling in Purchases
INSERT INTO Instance_of_Purchase(CustomerID, quantity, total, date_of_purchase, mode_of_payment) VALUES(
	1, 50, 3000, '2022-03-03', 'CASH'); #rosa caninae
INSERT INTO Instance_of_Purchase(CustomerID, quantity, total, date_of_purchase, mode_of_payment) VALUES(
	1, 10, 900, '2022-11-03', 'MOMO'); # candium
INSERT INTO Instance_of_Purchase(CustomerID, quantity, total, date_of_purchase, mode_of_payment) VALUES(
	2, 1, 70, '2022-11-03', 'CASH'); # rosa rosa
    
    
    
INSERT INTO Instance_of_Purchase(CustomerID, quantity, total, date_of_purchase, mode_of_payment) VALUES(
	2, 10, 750, '2022-10-08', 'MOMO'); #lavender
INSERT INTO Instance_of_Purchase(CustomerID, quantity, total, date_of_purchase, mode_of_payment) VALUES(
	3, 2, 140, '2022-10-08', 'MOMO'); # dracena
INSERT INTO Instance_of_Purchase(CustomerID, quantity, total, date_of_purchase, mode_of_payment) VALUES(
	3, 4, 160, '2022-11-08', 'MOMO'); #anthuriumm



##Arrangements
INSERT INTO Instance_of_Purchase(CustomerID, quantity, total, date_of_purchase, mode_of_payment) VALUES(
	4, 20, 6000, '2022-06-08', 'TRANSFER'); #Peaceful paradigm
INSERT INTO Instance_of_Purchase(CustomerID, quantity, total, date_of_purchase, mode_of_payment) VALUES(
	4, 20, 10000, '2022-05-08', 'TRANSFER'); # Ghostly glory
INSERT INTO Instance_of_Purchase(CustomerID, quantity, total, date_of_purchase, mode_of_payment) VALUES(
	5, 100, 250000, '2022-05-08', 'TRANSFER'); #Lovers lake
INSERT INTO Instance_of_Purchase(CustomerID, quantity, total, date_of_purchase, mode_of_payment) VALUES(
	5, 10, 5000, '2022-05-08', 'TRANSFER'); # Forest of friendship
INSERT INTO Instance_of_Purchase(CustomerID, quantity, total, date_of_purchase, mode_of_payment) VALUES(
	1, 1, 300, '2022-05-08', 'TRANSFER'); #Man of valor
INSERT INTO Instance_of_Purchase(CustomerID, quantity, total, date_of_purchase, mode_of_payment) VALUES(
	3, 10, 3000, '2022-10-07', 'TRANSFER'); #Man of valor
    
    
###Online purchase of product
INSERT INTO Online_Instance_of_Product_Purchase(PurchaseID, ProductID, TransactionID, time_of_purchase, city, country) values(
	4, 4, 'BTH-98OOPLXX43', '20:55', 'Accra', 'Ghana');
INSERT INTO Online_Instance_of_Product_Purchase(PurchaseID, ProductID, TransactionID, time_of_purchase, city, country) values(
	5, 5, 'BTH-98OOPLXX42', '13:55', 'Accra', 'Ghana');
INSERT INTO Online_Instance_of_Product_Purchase(PurchaseID, ProductID, TransactionID, time_of_purchase, city, country) values(
	6, 6, 'VHY-768OOPLCC43', '09:22', 'Accra', 'Ghana');


##Online purchase of arrangement
INSERT INTO Online_Instance_of_Arrangement_Purchase(PurchaseID, ArrangementID, TransactionID,
time_of_purchase, city, country) values(7, 1, 'BT-XRT6558990', '12:34', 'Accra', 'Ghana');
INSERT INTO Online_Instance_of_Arrangement_Purchase(PurchaseID, ArrangementID, TransactionID,
time_of_purchase, city, country) values(8, 2, 'DT-XRT6558990', '06:50', 'Accra', 'Ghana');
INSERT INTO Online_Instance_of_Arrangement_Purchase(PurchaseID, ArrangementID, TransactionID,
time_of_purchase, city, country) values(9, 3, 'DT-XPT6558990', '07:50', 'Accra', 'Ghana');


###Instore instance of product purchase
INSERT INTO Instore_Instance_of_Product_Purchase(PurchaseID , FloristID, ProductID) values(
	1, 4, 1);
INSERT INTO Instore_Instance_of_Product_Purchase(PurchaseID , FloristID, ProductID) values(
	2, 4, 2);
 INSERT INTO Instore_Instance_of_Product_Purchase(PurchaseID , FloristID, ProductID) values(
	3, 6, 3);
       

###Instore purchase of arrangement
INSERT INTO Instore_Instance_of_Arrangement_Purchase(PurchaseID, FloristID, ArrangementID) values(
	10, 6, 4);
INSERT INTO Instore_Instance_of_Arrangement_Purchase(PurchaseID, FloristID, ArrangementID) values(
	11, 6, 5);
INSERT INTO Instore_Instance_of_Arrangement_Purchase(PurchaseID, FloristID, ArrangementID) values(
	12, 4, 5);
    
    

###Populating Deliveries
INSERT INTO Instance_of_Delivery(PurchaseID, VehicleID, DriverID, 
city, destination_address, expected_date_of_delivery, date_of_delivery) VALUES(
	1, 1, 2, 'Tema', 'Nkrotimkro street', '2022-03-04', '2022-03-04');
	
INSERT INTO Instance_of_Delivery(PurchaseID, VehicleID, DriverID, 
city, destination_address, expected_date_of_delivery, date_of_delivery) VALUES(
	2, 2, 2, 'Eastern Region', '31 Hefner street', '2022-11-05', '2022-11-05');
    
INSERT INTO Instance_of_Delivery(PurchaseID, VehicleID, DriverID, 
city, destination_address, expected_date_of_delivery, date_of_delivery) VALUES(
	3, 2, 2, 'Northern Region', '40 Modola street', '2022-11-05', '2022-11-05');
    
INSERT INTO Instance_of_Delivery(PurchaseID, VehicleID, DriverID, 
city, destination_address, expected_date_of_delivery, date_of_delivery) VALUES(
	4, 5, 2, 'Accra', '3 apple street', '2022-10-11', '2022-10-11');

INSERT INTO Instance_of_Delivery(PurchaseID, VehicleID, DriverID, 
city, destination_address, expected_date_of_delivery, date_of_delivery) VALUES(
	5, 1, 2, 'Accra', '7 pear drive, Osu', '2022-10-08', '2022-10-08');

INSERT INTO Instance_of_Delivery(PurchaseID, VehicleID, DriverID, 
city, destination_address, expected_date_of_delivery) VALUES(
	6, 1, 2, 'Accra', '15 Memory Lane, Adjiringanor', '2022-11-09'); ###Wasn't delivered



###Populating requests
INSERT INTO Instance_of_request(FarmID, ProductID, ManagerID, quantity, total_cost, date_of_request) VALUES(
	4, 1, 1, 50, 3000, '2022-12-03');
INSERT INTO Instance_of_request(FarmID, ProductID, ManagerID, quantity, total_cost, date_of_request) VALUES(
	4, 2, 1, 50, 3000, '2022-12-03');
INSERT INTO Instance_of_request(FarmID, ProductID, ManagerID, quantity, total_cost, date_of_request) VALUES(
	4, 1, 1, 50, 3000, '2022-12-03');
INSERT INTO Instance_of_request(FarmID, ProductID, ManagerID, quantity, total_cost, date_of_request) VALUES(
	5, 3, 1, 50, 3000, '2022-12-04');
INSERT INTO Instance_of_request(FarmID, ProductID, ManagerID, quantity, total_cost, date_of_request) VALUES(
	5, 3, 1, 50, 3000, '2022-12-04');
INSERT INTO Instance_of_request(FarmID, ProductID, ManagerID, quantity, total_cost, date_of_request) VALUES(
	5, 3, 1, 20, 1000, '2022-12-04');
INSERT INTO Instance_of_request(FarmID, ProductID, ManagerID, quantity, total_cost, date_of_request) VALUES(
	5, 7, 1, 20, 1000, '2022-12-04');
INSERT INTO Instance_of_request(FarmID, ProductID, ManagerID, quantity, total_cost, date_of_request) VALUES(
	5, 10, 1, 20, 1000, '2022-12-04');
INSERT INTO Instance_of_request(FarmID, ProductID, ManagerID, quantity, total_cost, date_of_request) VALUES(
	5, 10, 1, 20, 1000, '2022-12-04');
INSERT INTO Instance_of_request(FarmID, ProductID, ManagerID, quantity, total_cost, date_of_request) VALUES(
	5, 3, 1, 20, 1000, '2022-12-04');


##TelephoneCustomer
INSERT INTO TelephoneCustomer(tel_no, CustomerID) VALUES(
	+23490900000000, 1);
INSERT INTO TelephoneCustomer(tel_no, CustomerID) VALUES(
	+23490900000001, 1);
INSERT INTO TelephoneCustomer(tel_no, CustomerID) VALUES(
	+23390900000002, 2);
INSERT INTO TelephoneCustomer(tel_no, CustomerID) VALUES(
	+23390900000003, 2);
INSERT INTO TelephoneCustomer(tel_no, CustomerID) VALUES(
	+23390900000004, 3);
INSERT INTO TelephoneCustomer(tel_no, CustomerID) VALUES(
	+23390900000005, 3);
INSERT INTO TelephoneCustomer(tel_no, CustomerID) VALUES(
	+2440900000005, 4);
INSERT INTO TelephoneCustomer(tel_no, CustomerID) VALUES(
	+2440900000006, 4);
INSERT INTO TelephoneCustomer(tel_no, CustomerID) VALUES(
	+10900000044, 5);
 INSERT INTO TelephoneCustomer(tel_no, CustomerID) VALUES(
	+233090000002, 5);
    
    
##TelephoneEmployee
INSERT INTO TelephoneEmployee(tel_no, EmployeeID) VALUES(
	+2331111111111, 1);
INSERT INTO TelephoneEmployee(tel_no, EmployeeID) VALUES(
	+2331111111112, 1);
INSERT INTO TelephoneEmployee(tel_no, EmployeeID) VALUES(
	+2331111111113, 2);
INSERT INTO TelephoneEmployee(tel_no, EmployeeID) VALUES(
	+2331111111114, 2);
INSERT INTO TelephoneEmployee(tel_no, EmployeeID) VALUES(
	+2331111111115, 3);
INSERT INTO TelephoneEmployee(tel_no, EmployeeID) VALUES(
	+441111111115, 3);
INSERT INTO TelephoneEmployee(tel_no, EmployeeID) VALUES(
	+441111111166, 4);
INSERT INTO TelephoneEmployee(tel_no, EmployeeID) VALUES(
	+441111111167, 5);
INSERT INTO TelephoneEmployee(tel_no, EmployeeID) VALUES(
	+441111114441, 6);
INSERT INTO TelephoneEmployee(tel_no, EmployeeID) VALUES(
	+2551111114991, 6);
       

##QUERIES

###Select an arrangement that has been used in a wedding with a color pink(Functionality2)
SELECT * FROM Arrangements WHERE Arrangements.color_scheme LIKE '%PINK%' AND ArrangementID IN(
SELECT EventsArrangements.ArrangementID FROM EventsArrangements WHERE EventsArrangements.EventID IN(
	SELECT Events.EventID FROM Events WHERE Events.event_type = 'WEDDING'));


###View the information of customers who have ever made a purchase(Functionality6)
SELECT IndividualCustomer.f_name, IndividualCustomer.l_name, Instance_of_purchase.PurchaseID
FROM IndividualCustomer
LEFT JOIN Instance_of_purchase ON IndividualCustomer.CustomerID = Instance_of_purchase.CustomerID
ORDER BY IndividualCustomer.l_name; 


###View the products and the farms that they come from, and whether or not they are organic(Functionality5)
SELECT Products.species, Farms.farm_name, Farms.FarmID, Farms.organic
FROM Products
INNER JOIN Farms ON Products.FarmID = Farms.FarmID
ORDER BY Products.species;

##Know which products an ethnicity is buying(Functionality1)
SELECT Products.species, IndividualCustomer.ethnicity FROM Products, IndividualCustomer 
WHERE IndividualCustomer.ethnicity IN ('Hispanic' ,'White') ORDER BY IndividualCustomer.ethnicity;


##Find out the number of deliveries a driver has made in accra or tema(Functionality3)
SELECT COUNT(Instance_of_delivery.DriverID) FROM Instance_of_delivery 
WHERE Instance_of_delivery.DriverID = 2 AND Instance_of_delivery.city IN ('Accra', 'Tema');


##Find out the flowers that cost more than 50 cedes and if it's from an organic farm or not(Functionality4)
SELECT Products.ProductID, Products.species, Products.price, Flower.color, Farms.organic FROM Products, Flower, Farms WHERE Products.ProductID = Flower.ProductID AND
Products.price > 50 AND Products.FarmID = Farms.FarmID
ORDER BY Products.price;


