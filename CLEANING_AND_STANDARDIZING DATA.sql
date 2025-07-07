SHOW TABLES;
DESC dim_date;
SELECT * FROM dim_date;

# STEP_1: DIM_DATE TABLE

-- STANDARDIZING dim_date TABLE COLUMN HEADERS & DATA TYPES -- 
ALTER TABLE dim_date CHANGE `ï»¿date` _DATE_ TEXT;
ALTER TABLE dim_date CHANGE `mmm yy` MONTH_YEAR VARCHAR(10);
ALTER TABLE dim_date CHANGE `week no` WEEK_NO VARCHAR(5);
ALTER TABLE dim_date CHANGE `day_type` DAY_TYPE VARCHAR(10);

-- STANDARDIZING DATE COLUMN -- 
UPDATE dim_date SET _DATE_=REPLACE(_DATE_,"-","/");

-- PARSING STRING TO DATE FORMAT --
UPDATE dim_date SET _DATE_=STR_TO_DATE(_DATE_,'%d/%b/%Y');

-- CHANGING COLUMN DATA TYPE TO DATE --
ALTER TABLE dim_date MODIFY _DATE_ DATE;

# STEP_2: DIM_HOTELS

DESC dim_hotels;
SELECT * FROM dim_hotels;

-- STANDARDIZING COLUMN HEADER NAME & DATA TYPE --
SHOW COLUMNS FROM dim_hotels;
ALTER TABLE dim_hotels CHANGE `ï»¿property_id` PROPERTY_ID INT;
ALTER TABLE dim_hotels modify property_name varchar(15);
ALTER TABLE dim_hotels modify category varchar(10);
ALTER TABLE dim_hotels modify CITY varchar(10);

# STEP 3: DIM_ROOMS

DESC dim_rooms;
SELECT * FROM dim_rooms;

-- SAME STEP AGAIN --
ALTER TABLE dim_rooms CHANGE `ï»¿room_id` ROOM_ID CHAR(3);
ALTER TABLE dim_rooms MODIFY room_class VARCHAR(15);

-- STEP 4: FACT_AGG_BOOKINGS -- 

DESC fact_aggregated_bookings;
SELECT * FROM fact_aggregated_bookings;

-- FIRST STANDARDIZING DATE COLUMN --
UPDATE fact_aggregated_bookings SET CHECK_IN_DATE=REPLACE(CHECK_IN_DATE,"-","/");
UPDATE fact_aggregated_bookings SET CHECK_IN_DATE=str_to_date(CHECK_IN_DATE,"%d/%b/%Y");
ALTER TABLE fact_aggregated_bookings modify check_in_date DATE;

-- NOW STANDIZING OTHER COLUMNS --
ALTER TABLE fact_aggregated_bookings CHANGE `ï»¿property_id` PROPERPTY_ID INT;
ALTER TABLE fact_aggregated_bookings MODIFY  room_category VARCHAR(3);

# STEP 5: FACT_BOOKINGS

DESC fact_bookings;
SELECT * FROM fact_bookings;

-- STANDARDIZING THE DATE COLUMNS FIRST {CHANGING THE DATA TYPE FROM TEXT TO DATE} --

UPDATE fact_bookings SET BOOKING_DATE=str_to_date(BOOKING_DATE,"%m/%d/%Y");
ALTER TABLE fact_bookings MODIFY booking_date date;

UPDATE fact_bookings SET CHECK_IN_DATE=str_to_date(CHECK_IN_DATE,"%m/%d/%Y");
ALTER TABLE fact_bookings MODIFY check_in_date date;

UPDATE fact_bookings SET checkout_date=str_to_date(checkout_date,"%m/%d/%Y");
ALTER TABLE fact_bookings MODIFY checkout_date date;

-- STANDARDIZING COLUMN HEADERS & THEIR RESPECTIVE DATA TYPES --

ALTER TABLE fact_bookings change `ï»¿booking_id` Booking_ID text;

ALTER TABLE fact_bookings MODIFY room_category varchar(3);

ALTER TABLE fact_bookings MODIFY booking_platform varchar(20);

UPDATE fact_bookings SET ratings_given= null where ratings_given="";
ALTER TABLE fact_bookings MODIFY ratings_given int;

ALTER TABLE fact_bookings MODIFY booking_status varchar(20);








