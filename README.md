# FlorenceFamilyFlowers
A database project designed to cater to the various needs of a hypothetical Flower shop.


About Florence’s Family Flowers

Plants are very important to society, as they provide oxygen, absorb carbon dioxide, supply 
nutrients to the soil and serve as food for other creatures. Flowers, in tandem with bees, are 
responsible for pollination, making plants and flowers the base of the food chain.
Flowers have been known for centuries to provide scents and decoration to humans' lives and 
have a positive psychological impact on many people. Flowers are used as gifts, wedding 
ornaments, funeral placements, party decorations, etc. Plants have different life cycles that 
determine when they grow, appropriate climates, and maximum height attainable. Flowers 
always have a life expectancy(shelf life) outside of its host plant.
Florence's Family Flowers is an environmentally conscious company in Ghana dedicated to 
caring for and selling plants, flowers, and seeds. Our mission is to reach as many people as 
possible and restore a love for nature in them, regardless of biases associated with race or 
marital status. Our target customer list is extensive, as both the young and old, male or female, 
should partake in the etiquette of flower gifting and the environmental duty of botany. 
However, we know that females, above middle-income persons, couples, environmentalists 
and companies are our most frequent customers.
We do nationwide deliveries and deliver all our products in eco-friendly electric vehicles 
designed to properly cool and preserve our products. We have in-house drivers that drive our 
vehicles. In the future, we want to ensure that the products we purchase are also delivered in 
an environmentally friendly manner. We currently outsource from farms and have our farms, 
which produce a range of organic and safe inorganic plants. Some of our employees are 
horticulturalists who manage our farms.
Our company provides readymade flower arrangements for events, including our plants and 
flowers. An in-house designer typically oversees these events. Our arrangements are, however, 
available only in theory to avoid the wastage of resources. Arrangements are pieced together 
after payment. Florists usually piece together arrangements, dust the shop or engage with 
customers. 
The company is non-departmental, as we believe in a flat non-hierarchical structure to promote 
equity and socialism. We have a managerial position that is rotated yearly, and it is the 
managers duty to order new products from the external farms.



**Assumptions**
● Participation in Employee specialisation is mandatory, or.
● The company wants a history of all records.
● A driver delivers a product
● All products are natural
● Florence family flowers do not financially cater for dependents or spouses.
● You have to create an account with Florence’s Family, before shopping online
● You must provide information before shopping in person, for accounting purposes
● Employees and customers can originate from different parts of the world.
● Florence’s family charges in cedis.


Functionalities
1. See what products are popular with an ethnicity.
2. See what arrangements having a particular colour in their scheme are used in an event.
3. Check the number of times a driver has been to a list of cities.
4. Find out the flowers that are above a certain price.
5. Find out the farms that produce each product.
6. See all customers and their purchases.


Enterprise Rules
● A farm can supply to a variety of plants and flowers of different species
● A product is supplied by one farm and one farm only
● A designer can manage many events
● An event is managed by one designer only
● A product can be used by zero or more arrangements
● An event can use one or more arrangements
● A customer can have zero or more events
● An event is held by one customer and one customer only
● An arrangement can be used by zero or more events
● A delivery is made by one driver only
● A driver can have many deliveries
● A purchase can only be delivered once
● A vehicle can deliver 0 or more deliveries
● A delivery can be made in one vehicle and one vehicle only
● A customer can purchase 0 or more products
● A customer can purchase 0 or more arrangements
● An arrangement can be purchased by zero or more customers
● A product can be purchased by zero or more customers
● A purchase can either be in-store product or in-store arrangement or online product or 
online arrangement purchase.
● An employee can only be one of the following: designer, driver, horticulturist, florist, 
manager.
● A customer can either be an individual or company, not both.
● A product can only either be a plant, flower or seed.
● A farm can only either be in-house or external
● A phone number belongs to one customer and one customer only
● A phone number belongs to one employee and one employee only
● A customer can have many phone numbers
● An employee can have many phone numbers
● A request is made by one manager only
● A manager can make as many requests as needed
● A horticulturists works at one inhouse farm and one inhouse farm only
● An inhouse farm has a minimum of 1 horticulturists and a maximum of 10
● An external farm can be requested from zero or many times
● A request is made to one farm and one farm only



Key notes
● Handedness indicates left or right-handed driver
● Height is in metres
● Y/N means Yes and No
● DOP means date of planting




Strong Entities and their non key attributes
Employees(GEN)
firstname lastname, gender, country, address, DOB, date_of_employment, date_of_departure 
date, emergency_contact, ethnicity
Designer(SPEC)(max_qualification)
Horticulturalist(SPEC)(degree)
Manager(SPEC)(start_date date, end_date date)
Driver(SPEC)(drivers_license, handing, height, sightedness)
Florist(SPEC)(packing_speed, knotting_speed)
Customers(GEN)
address, email
IndividualCustomer(SPEC)(f_name, l_name, gender, DOB, marital_status, ethnicity)
CompanyCustomer(SPEC)(comp_name, reg_no, comp_type)
Vehicles
manufacturer, vehicle_name, vehicle_model, vehicle_type, plate_number, VRN
Arrangements
arrangement_name, color_scheme, info, price
Farms(GEN)
farm_name, address, city, country
InhouseFarm(SPEC)(species, acrage, DOP, exp_harvest_date, soil_type, soil_ph)
ExternalFarm(SPEC)(email, contact_no, admin_address)
Weak entities and their non-key attributes
Products(GEN)
product_name, species, quantity, price
Flower(SPEC)(color, scent, texture, shelf_life)
Plant(SPEC)(DOP, life_cycle, climate, max_height, flowering)
Seed(SPEC)(Flowering, Fruiting, growth_time, climate, max_height)
Events
event_type, date_of_event, total_cost, city, country, address
EventsArrangements
ArrangementQuantity
ProductArrangements
Product_quantity
Instance_of_purchase(GEN)
quantity, total, date_of_purchase date, mode_of_payment
online_instance_of_product_purchase(SPEC)(TransactionID, time_of_purchase, city, 
country)
online_instance_of_arrangement_purchase(SPEC)(TransactionID, time_of_purchase, city, 
country)
In-store_instance_of_product_purchase(SPEC)()
In-store_instance_of_arrangement_purchase(SPEC)()
Instance_of_delivery
city, destination_address, expected_date_of_delivery, date_of_delivery
Instance_of_request
quantity, total_cost, date_of_request, date_of_delivery
TelephoneCustomer()
TelephoneEmployee()
Logical Table Derivation
● Employees(GEN)(EmployeeID, firstname lastname, gender, country, address, DOB, 
date_of_employment, date_of_departure date, emergency_contact, ethnicity)
a. Designer(SPEC)(EmployeeID, max_qualification)
b. Horticulturalist(SPEC)(EmployeeID, degree)
c. Manager(SPEC)(EmployeeID, start_date date, end_date date)
d. Driver(SPEC)(EmployeeID, drivers_license, handing, height, sightedness)
e. Florist(SPEC)(EmployeeID, packing_speed, knotting_speed)
● Customers(GEN)(CustomerID, address, email)
a. IndividualCustomer(SPEC)(CustomerID, f_name, l_name, gender, DOB, 
marital_status, ethnicity)
b. CompanyCustomer(SPEC)(CustomerID, comp_name, reg_no, comp_type)
● Vehicles(VehicleID, manufacturer, vehicle_name, vehicle_model, vehicle_type, 
plate_number, VRN)
● Arrangements(ArrangementID, arrangement_name, color_scheme, info, price)
● Farms(FarmID, farm_name, address, city, country)
a. InhouseFarm(SPEC)(FarmID, species, acrage, DOP, exp_harvest_date, 
soil_type char, soil_ph)
b. ExternalFarm(SPEC)(FarmID, email, contact_no, admin_address)
● Products(GEN)(ProductID, FarmID, product_name, species, quantity, price)
a. Flower(SPEC)(ProductID, color, scent, texture, shelf_life)
b. Plant(SPEC)(ProductID, DOP, life_cycle, climate, max_height, flowering)
c. Seed(SPEC)(ProductID, Flowering, Fruiting, growth_time, climate, 
max_height)
● Events(EventID, CustomerID, DesignerID, event_type, date_of_event, total_cost, 
city, country, address)
● EventsArrangements(EventID, ArrangementID, ArrangementQuantity)
● ProductArrangements(ArrangementID, ProductID, product_quantity)
● Instance_of_purchase(GEN)(PurchaseID, CustomerID, quantity, total, 
date_of_purchase date, mode_of_payment)
a. Online_instance_of_product_purchase(SPEC)(PurchaseID, ProductID, 
TransactionID, time_of_purchase, city, country)
b. Online_instance_of_arrangement_purchase(SPEC)(PurchaseID,
ArrangementID, TransactionID, time_of_purchase, city, country)
c. In-store_instance_of_product_purchase(SPEC)(PurchaseID, FloristID, 
ProductID)
d. In-store_instance_of_arrangement_purchase(SPEC)(PurchaseID, FloristID, 
ArrangementID)
● Instance_of_delivery(DeliveryID, PurchaseID, VehicleID, DriverID, city, 
destination_address, expected_date_of_delivery, date_of_delivery)
● Instance_of_request(RequestID, FarmID, ProductID, ManagerID, quantity, 
total_cost, date_of_request, date_of_delivery)
● TelephoneCustomer(tel_no, CustomerID)
● TelephoneEmployee(tel_no, EmployeeID)
Indexes
##Make it easier and faster to look up the destination of deliveries
CREATE INDEX idx_destination ON Instance_of_Delivery(destination_address);
##Make it easier for a customer to look up a color of a flower
CREATE INDEX idx_color ON Flower(color);
##Make it easier for a customer to look up the colorscheme of an arrangement
CREATE INDEX idx_colorscheme ON Arrangements(color_scheme);
##Make it easier to get accounting figures
CREATE INDEX idx_ptotal ON Instance_of_purchase(total);
##Make it easier to look up a product by species
CREATE INDEX idx_sname ON Products(species);
QUERIES
Functionality 2
SELECT * FROM Arrangements WHERE Arrangements.color_scheme LIKE '%PINK%' 
AND ArrangementID IN(
SELECT EventsArrangements.ArrangementID FROM EventsArrangements WHERE 
EventsArrangements.EventID IN(
SELECT Events.EventID FROM Events WHERE Events.event_type = 'WEDDING'));
Functionality 6
SELECT IndividualCustomer.f_name, IndividualCustomer.l_name, 
Instance_of_purchase.PurchaseID
FROM IndividualCustomer
LEFT JOIN Instance_of_purchase ON IndividualCustomer.CustomerID = 
Instance_of_purchase.CustomerID
ORDER BY IndividualCustomer.l_name; 
Functionality5
###View the products and the farms that they come from, and whether or not they are 
organic
SELECT Products.species, Farms.farm_name, Farms.FarmID, Farms.organic
FROM Products
INNER JOIN Farms ON Products.FarmID = Farms.FarmID
ORDER BY Products.species;
Functionality 1
##Know which products an ethnicity is buying
SELECT Products.species, IndividualCustomer.ethnicity FROM Products, 
IndividualCustomer 
WHERE IndividualCustomer.ethnicity IN ('Hispanic' ,'White') ORDER BY 
IndividualCustomer.ethnicity;
Functionality3
##Find out the number of deliveries a driver has made in accra or tema
SELECT COUNT(Instance_of_delivery.DriverID) FROM Instance_of_delivery 
WHERE Instance_of_delivery.DriverID = 2 AND Instance_of_delivery.city IN ('Accra', 
'Tema');
Functionality 4
##Find out the flowers that cost more than 50 cedes and if it's from an organic farm or not
SELECT Products.ProductID, Products.species, Products.price, Flower.color, 
Farms.organic FROM Products, Flower, Farms WHERE Products.ProductID = 
Flower.ProductID AND
Products.price > 50 AND Products.FarmID = Farms.FarmID
ORDER BY Products.price;
