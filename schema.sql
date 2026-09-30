CREATE DATABASE IF NOT EXISTS payments;
USE payments;
-- Django migrations create these tables; this artifact documents the required relational shape.
CREATE TABLE payments_card (id BIGINT PRIMARY KEY AUTO_INCREMENT, user_id INT NOT NULL, brand VARCHAR(30) NOT NULL, masked_number VARCHAR(25) NOT NULL, last_four CHAR(4) NOT NULL, expiry_month SMALLINT UNSIGNED NOT NULL, expiry_year SMALLINT UNSIGNED NOT NULL, created_at DATETIME NOT NULL);
CREATE TABLE payments_transaction (id BIGINT PRIMARY KEY AUTO_INCREMENT, user_id INT NOT NULL, merchant VARCHAR(120) NOT NULL, amount DECIMAL(12,2) NOT NULL, status VARCHAR(10) NOT NULL DEFAULT 'PENDING', reference VARCHAR(40) UNIQUE NOT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL);
CREATE TABLE payments_adminlog (id BIGINT PRIMARY KEY AUTO_INCREMENT, actor_id INT NOT NULL, action VARCHAR(120) NOT NULL, created_at DATETIME NOT NULL);
-- Never add card_number or cvv columns. Passwords are managed by Django's hashed auth_user table.
