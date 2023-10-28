-- Create Customer Table
CREATE TABLE customers(
    customer_id VARCHAR PRIMARY KEY,
    customer_unique_id VARCHAR,
    customer_zip_code_prefix VARCHAR(6),
    customer_city VARCHAR,
    customer_state CHAR(2)
	);

-- Create Geolocation Table
CREATE TABLE geolocation(
    geolocation_zip_code_prefix VARCHAR,
    geolocation_lat DOUBLE PRECISION,
    geolocation_lng DOUBLE PRECISION,
    geolocation_city VARCHAR,
    geolocation_state CHAR(2)
	);

-- Create Order Table
CREATE TABLE orders(
    order_id VARCHAR NOT NULL,
    customer_id VARCHAR,
    order_status VARCHAR,
    order_purchase_timestamp TIMESTAMP WITHOUT TIME ZONE,
    order_approved_at TIMESTAMP WITHOUT TIME ZONE,
	order_delivered_carrier_date TIMESTAMP WITHOUT TIME ZONE,
	order_delivered_customer_date TIMESTAMP WITHOUT TIME ZONE,
	order_estimated_delivery_date TIMESTAMP WITHOUT TIME ZONE,
	PRIMARY KEY(order_id),
	CONSTRAINT fk_customer
		FOREIGN KEY(customer_id)
			REFERENCES customers(customer_id)
	);

-- Create Order Items Table
CREATE TABLE order_items(
    order_id VARCHAR NOT NULL,
    order_item_id VARCHAR,
    product_id VARCHAR,
    seller_id VARCHAR,
	shipping_limit_date TIMESTAMP WITHOUT TIME ZONE,
	price FLOAT,
	freight_value FLOAT
	);
	
-- Create Order Payment Table
CREATE TABLE order_payment(
    order_id VARCHAR NOT NULL,
    payment_sequential INT,
    payment_type VARCHAR,
    payment_installments INT,
	payment_value FLOAT
	);
	
-- Create Order Review Table
-- The review_id cannot be granted as Primary Key due to duplicate value error msg
CREATE TABLE order_reviews(
    review_id VARCHAR,
    order_id VARCHAR,
    review_score INT,
	review_comment_title VARCHAR,
	review_comment_message VARCHAR,
	review_creation_date TIMESTAMP WITHOUT TIME ZONE,
	review_answer_timestamp TIMESTAMP WITHOUT TIME ZONE
	);
	
-- Create Products Table
CREATE TABLE products(
	idx INT, 
    product_id VARCHAR PRIMARY KEY NOT NULL,
    product_category_name VARCHAR,
    product_name_lenght FLOAT,
	product_description_lenght FLOAT,
	product_photos_qty FLOAT,
	product_weight_g FLOAT,
	product_length_cm FLOAT,
	product_height_cm FLOAT,
	product_width_cm FLOAT
	);
	
-- Create Seller Table
CREATE TABLE seller(
	seller_id VARCHAR PRIMARY KEY NOT NULL,
    seller_zip_code_prefix VARCHAR,
    seller_city VARCHAR,
	seller_state CHAR(2)
	);

-- Foreign Key

ALTER TABLE order_items ADD FOREIGN KEY (order_id) REFERENCES orders;
ALTER TABLE order_items ADD FOREIGN KEY (product_id) REFERENCES products;
ALTER TABLE order_items ADD FOREIGN KEY (seller_id) REFERENCES seller;
ALTER TABLE order_payment ADD FOREIGN KEY (order_id) REFERENCES orders;
ALTER TABLE order_reviews ADD FOREIGN KEY (order_id) REFERENCES orders;