-- main moduel
BEGIN;
CREATE TABLE IF NOT EXISTS actor (
 id integer NOT NULL,
 name varchar(50) DEFAULT NULL,
 PRIMARY KEY (id)
);
CREATE INDEX actorname ON actor (name);
COMMIT;
BEGIN;
CREATE TABLE IF NOT EXISTS casting (
 movieid integer NOT NULL DEFAULT 0,
 actorid integer NOT NULL DEFAULT 0,
 ord integer NOT NULL DEFAULT 0,
 PRIMARY KEY (movieid,actorid,ord)
);
CREATE INDEX castact ON casting (actorid);
COMMIT;
CREATE TABLE IF NOT EXISTS dept (
 id integer NOT NULL,
 name varchar(50) DEFAULT NULL,
 PRIMARY KEY (id) 
);
CREATE TABLE IF NOT EXISTS eteam (
 id varchar(3) DEFAULT NULL,
 teamname varchar(50) DEFAULT NULL,
 coach varchar(50) DEFAULT NULL 
);
CREATE TABLE IF NOT EXISTS game (
 id integer DEFAULT NULL,
 mdate varchar(12) DEFAULT NULL,
 stadium varchar(100) DEFAULT NULL,
 team1 varchar(100) DEFAULT NULL,
 team2 varchar(100) DEFAULT NULL 
);
CREATE TABLE IF NOT EXISTS ge (
 yr integer NOT NULL,
 firstName varchar(40) NOT NULL,
 lastName varchar(40) NOT NULL,
 constituency varchar(10) NOT NULL,
 party varchar(50) DEFAULT NULL,
 votes integer DEFAULT NULL,
 PRIMARY KEY (yr,firstName,lastName,constituency) 
);
CREATE TABLE IF NOT EXISTS goal (
 matchid integer NOT NULL DEFAULT 0,
 teamid varchar(3) DEFAULT NULL,
 player varchar(100) DEFAULT NULL,
 gtime integer NOT NULL DEFAULT 0,
 PRIMARY KEY (matchid,gtime) 
);
BEGIN;
CREATE TABLE IF NOT EXISTS movie (
 id integer NOT NULL,
 title varchar(50) DEFAULT NULL,
 yr integer DEFAULT NULL,
 director integer DEFAULT NULL,
 budget integer DEFAULT NULL,
 gross integer DEFAULT NULL,
 PRIMARY KEY (id)
);
CREATE INDEX director ON movie (director);
CREATE INDEX movietitle ON movie (title);
COMMIT;
CREATE TABLE IF NOT EXISTS nobel (
 yr integer DEFAULT NULL,
 subject varchar(15) DEFAULT NULL,
 winner varchar(50) DEFAULT NULL 
);
BEGIN;
CREATE TABLE IF NOT EXISTS nss (
 ukprn varchar(8) NOT NULL,
 institution varchar(100) DEFAULT NULL,
 subject varchar(60) NOT NULL DEFAULT '',
 level varchar(50) NOT NULL DEFAULT '',
 question varchar(10) NOT NULL DEFAULT '',
 "A_STRONGLY_DISAGREE" integer DEFAULT NULL,
 "A_DISAGREE" integer DEFAULT NULL,
 "A_NEUTRAL" integer DEFAULT NULL,
 "A_AGREE" integer DEFAULT NULL,
 "A_STRONGLY_AGREE" integer DEFAULT NULL,
 "A_NA" integer DEFAULT NULL,
 "CI_MIN" integer DEFAULT NULL,
 score integer DEFAULT NULL,
 "CI_MAX" integer DEFAULT NULL,
 response integer DEFAULT NULL,
 sample integer DEFAULT NULL,
 aggregate char(1) DEFAULT NULL,
 PRIMARY KEY (ukprn,subject,level,question)
);
CREATE INDEX nss_question ON nss (question);
CREATE INDEX nss_subject ON nss (subject);
COMMIT;
BEGIN;
CREATE TABLE IF NOT EXISTS route (
 num varchar(5) NOT NULL,
 company varchar(3) NOT NULL,
 pos integer NOT NULL,
 stop integer DEFAULT NULL,
 PRIMARY KEY (num,company,pos)
);
CREATE INDEX stop ON route (stop);
COMMIT;
CREATE TABLE IF NOT EXISTS stops (
 id integer NOT NULL,
 name varchar(30) DEFAULT NULL,
 PRIMARY KEY (id) 
);
BEGIN;
CREATE TABLE IF NOT EXISTS teacher (
 id integer NOT NULL,
 dept integer DEFAULT NULL,
 name varchar(50) DEFAULT NULL,
 phone varchar(50) DEFAULT NULL,
 mobile varchar(50) DEFAULT NULL,
 PRIMARY KEY (id)
);
CREATE INDEX teacher_dept ON teacher (dept);
COMMIT;
BEGIN;
CREATE TABLE IF NOT EXISTS world (
 name varchar(50) NOT NULL,
 continent varchar(60) DEFAULT NULL,
 area decimal(10,0) DEFAULT NULL,
 population decimal(11,0) DEFAULT NULL,
 gdp decimal(14,0) DEFAULT NULL,
 capital varchar(60) DEFAULT NULL,
 tld varchar(5) DEFAULT NULL,
 flag varchar(255) DEFAULT NULL,
 PRIMARY KEY (name)
);
CREATE INDEX world_continent ON world (continent);
COMMIT;
-- Advanced challenges
-- 1. Module feedback
CREATE TABLE IF NOT EXISTS "INS_CAT" (
  "CAT_CODE" varchar(8) NOT NULL,
  "CAT_NAME" varchar(100) DEFAULT NULL,
  "CAT_SNAM" varchar(10) DEFAULT NULL,
  PRIMARY KEY ("CAT_CODE")
);
CREATE TABLE IF NOT EXISTS "INS_PRS" (
  "PRS_CODE" char(8) NOT NULL,
  "PRS_FNM1" varchar(100) DEFAULT NULL,
  "PRS_SURN" varchar(100) DEFAULT NULL,
  PRIMARY KEY ("PRS_CODE")
);
BEGIN;
CREATE TABLE IF NOT EXISTS "INS_MOD" (
  "MOD_CODE" char(8) NOT NULL,
  "MOD_NAME" varchar(100) DEFAULT NULL,
  "PRS_CODE" char(8) DEFAULT NULL,
  PRIMARY KEY ("MOD_CODE"),
  CONSTRAINT "INS_MOD_ibfk_1" FOREIGN KEY ("PRS_CODE") REFERENCES "INS_PRS" ("PRS_CODE")
);
CREATE INDEX "idx_PRS_CODE" ON "INS_MOD" ("PRS_CODE");
COMMIT;
CREATE TABLE IF NOT EXISTS "INS_SPR" (
  "SPR_CODE" char(8) NOT NULL,
  "SPR_FNM1" varchar(100) DEFAULT NULL,
  "SPR_SURN" varchar(100) DEFAULT NULL,
  PRIMARY KEY ("SPR_CODE")
);
BEGIN;
CREATE TABLE IF NOT EXISTS "CAM_SMO" (
  "SPR_CODE" char(8) NOT NULL,
  "MOD_CODE" char(8) NOT NULL,
  "AYR_CODE" char(7) NOT NULL,
  "PSL_CODE" char(3) NOT NULL,
  PRIMARY KEY ("SPR_CODE","MOD_CODE","AYR_CODE","PSL_CODE"),
  CONSTRAINT "CAM_SMO_ibfk_1" FOREIGN KEY ("MOD_CODE") REFERENCES "INS_MOD" ("MOD_CODE"),
  CONSTRAINT "CAM_SMO_ibfk_2" FOREIGN KEY ("SPR_CODE") REFERENCES "INS_SPR" ("SPR_CODE")
);
CREATE INDEX "idx_MOD_CODE" ON "CAM_SMO" ("MOD_CODE");
COMMIT;
CREATE TABLE IF NOT EXISTS "INS_RES" (
  "SPR_CODE" char(8) NOT NULL,
  "MOD_CODE" char(8) NOT NULL,
  "AYR_CODE" char(7) NOT NULL,
  "PSL_CODE" char(3) NOT NULL,
  "QUE_CODE" varchar(8) NOT NULL,
  "RES_VALU" integer DEFAULT NULL,
  PRIMARY KEY ("SPR_CODE","MOD_CODE","AYR_CODE","PSL_CODE","QUE_CODE"),
  CONSTRAINT "INS_RES_ibfk_1" FOREIGN KEY ("SPR_CODE","MOD_CODE","AYR_CODE","PSL_CODE") REFERENCES "CAM_SMO" ("SPR_CODE","MOD_CODE","AYR_CODE","PSL_CODE")
);
BEGIN;
CREATE TABLE IF NOT EXISTS "INS_QUE" (
  "QUE_CODE" varchar(8) NOT NULL,
  "CAT_CODE" varchar(8) DEFAULT NULL,
  "QUE_NAME" varchar(100) DEFAULT NULL,
  "QUE_TEXT" varchar(100) DEFAULT NULL,
  PRIMARY KEY ("QUE_CODE"),
  CONSTRAINT "INS_QUE_ibfk_1" FOREIGN KEY ("CAT_CODE") REFERENCES "INS_CAT" ("CAT_CODE")
);
CREATE INDEX "idx_CAT_CODE" ON "INS_QUE" ("CAT_CODE");
COMMIT;
-- 2. Help desk
CREATE TABLE IF NOT EXISTS "Shift_type" (
  "Shift_type" varchar(7) NOT NULL,
  "Start_time" varchar(5) DEFAULT NULL,
  "End_time" varchar(5) DEFAULT NULL,
  PRIMARY KEY ("Shift_type")
);
CREATE TABLE IF NOT EXISTS "Level" (
  "Level_code" integer NOT NULL,
  "Manager" char(1) DEFAULT NULL,
  "Operator" char(1) DEFAULT NULL,
  "Engineer" char(1) DEFAULT NULL,
  PRIMARY KEY ("Level_code")
);
BEGIN;
CREATE TABLE IF NOT EXISTS "Caller" (
  "Caller_id" SERIAL,
  "Company_ref" integer DEFAULT NULL,
  "First_name" varchar(50) DEFAULT NULL,
  "Last_name" varchar(50) DEFAULT NULL,
  PRIMARY KEY ("Caller_id")
);
CREATE INDEX "idx_Company_ref" ON "Caller" ("Company_ref");
ALTER sequence "Caller_Caller_id_seq" RESTART WITH 149;
COMMIT;
BEGIN;
CREATE TABLE IF NOT EXISTS "Customer" ( 
  "Company_ref" integer NOT NULL,
  "Company_name" varchar(50) DEFAULT NULL,
  "Contact_id" integer DEFAULT NULL,
  "Address_1" varchar(50) DEFAULT NULL,
  "Address_2" varchar(50) DEFAULT NULL,
  "Town" varchar(50) DEFAULT NULL,
  "Postcode" varchar(50) DEFAULT NULL,
  "Telephone" varchar(50) DEFAULT NULL,
  PRIMARY KEY ("Company_ref"),
  CONSTRAINT "Cust_FK" FOREIGN KEY ("Contact_id") REFERENCES "Caller" ("Caller_id"),
  CONSTRAINT "Caller_ibfk_1" FOREIGN KEY ("Company_ref") REFERENCES "Customer" ("Company_ref")
);
CREATE INDEX "Cust_FK" ON "Customer" ("Contact_id");
COMMIT;
BEGIN;
CREATE TABLE IF NOT EXISTS "Staff" (
  "Staff_code" varchar(6) NOT NULL,
  "First_name" varchar(50) DEFAULT NULL,
  "Last_name" varchar(50) DEFAULT NULL,
  "Level_code" integer NOT NULL,
  PRIMARY KEY ("Staff_code"),
  CONSTRAINT "Staff_ibfk_1" FOREIGN KEY ("Level_code") REFERENCES "Level" ("Level_code")
);
CREATE INDEX "idx_Level_code" ON "Staff" ("Level_code");
COMMIT;
BEGIN;
CREATE TABLE IF NOT EXISTS "Shift" (
  "Shift_date" date NOT NULL,
  "Shift_type" varchar(7) NOT NULL,
  "Manager" varchar(7) NOT NULL,
  "Operator" varchar(7) NOT NULL,
  "Engineer1" varchar(7) NOT NULL,
  "Engineer2" varchar(7) DEFAULT NULL,
  PRIMARY KEY ("Shift_date","Shift_type"),
  CONSTRAINT "Shift_ibfk_1" FOREIGN KEY ("Manager") REFERENCES "Staff" ("Staff_code"),
  CONSTRAINT "Shift_ibfk_2" FOREIGN KEY ("Operator") REFERENCES "Staff" ("Staff_code"),
  CONSTRAINT "Shift_ibfk_3" FOREIGN KEY ("Engineer1") REFERENCES "Staff" ("Staff_code"),
  CONSTRAINT "Shift_ibfk_4" FOREIGN KEY ("Engineer2") REFERENCES "Staff" ("Staff_code"),
  CONSTRAINT "Shift_ibfk_5" FOREIGN KEY ("Shift_type") REFERENCES "Shift_type" ("Shift_type")
);
CREATE INDEX "idx_Manager" ON "Shift" ("Manager");
CREATE INDEX "idx_Operator" ON "Shift" ("Operator");
CREATE INDEX "idx_Engineer1" ON "Shift" ("Engineer1");
CREATE INDEX "idx_Engineer2" ON "Shift" ("Engineer2");
CREATE INDEX "idx_Shift_type" ON "Shift" ("Shift_type");
COMMIT;
BEGIN;
CREATE TABLE IF NOT EXISTS "Issue" (
  "Call_date" timestamp NOT NULL,
  "Call_ref" integer NOT NULL,
  "Caller_id" integer NOT NULL,
  "Detail" varchar(255) DEFAULT NULL,
  "Taken_by" varchar(6) NOT NULL,
  "Assigned_to" varchar(6) NOT NULL,
  "Status" varchar(10) DEFAULT NULL,
  PRIMARY KEY ("Call_ref"),
  CONSTRAINT "Issue_ibfk_1" FOREIGN KEY ("Taken_by") REFERENCES "Staff" ("Staff_code"),
  CONSTRAINT "Issue_ibfk_2" FOREIGN KEY ("Assigned_to") REFERENCES "Staff" ("Staff_code"),
  CONSTRAINT "Issue_ibfk_3" FOREIGN KEY ("Caller_id") REFERENCES "Caller" ("Caller_id")
);
CREATE INDEX "idx_Taken_by" ON "Issue" ("Taken_by");
CREATE INDEX "idx_Assigned_to" ON "Issue" ("Assigned_to");
CREATE INDEX "idx_Caller_id" ON "Issue" ("Caller_id");
COMMIT;
-- 3. Guest house
CREATE TABLE IF NOT EXISTS room_type (
  id varchar(6) NOT NULL,
  description varchar(100) DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS rate (
  room_type varchar(6) NOT NULL DEFAULT '',
  occupancy integer NOT NULL DEFAULT 0,
  amount decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (room_type,occupancy),
  CONSTRAINT rate_ibfk_1 FOREIGN KEY (room_type) REFERENCES room_type (id)
);
BEGIN;
CREATE TABLE IF NOT EXISTS room (
  id integer NOT NULL, 
  room_type varchar(6) DEFAULT NULL,
  max_occupancy integer DEFAULT NULL, 
  PRIMARY KEY (id), 
  CONSTRAINT room_ibfk_1 FOREIGN KEY (room_type) REFERENCES room_type (id)
);
CREATE INDEX "room_typeIDX" ON room (room_type);
COMMIT;
CREATE TABLE IF NOT EXISTS extra (
  extra_id integer NOT NULL, 
  booking_id integer DEFAULT NULL, 
  description varchar(50) DEFAULT NULL, 
  amount decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (extra_id)
);
CREATE TABLE IF NOT EXISTS guest (
  id integer NOT NULL, 
  first_name varchar(50) DEFAULT NULL, 
  last_name varchar(50) DEFAULT NULL, 
  address varchar(50) DEFAULT NULL, 
  PRIMARY KEY (id)
);
BEGIN;
CREATE TABLE IF NOT EXISTS booking (
  booking_id integer NOT NULL, 
  booking_date date DEFAULT NULL, 
  room_no integer DEFAULT NULL,
  guest_id integer NOT NULL, 
  occupants integer NOT NULL DEFAULT 1, 
  room_type_requested varchar(6) DEFAULT NULL, 
  nights integer NOT NULL DEFAULT 1, 
  arrival_time varchar(5) DEFAULT NULL, 
  PRIMARY KEY (booking_id), 
  CONSTRAINT booking_ibfk_1 FOREIGN KEY (room_no) REFERENCES room (id), 
  CONSTRAINT booking_ibfk_2 FOREIGN KEY (guest_id) REFERENCES guest (id), 
  CONSTRAINT booking_ibfk_3 FOREIGN KEY (room_type_requested) REFERENCES room_type (id), 
  CONSTRAINT booking_ibfk_4 FOREIGN KEY (room_type_requested,occupants) REFERENCES rate (room_type,occupancy)
);
CREATE INDEX "room_no_IDX" ON booking (room_no);
CREATE INDEX "guest_id_IDX" ON booking (guest_id);
CREATE INDEX "room_type_requested_IDX" ON booking (room_type_requested,occupants);
COMMIT;
-- 4. Adventure works
CREATE TABLE IF NOT EXISTS "CustomerAW" (
  "CustomerID" integer NOT NULL, 
  "NameStyle" varchar(50) NOT NULL DEFAULT '0', 
  "Title" varchar(8) DEFAULT NULL, 
  "FirstName" varchar(50) NOT NULL, 
  "MiddleName" varchar(50) DEFAULT NULL, 
  "LastName" varchar(50) NOT NULL, 
  "Suffix" varchar(10) DEFAULT NULL, 
  "CompanyName" varchar(128) DEFAULT NULL, 
  "SalesPerson" varchar(256) DEFAULT NULL, 
  "EmailAddress" varchar(50) DEFAULT NULL,
  "Phone" varchar(25) DEFAULT NULL, 
  "PasswordHash" varchar(128) NOT NULL, 
  "PasswordSalt" varchar(10) NOT NULL,
  PRIMARY KEY ("CustomerID")
);
CREATE TABLE IF NOT EXISTS "CustomerAddress" (
  "CustomerID" integer NOT NULL,
  "AddressID" integer NOT NULL,
  "AddressType" varchar(50) NOT NULL,
  PRIMARY KEY ("CustomerID","AddressType")
);
CREATE TABLE IF NOT EXISTS "Address" ( 
  "AddressID" integer NOT NULL,
  "AddressLine1" varchar(60) DEFAULT NULL,
  "AddressLine2" varchar(60) DEFAULT NULL,
  "City" varchar(60) DEFAULT NULL,
  "StateProvince" varchar(60) DEFAULT NULL,
  "CountryRegion" varchar(50) DEFAULT NULL,
  "PostalCode" varchar(15) DEFAULT NULL,
  PRIMARY KEY ("AddressID")
);
BEGIN;
CREATE TABLE IF NOT EXISTS "SalesOrderHeader" (
  "SalesOrderID" integer NOT NULL,
  "RevisionNumber" integer NOT NULL DEFAULT 0,
  "OrderDate" date NOT NULL,
  "DueDate" date NOT NULL,
  "ShipDate" date NOT NULL,
  "Status" integer NOT NULL DEFAULT 1,
  "OnlineOrderFlag" char(1) NOT NULL DEFAULT '1',
  "SalessOrderNumber" varchar(15) DEFAULT NULL,
  "PurchaseOrderNumber" varchar(15) DEFAULT NULL,
  "AccountNumber" varchar(25) DEFAULT NULL,
  "CustomerID" integer NOT NULL,
  "ShipToAddressID" integer DEFAULT NULL,
  "BillToAddressID" integer DEFAULT NULL,
  "ShipMethod" varchar(50) NOT NULL,
  "CreditCardApprovalCode" varchar(15) DEFAULT NULL,
  "SubTotal" decimal(10,2) NOT NULL,
  "TaxAmt" decimal(10,2) NOT NULL,
  "Freight" decimal(10,2) NOT NULL DEFAULT 0.00,
  "Commnt" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("SalesOrderID"),
  CONSTRAINT "SalesOrderHeader_ibfk_1" FOREIGN KEY ("CustomerID") REFERENCES "CustomerAW" ("CustomerID"),
  CONSTRAINT "SalesOrderHeader_ibfk_2" FOREIGN KEY ("ShipToAddressID") REFERENCES "Address" ("AddressID"),
  CONSTRAINT "SalesOrderHeader_ibfk_3" FOREIGN KEY ("BillToAddressID") REFERENCES "Address" ("AddressID")
);
CREATE INDEX "idxSOH_CustomerID" ON "SalesOrderHeader" ("CustomerID");
CREATE INDEX "idxSOH_ShipToAddressID" ON "SalesOrderHeader" ("ShipToAddressID");
CREATE INDEX "idxSOH_BillToAddressID" ON "SalesOrderHeader" ("BillToAddressID");
COMMIT;
CREATE TABLE IF NOT EXISTS "ProductModel" (
  "ProductModelID" integer NOT NULL,
  "Name" varchar(50) NOT NULL,
  "CatalogDescription" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("ProductModelID") 
);
BEGIN;
CREATE TABLE IF NOT EXISTS "ProductCategory" (
  "ProductCategoryID" integer NOT NULL,
  "ParentProductCategoryID" integer DEFAULT NULL,
  Name varchar(50) NOT NULL,
  PRIMARY KEY ("ProductCategoryID"),
  CONSTRAINT "ProductCategory_ibfk_1" FOREIGN KEY ("ParentProductCategoryID") REFERENCES "ProductCategory" ("ProductCategoryID")
);
CREATE INDEX "idx_ParentProductCategoryID" ON "ProductCategory" ("ParentProductCategoryID");
COMMIT;
BEGIN;
CREATE TABLE IF NOT EXISTS "Product" (
  "ProductID" integer NOT NULL,
  "Name" varchar(50) NOT NULL,
  "ProductNumber" varchar(25) NOT NULL,
  "Color" varchar(15) DEFAULT NULL,
  "StandardCost" decimal(10,2) NOT NULL,
  "ListPrice" decimal(10,2) NOT NULL,
  "Sze" varchar(5) DEFAULT NULL,
  "Weight" decimal(8,2) DEFAULT NULL,
  "ProductCategoryID" integer DEFAULT NULL,
  "ProductModelID" integer DEFAULT NULL,
  "SellStartDate" date NOT NULL,
  "SellEndDate" date DEFAULT NULL,
  "DiscontinuedDate" date DEFAULT NULL,
  "ThumbnailPhotoFileName" varchar(50) DEFAULT NULL,
  PRIMARY KEY ("ProductID"),
  CONSTRAINT "Product_ibfk_1" FOREIGN KEY ("ProductCategoryID") REFERENCES "ProductCategory" ("ProductCategoryID"),
  CONSTRAINT "Product_ibfk_2" FOREIGN KEY ("ProductCategoryID") REFERENCES "ProductCategory" ("ProductCategoryID")
);
CREATE INDEX "idx_ProductCategoryID" ON "Product" ("ProductCategoryID");
COMMIT;
BEGIN;
CREATE TABLE IF NOT EXISTS "SalesOrderDetail" (
  "SalesOrderID" integer NOT NULL,
  "SalesOrderDetailID" integer NOT NULL,
  "OrderQty" integer NOT NULL,
  "ProductID" integer NOT NULL,
  "UnitPrice" decimal(10,2) NOT NULL,
  "UnitPriceDiscount" decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY ("SalesOrderDetailID"),
  CONSTRAINT "SalesOrderDetail_ibfk_1" FOREIGN KEY ("SalesOrderID") REFERENCES "SalesOrderHeader" ("SalesOrderID"),
  CONSTRAINT "SalesOrderDetail_ibfk_2" FOREIGN KEY ("ProductID") REFERENCES "Product" ("ProductID")
);
CREATE INDEX "idx_ProductID" ON "SalesOrderDetail" ("ProductID");
CREATE INDEX "idx_SODSOIIndex" ON "SalesOrderDetail" ("SalesOrderID");
COMMIT;
CREATE TABLE IF NOT EXISTS "ProductDescription" (
  "ProductDescriptionID" integer NOT NULL,
  "Description" varchar(255) NOT NULL,
  PRIMARY KEY ("ProductDescriptionID")
);
BEGIN;
CREATE TABLE IF NOT EXISTS "ProductModelProductDescription" (
  "ProductModelID" integer NOT NULL,
  "ProductDescriptionID" integer NOT NULL,
  "Culture" char(6) NOT NULL,
  PRIMARY KEY ("ProductModelID","ProductDescriptionID"),
  CONSTRAINT "ProductModelProductDescription_ibfk_1" FOREIGN KEY ("ProductModelID") REFERENCES "ProductModel" ("ProductModelID"),
  CONSTRAINT "ProductModelProductDescription_ibfk_2" FOREIGN KEY ("ProductDescriptionID") REFERENCES "ProductDescription" ("ProductDescriptionID")
);
CREATE INDEX "idx_ProductDescriptionID" ON "ProductModelProductDescription" ("ProductDescriptionID");
COMMIT;
-- 5. Univ timetables
CREATE TABLE IF NOT EXISTS ut_staff ( 
  id varchar(20) NOT NULL,
  name varchar(50) DEFAULT NULL,
  PRIMARY KEY (id)
);
BEGIN;
CREATE TABLE IF NOT EXISTS ut_student (
  id varchar(20) NOT NULL,
  name varchar(50) DEFAULT NULL,
  sze integer DEFAULT NULL,
  parent varchar(20) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT student_ibfk_1 FOREIGN KEY (parent) REFERENCES ut_student (id)
);
CREATE INDEX idx_stu_parent ON ut_student (parent);
COMMIT;
BEGIN;
CREATE TABLE IF NOT EXISTS ut_room (
  id varchar(20) NOT NULL,
  name varchar(50) DEFAULT NULL,
  capacity integer DEFAULT NULL,
  parent varchar(20) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT room_ibfk_1 FOREIGN KEY (parent) REFERENCES ut_room (id)
);
CREATE INDEX idx_room_parent ON ut_room (parent);
COMMIT;
CREATE TABLE IF NOT EXISTS ut_modle (
  id varchar(20) NOT NULL,
  name varchar(50) DEFAULT NULL,
  PRIMARY KEY (id)
);
BEGIN;
CREATE TABLE IF NOT EXISTS ut_event (
  id varchar(20) NOT NULL,
  modle varchar(20) DEFAULT NULL,
  kind char(1) DEFAULT NULL,
  dow varchar(15) DEFAULT NULL,
  tod char(5) DEFAULT NULL,
  duration integer DEFAULT NULL,
  room varchar(20) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT event_ibfk_1 FOREIGN KEY (room) REFERENCES ut_room (id),
  CONSTRAINT event_ibfk_2 FOREIGN KEY (modle) REFERENCES ut_modle (id)
);
CREATE INDEX idx_evt_room ON ut_event (room);
CREATE INDEX idx_evt_modle ON ut_event (modle);
COMMIT;
BEGIN;
CREATE TABLE IF NOT EXISTS ut_attends (
  student varchar(20) NOT NULL,
  event varchar(20) NOT NULL,
  PRIMARY KEY (student,event),
  CONSTRAINT attends_ibfk_1 FOREIGN KEY (student) REFERENCES ut_student (id),
  CONSTRAINT attends_ibfk_2 FOREIGN KEY (event) REFERENCES ut_event (id)
);
CREATE INDEX idx_att_event ON ut_attends (event);
COMMIT;
BEGIN;
CREATE TABLE IF NOT EXISTS ut_teaches (
  staff varchar(20) NOT NULL,
  event varchar(20) NOT NULL,
  PRIMARY KEY (staff,event),
  CONSTRAINT teaches_ibfk_1 FOREIGN KEY (staff) REFERENCES ut_staff (id),
  CONSTRAINT teaches_ibfk_2 FOREIGN KEY (event) REFERENCES ut_event (id)
);
CREATE INDEX idx_teach_event ON ut_teaches (event);
COMMIT;
CREATE TABLE IF NOT EXISTS ut_occurs (
  event varchar(20) NOT NULL,
  week varchar(20) NOT NULL,
  PRIMARY KEY (event,week),
  CONSTRAINT occurs_ibfk_1 FOREIGN KEY (event) REFERENCES ut_event (id)
);
CREATE TABLE IF NOT EXISTS ut_week (
  id char(2) NOT NULL,
  wkstart date DEFAULT NULL,
  PRIMARY KEY (id)
);
-- 6. Musicians
CREATE TABLE IF NOT EXISTS band (
  band_no integer NOT NULL,
  band_name varchar(20) DEFAULT NULL,
  band_home integer NOT NULL,
  band_type varchar(10) DEFAULT NULL,
  b_date date DEFAULT NULL,
  band_contact integer NOT NULL,
  PRIMARY KEY (band_no)
);
CREATE TABLE IF NOT EXISTS composer ( 
  comp_no integer NOT NULL,
  comp_is integer NOT NULL,
  comp_type varchar(10) DEFAULT NULL,
  PRIMARY KEY (comp_no) 
);
CREATE TABLE IF NOT EXISTS composition ( 
  c_no integer NOT NULL,
  comp_date date DEFAULT NULL,
  c_title varchar(40) NOT NULL,
  c_in integer DEFAULT NULL,
  PRIMARY KEY (c_no) 
);
CREATE TABLE IF NOT EXISTS concert ( 
  concert_no integer NOT NULL,
  concert_venue varchar(20) DEFAULT NULL,
  concert_in integer NOT NULL,
  con_date date DEFAULT NULL,
  concert_orgniser integer DEFAULT NULL,
  PRIMARY KEY (concert_no) 
);
CREATE TABLE IF NOT EXISTS has_composed (
   cmpr_no integer NOT NULL,
  cmpn_no integer NOT NULL,
  PRIMARY KEY (cmpr_no,cmpn_no) 
);
CREATE TABLE IF NOT EXISTS musician ( 
  m_no integer NOT NULL,
  m_name varchar(20) DEFAULT NULL,
  born date DEFAULT NULL,
  died date DEFAULT NULL,
  born_in integer DEFAULT NULL,
  living_in integer DEFAULT NULL,
  PRIMARY KEY (m_no) 
);
CREATE TABLE IF NOT EXISTS performance ( 
  pfrmnc_no integer NOT NULL,
  gave integer DEFAULT NULL,
  performed integer DEFAULT NULL,
  conducted_by integer DEFAULT NULL,
  performed_in integer DEFAULT NULL,
  PRIMARY KEY (pfrmnc_no) 
);
CREATE TABLE IF NOT EXISTS performer ( 
  perf_no integer NOT NULL,
  perf_is integer DEFAULT NULL,
  instrument varchar(10) NOT NULL,
  perf_type varchar(10) DEFAULT 'not known',
  PRIMARY KEY (perf_no) 
);
CREATE TABLE IF NOT EXISTS place ( 
  place_no integer NOT NULL,
  place_town varchar(20) DEFAULT NULL,
  place_country varchar(20) DEFAULT NULL,
  PRIMARY KEY (place_no) 
);
CREATE TABLE IF NOT EXISTS plays_in ( 
  player integer NOT NULL,
  band_id integer NOT NULL,
  PRIMARY KEY (player,band_id) 
);
-- 7. Dressmaker
CREATE TABLE IF NOT EXISTS material ( 
  material_no integer NOT NULL,
  fabric char(20) NOT NULL,
  colour char(20) NOT NULL,
  pattern char(20) NOT NULL,
  cost double precision NOT NULL,
  PRIMARY KEY (material_no) 
);
CREATE TABLE IF NOT EXISTS dress_order ( 
  order_no integer NOT NULL,
  cust_no integer DEFAULT NULL,
  order_date date NOT NULL,
  completed char(1) DEFAULT NULL,
  PRIMARY KEY (order_no) 
);
CREATE TABLE IF NOT EXISTS quantities ( 
  style_q integer NOT NULL,
  size_q integer NOT NULL,
  quantity double precision NOT NULL,
  PRIMARY KEY (style_q,size_q) 
);
CREATE TABLE IF NOT EXISTS garment ( 
  style_no integer NOT NULL,
  description char(20) NOT NULL,
  labour_cost double precision NOT NULL,
  notions char(50) DEFAULT NULL,
  PRIMARY KEY (style_no) 
);
CREATE TABLE IF NOT EXISTS jmcust ( 
  c_no integer NOT NULL,
  c_name char(20) NOT NULL,
  c_house_no integer NOT NULL,
  c_post_code char(9) NOT NULL,
  PRIMARY KEY (c_no)
);
CREATE TABLE IF NOT EXISTS dressmaker ( 
  d_no integer NOT NULL,
  d_name char(20) NOT NULL,
  d_house_no integer NOT NULL,
  d_post_code char(8) NOT NULL,
  PRIMARY KEY (d_no) 
);
BEGIN;
CREATE TABLE IF NOT EXISTS construction ( 
  maker integer NOT NULL,
  order_ref integer NOT NULL,
  line_ref integer NOT NULL,
  start_date date NOT NULL,
  finish_date date DEFAULT NULL,
  PRIMARY KEY (maker,order_ref,line_ref)
);
CREATE INDEX idx_order_ref ON construction (order_ref,line_ref);
COMMIT;
BEGIN;
CREATE TABLE IF NOT EXISTS order_line ( 
  order_ref integer NOT NULL,
  line_no integer NOT NULL,
  ol_style integer DEFAULT NULL,
  ol_size integer NOT NULL,
  ol_material integer DEFAULT NULL,
  PRIMARY KEY (order_ref,line_no)
);
CREATE INDEX idx_ol_style ON order_line (ol_style,ol_size);
COMMIT;
-- 8. Congestion charging
CREATE TABLE IF NOT EXISTS camera ( 
  id integer NOT NULL,
  perim varchar(3) DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS keeper ( 
  id integer NOT NULL,
  name varchar(20) DEFAULT NULL,
  address varchar(25) DEFAULT NULL,
  PRIMARY KEY (id) 
);
BEGIN;
CREATE TABLE IF NOT EXISTS image (
  camera integer NOT NULL,
  whn timestamp NOT NULL,
  reg varchar(10) DEFAULT NULL,
  PRIMARY KEY (camera,whn)
);
CREATE INDEX idx_img_reg ON image (reg);
COMMIT;
CREATE TABLE IF NOT EXISTS permit ( 
  reg varchar(10) NOT NULL,
  sDate timestamp NOT NULL,
  chargeType varchar(10) DEFAULT NULL,
  PRIMARY KEY (reg,sDate) 
);
BEGIN;
CREATE TABLE IF NOT EXISTS vehicle ( 
  id varchar(10) NOT NULL,
  keeper integer DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE INDEX idx_veh_keeper ON vehicle (keeper);
COMMIT;
-- white christmas
CREATE TABLE IF NOT EXISTS hadcet ( 
  yr integer NOT NULL DEFAULT 0,
  dy integer NOT NULL DEFAULT 0,
  m1 integer DEFAULT NULL,
  m2 integer DEFAULT NULL,
  m3 integer DEFAULT NULL,
  m4 integer DEFAULT NULL,
  m5 integer DEFAULT NULL,
  m6 integer DEFAULT NULL,
  m7 integer DEFAULT NULL,
  m8 integer DEFAULT NULL,
  m9 integer DEFAULT NULL,
  m10 integer DEFAULT NULL,
  m11 integer DEFAULT NULL,
  m12 integer DEFAULT NULL,
  PRIMARY KEY (yr,dy) 
);