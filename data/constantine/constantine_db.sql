-- ========================================
-- CRÉATION DE LA BASE DE DONNÉES
-- ========================================
DROP DATABASE IF EXISTS constantine_db;
CREATE DATABASE constantine_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE constantine_db;

-- ========================================
-- TABLE 1 : STORES - MAGASINS
-- ========================================
CREATE TABLE stores (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    store_code VARCHAR(20) UNIQUE NOT NULL,
    store_name VARCHAR(100) NOT NULL,
    store_address TEXT,
    city VARCHAR(50) NOT NULL,
    postal_code VARCHAR(10),
    store_manager VARCHAR(100),
    phone_number VARCHAR(20),
    opening_date DATE NOT NULL,
    store_type ENUM('HYPERMARKET', 'SUPERMARKET', 'EXPRESS') DEFAULT 'SUPERMARKET',
    floor_area DECIMAL(10,2),
    status ENUM('ACTIVE', 'INACTIVE', 'MAINTENANCE') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO stores VALUES
(1, 'CST-MAIN', 'Constantine Centre Ville', '45 Avenue Didouche Mourad, Constantine', 'Constantine', '25000', 'Samir Zerguine', '0314567890', '2021-05-10', 'HYPERMARKET', 1200.50, 'ACTIVE', NOW(), NOW()),
(2, 'CST-ELBIAR', 'Constantine El Biar', 'Rue Abane Ramdane, El Biar', 'Constantine', '25001', 'Leila Mesbah', '0314567891', '2022-03-15', 'SUPERMARKET', 850.00, 'ACTIVE', NOW(), NOW());

-- ========================================
-- TABLE 2 : EMPLOYEES - EMPLOYÉS
-- ========================================
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_code VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role ENUM('MANAGER', 'CASHIER', 'STOCK_CLERK', 'SUPERVISOR') NOT NULL,
    store_id INT NOT NULL,
    hire_date DATE NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    status ENUM('ACTIVE', 'INACTIVE', 'VACATION') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

INSERT INTO employees VALUES
(1, 'EMP-CST-001', 'Samir', 'Zerguine', 'MANAGER', 1, '2021-05-10', 's.zerguine@constantine.dz', '0314567890', 'ACTIVE', NOW()),
(2, 'EMP-CST-045', 'Nadia', 'Boukhemis', 'CASHIER', 1, '2022-02-15', 'n.boukhemis@constantine.dz', '0555123456', 'ACTIVE', NOW()),
(3, 'EMP-CST-078', 'Karim', 'Bensaad', 'CASHIER', 1, '2022-06-20', 'k.bensaad@constantine.dz', '0555123457', 'ACTIVE', NOW()),
(4, 'EMP-CST-089', 'Amina', 'Cherif', 'CASHIER', 1, '2023-01-10', 'a.cherif@constantine.dz', '0555123458', 'ACTIVE', NOW()),
(5, 'EMP-CST-102', 'Rachid', 'Mansouri', 'STOCK_CLERK', 1, '2022-08-05', NULL, '0555123459', 'ACTIVE', NOW());

-- ========================================
-- TABLE 3 : CATEGORIES - CATÉGORIES
-- ========================================
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    parent_category_id INT NULL,
    category_level INT DEFAULT 1,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_category_id) REFERENCES categories(category_id)
);

INSERT INTO categories VALUES
(1, 'EPICERIE', NULL, 1, 'Produits d''épicerie', TRUE, NOW()),
(2, 'BOISSONS', NULL, 1, 'Boissons diverses', TRUE, NOW()),
(3, 'PRODUITS FRAIS', NULL, 1, 'Produits frais', TRUE, NOW()),
(4, 'CAFES', 1, 2, 'Cafés et thés', TRUE, NOW()),
(5, 'SUCRES', 1, 2, 'Sucres et édulcorants', TRUE, NOW()),
(6, 'LAITS', 3, 2, 'Laits et crèmes', TRUE, NOW()),
(7, 'BOULANGERIE', NULL, 1, 'Pain et viennoiseries', TRUE, NOW()),
(8, 'VIANDE', NULL, 1, 'Viandes et volailles', TRUE, NOW());

-- ========================================
-- TABLE 4 : CUSTOMERS - CLIENTS
-- ========================================
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_code VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    city VARCHAR(50),
    birth_date DATE,
    loyalty_card_number VARCHAR(20) UNIQUE,
    customer_segment ENUM('REGULAR', 'PREMIUM', 'VIP', 'NEW') DEFAULT 'REGULAR',
    registration_date DATE NOT NULL,
    last_visit_date DATE,
    total_purchases DECIMAL(15,2) DEFAULT 0.00,
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO customers VALUES
(45632, 'CUST-CST-45632', 'Amine', 'Zeroug', 'a.zeroug@email.dz', '0314567890', 'Rue des Frères Bouchama, Constantine', 'Constantine', '1985-08-15', 'LF-78901', 'PREMIUM', '2023-06-15', '2024-01-19', 156000.00, 'ACTIVE', NOW(), NOW()),
(45633, 'CUST-CST-45633', 'Fatima', 'Bensaid', 'f.bensaid@email.dz', '0555987654', 'Cité 20 Août, Constantine', 'Constantine', '1990-12-20', 'LF-78902', 'REGULAR', '2023-08-22', '2024-01-18', 52850.00, 'ACTIVE', NOW(), NOW()),
(45634, 'CUST-CST-45634', 'Mohamed', 'Guellil', NULL, '0314567891', 'Cité Daksi, Constantine', 'Constantine', NULL, NULL, 'NEW', '2024-01-16', '2024-01-16', 18250.00, 'ACTIVE', NOW(), NOW()),
(45635, 'CUST-CST-45635', 'Samira', 'Boudjemaa', 's.boudjemaa@email.dz', '0555123450', 'Rue Belouizdad, Constantine', 'Constantine', '1988-03-10', 'LF-78903', 'VIP', '2022-11-05', '2024-01-17', 285000.00, 'ACTIVE', NOW(), NOW()),
(45636, 'CUST-CST-45636', 'Yacine', 'Benmohamed', NULL, '0314567892', NULL, 'Constantine', NULL, NULL, 'NEW', '2024-01-18', '2024-01-18', 5400.00, 'ACTIVE', NOW(), NOW());

-- ========================================
-- TABLE 5 : PRODUCTS - PRODUITS
-- ========================================
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_sku VARCHAR(50) UNIQUE NOT NULL,
    product_name VARCHAR(200) NOT NULL,
    product_description TEXT,
    barcode VARCHAR(20),
    category_id INT NOT NULL,
    brand VARCHAR(100),
    supplier_id INT,
    unit_price DECIMAL(15,2) NOT NULL,
    cost_price DECIMAL(15,2),
    vat_rate DECIMAL(5,2) DEFAULT 20.00,
    unit_of_measure VARCHAR(20) DEFAULT 'PIECE',
    weight DECIMAL(10,3),
    min_stock_level INT DEFAULT 10,
    max_stock_level INT DEFAULT 100,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO products VALUES
(1001, 'PROD-1001', 'Café Premium 500g', 'Café arabica premium en grains - Origine Algérie', '1234567890123', 4, 'Café d''Algérie', 1, 2999.00, 1850.00, 20.00, 'BAG', 0.500, 20, 200, TRUE, NOW(), NOW()),
(1002, 'PROD-1002', 'Café Standard 250g', 'Café standard en poudre', '1234567890124', 4, 'Café d''Algérie', 1, 1599.00, 950.00, 20.00, 'BAG', 0.250, 30, 300, TRUE, NOW(), NOW()),
(1003, 'PROD-1003', 'Thé vert Premium 200g', 'Thé vert importé de Chine', '1234567890125', 4, 'Palais des Thés', 1, 2500.00, 1800.00, 20.00, 'BOX', 0.200, 15, 100, TRUE, NOW(), NOW()),
(2005, 'PROD-2005', 'Sucre Blanc 1kg', 'Sucre blanc raffiné en sachet', '1234567890456', 5, 'CEVITAL', 2, 550.00, 350.00, 5.50, 'BAG', 1.000, 50, 500, TRUE, NOW(), NOW()),
(2006, 'PROD-2006', 'Sucre Roux 500g', 'Sucre roux naturel', '1234567890457', 5, 'CEVITAL', 2, 450.00, 280.00, 5.50, 'BAG', 0.500, 40, 400, TRUE, NOW(), NOW()),
(3007, 'PROD-3007', 'Lait Délissa 1L', 'Lait UHT demi-écrémé', '1234567890789', 6, 'Délissa', 3, 120.00, 80.00, 5.50, 'BOTTLE', 1.000, 100, 1000, TRUE, NOW(), NOW()),
(3008, 'PROD-3008', 'Lait Soummam 1L', 'Lait UHT entier', '1234567890790', 6, 'Soummam', 3, 130.00, 85.00, 5.50, 'BOTTLE', 1.000, 100, 1000, TRUE, NOW(), NOW()),
(4010, 'PROD-4010', 'Pain Complet', 'Pain complet artisanal', '1234567890800', 7, 'Boulangerie Locale', 4, 150.00, 80.00, 9.00, 'PIECE', 0.400, 50, 300, TRUE, NOW(), NOW()),
(5015, 'PROD-5015', 'Poulet Fermier 1kg', 'Poulet fermier frais', '1234567890850', 8, 'Fermier Algérie', 5, 1800.00, 1200.00, 9.00, 'KG', 1.000, 15, 80, TRUE, NOW(), NOW()),
(6020, 'PROD-6020', 'Riz Basmati 5kg', 'Riz basmati importé', '1234567890900', 1, 'Tassili', 2, 3500.00, 2300.00, 20.00, 'BAG', 5.000, 25, 150, TRUE, NOW(), NOW());

-- ========================================
-- TABLE 6 : TRX_HEADERS - EN-TÊTES TRANSACTIONS
-- ========================================
CREATE TABLE trx_headers (
    trx_id INT AUTO_INCREMENT PRIMARY KEY,
    trx_reference VARCHAR(50) UNIQUE NOT NULL,
    trx_date DATE NOT NULL,
    trx_time TIME NOT NULL,
    store_id INT NOT NULL,
    register_id INT NOT NULL,
    cashier_id INT NOT NULL,
    customer_id INT NULL,
    total_amount DECIMAL(15,2) NOT NULL,
    total_discount DECIMAL(15,2) DEFAULT 0.00,
    total_tax DECIMAL(15,2) NOT NULL,
    net_amount DECIMAL(15,2) NOT NULL,
    payment_method ENUM('CASH', 'CREDIT_CARD', 'DEBIT_CARD', 'MOBILE', 'CHECK') NOT NULL,
    payment_status ENUM('PENDING', 'COMPLETED', 'FAILED', 'REFUNDED') DEFAULT 'COMPLETED',
    loyalty_points_earned INT DEFAULT 0,
    trx_status ENUM('COMPLETED', 'CANCELLED', 'REFUNDED') DEFAULT 'COMPLETED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (cashier_id) REFERENCES employees(employee_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    INDEX idx_trx_date (trx_date),
    INDEX idx_store_date (store_id, trx_date)
);

INSERT INTO trx_headers VALUES
(100001, 'CST-240115-001', '2024-01-15', '14:30:00', 1, 5, 2, 45632, 6548.00, 0.00, 1090.50, 6548.00, 'CREDIT_CARD', 'COMPLETED', 65, 'COMPLETED', NOW(), NOW()),
(100002, 'CST-240115-002', '2024-01-15', '15:45:30', 1, 5, 3, 45633, 7850.00, 500.00, 1225.00, 7850.00, 'CASH', 'COMPLETED', 78, 'COMPLETED', NOW(), NOW()),
(100003, 'CST-240116-001', '2024-01-16', '09:15:20', 1, 6, 2, 45634, 3250.00, 0.00, 541.67, 3250.00, 'DEBIT_CARD', 'COMPLETED', 32, 'COMPLETED', NOW(), NOW()),
(100004, 'CST-240116-002', '2024-01-16', '11:30:45', 1, 5, 4, NULL, 4200.00, 0.00, 700.00, 4200.00, 'CASH', 'COMPLETED', 0, 'COMPLETED', NOW(), NOW()),
(100005, 'CST-240117-001', '2024-01-17', '10:20:15', 1, 6, 2, 45635, 12500.00, 800.00, 1950.00, 12500.00, 'CREDIT_CARD', 'COMPLETED', 125, 'COMPLETED', NOW(), NOW()),
(100006, 'CST-240117-002', '2024-01-17', '14:15:30', 1, 5, 3, 45632, 8750.00, 0.00, 1458.33, 8750.00, 'DEBIT_CARD', 'COMPLETED', 87, 'COMPLETED', NOW(), NOW()),
(100007, 'CST-240118-001', '2024-01-18', '09:45:00', 1, 6, 4, 45636, 5400.00, 100.00, 900.00, 5400.00, 'CASH', 'COMPLETED', 54, 'COMPLETED', NOW(), NOW()),
(100008, 'CST-240118-002', '2024-01-18', '16:30:20', 1, 5, 2, 45633, 2150.00, 0.00, 358.33, 2150.00, 'MOBILE', 'COMPLETED', 21, 'COMPLETED', NOW(), NOW()),
(100009, 'CST-240119-001', '2024-01-19', '08:25:40', 1, 6, 3, 45632, 15600.00, 1000.00, 2433.33, 15600.00, 'CREDIT_CARD', 'COMPLETED', 156, 'COMPLETED', NOW(), NOW()),
(100010, 'CST-240119-002', '2024-01-19', '13:50:15', 1, 5, 4, NULL, 6800.00, 0.00, 1133.33, 6800.00, 'CASH', 'COMPLETED', 0, 'COMPLETED', NOW(), NOW());

-- ========================================
-- TABLE 7 : TRX_LINES - LIGNES DE TRANSACTION
-- ========================================
CREATE TABLE trx_lines (
    line_id INT AUTO_INCREMENT PRIMARY KEY,
    trx_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(15,2) NOT NULL,
    line_discount DECIMAL(15,2) DEFAULT 0.00,
    line_tax DECIMAL(15,2) NOT NULL,
    line_total DECIMAL(15,2) NOT NULL,
    vat_rate DECIMAL(5,2) NOT NULL,
    promotion_id INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (trx_id) REFERENCES trx_headers(trx_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    INDEX idx_trx_product (trx_id, product_id)
);

INSERT INTO trx_lines VALUES
-- Transaction 100001
(500001, 100001, 1001, 2, 2999.00, 0.00, 999.67, 5998.00, 20.0, NULL, NOW()),
(500002, 100001, 2005, 1, 550.00, 0.00, 90.83, 550.00, 5.5, NULL, NOW()),
-- Transaction 100002
(500003, 100002, 1001, 1, 2999.00, 0.00, 499.83, 2999.00, 20.0, NULL, NOW()),
(500004, 100002, 3007, 5, 120.00, 0.00, 99.17, 600.00, 5.5, NULL, NOW()),
(500005, 100002, 1002, 2, 1599.00, 500.00, 449.83, 3198.00, 20.0, 1, NOW()),
(500006, 100002, 4010, 7, 150.00, 0.00, 176.17, 1050.00, 9.0, NULL, NOW()),
-- Transaction 100003
(500007, 100003, 6020, 1, 3500.00, 0.00, 583.33, 3500.00, 20.0, NULL, NOW()),
-- Transaction 100004
(500008, 100004, 1003, 2, 2500.00, 0.00, 833.33, 5000.00, 20.0, NULL, NOW()),
-- Transaction 100005
(500009, 100005, 6020, 2, 3500.00, 400.00, 1083.33, 6600.00, 20.0, NULL, NOW()),
(500010, 100005, 5015, 3, 1800.00, 400.00, 866.67, 5400.00, 9.0, NULL, NOW()),
(500011, 100005, 1001, 1, 2999.00, 0.00, 499.83, 2999.00, 20.0, NULL, NOW()),
-- Transaction 100006
(500012, 100006, 1002, 3, 1599.00, 0.00, 799.50, 4797.00, 20.0, NULL, NOW()),
(500013, 100006, 3008, 5, 130.00, 0.00, 107.50, 650.00, 5.5, NULL, NOW()),
(500014, 100006, 2006, 7, 450.00, 0.00, 551.33, 3150.00, 5.5, NULL, NOW()),
-- Transaction 100007
(500015, 100007, 1001, 2, 2999.00, 100.00, 983.00, 5898.00, 20.0, NULL, NOW()),
-- Transaction 100008
(500016, 100008, 4010, 10, 150.00, 0.00, 250.00, 1500.00, 9.0, NULL, NOW()),
(500017, 100008, 3007, 5, 120.00, 0.00, 99.17, 600.00, 5.5, NULL, NOW()),
-- Transaction 100009
(500018, 100009, 6020, 3, 3500.00, 600.00, 1716.67, 9900.00, 20.0, NULL, NOW()),
(500019, 100009, 5015, 3, 1800.00, 400.00, 866.67, 5400.00, 9.0, NULL, NOW()),
(500020, 100009, 1003, 1, 2500.00, 0.00, 416.67, 2500.00, 20.0, NULL, NOW()),
-- Transaction 100010
(500021, 100010, 1001, 2, 2999.00, 0.00, 999.67, 5998.00, 20.0, NULL, NOW()),
(500022, 100010, 2005, 2, 550.00, 0.00, 181.67, 1100.00, 5.5, NULL, NOW());

-- ========================================
-- TABLE 8 : PAYMENTS - PAIEMENTS
-- ========================================
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    trx_id INT NOT NULL,
    payment_method ENUM('CASH', 'CREDIT_CARD', 'DEBIT_CARD', 'MOBILE', 'CHECK') NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'DZD',
    card_last_four VARCHAR(4),
    authorization_code VARCHAR(50),
    payment_gateway VARCHAR(50),
    payment_status ENUM('PENDING', 'APPROVED', 'DECLINED', 'ERROR') DEFAULT 'APPROVED',
    processed_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (trx_id) REFERENCES trx_headers(trx_id),
    INDEX idx_payment_trx (trx_id)
);

INSERT INTO payments VALUES
(80001, 100001, 'CREDIT_CARD', 6548.00, 'DZD', '1234', 'AUTH-CST-789456', 'CIB', 'APPROVED', '2024-01-15 14:30:05', NOW()),
(80002, 100002, 'CASH', 7850.00, 'DZD', NULL, NULL, NULL, 'APPROVED', '2024-01-15 15:45:35', NOW()),
(80003, 100003, 'DEBIT_CARD', 3250.00, 'DZD', '5678', 'AUTH-CST-789457', 'CIB', 'APPROVED', '2024-01-16 09:15:25', NOW()),
(80004, 100004, 'CASH', 4200.00, 'DZD', NULL, NULL, NULL, 'APPROVED', '2024-01-16 11:30:50', NOW()),
(80005, 100005, 'CREDIT_CARD', 12500.00, 'DZD', '9012', 'AUTH-CST-789458', 'CIB', 'APPROVED', '2024-01-17 10:20:20', NOW()),
(80006, 100006, 'DEBIT_CARD', 8750.00, 'DZD', '1234', 'AUTH-CST-789459', 'CIB', 'APPROVED', '2024-01-17 14:15:35', NOW()),
(80007, 100007, 'CASH', 5400.00, 'DZD', NULL, NULL, NULL, 'APPROVED', '2024-01-18 09:45:05', NOW()),
(80008, 100008, 'MOBILE', 2150.00, 'DZD', NULL, 'MOBILE-CST-789460', 'CCP', 'APPROVED', '2024-01-18 16:30:25', NOW()),
(80009, 100009, 'CREDIT_CARD', 15600.00, 'DZD', '1234', 'AUTH-CST-789461', 'CIB', 'APPROVED', '2024-01-19 08:25:45', NOW()),
(80010, 100010, 'CASH', 6800.00, 'DZD', NULL, NULL, NULL, 'APPROVED', '2024-01-19 13:50:20', NOW());

-- ========================================
-- TABLE 9 : INVENTORY - STOCK
-- ========================================
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    current_stock INT NOT NULL,
    reserved_stock INT DEFAULT 0,
    min_stock_level INT DEFAULT 0,
    max_stock_level INT DEFAULT 0,
    last_restock_date DATE,
    next_restock_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    UNIQUE KEY uk_store_product (store_id, product_id)
);

INSERT INTO inventory VALUES
(1, 1, 1001, 138, 5, 20, 200, '2024-01-14', '2024-01-28', TRUE, NOW(), NOW()),
(2, 1, 1002, 225, 3, 30, 300, '2024-01-14', '2024-01-28', TRUE, NOW(), NOW()),
(3, 1, 1003, 94, 2, 15, 100, '2024-01-14', '2024-01-28', TRUE, NOW(), NOW()),
(4, 1, 2005, 86, 2, 50, 500, '2024-01-12', '2024-01-26', TRUE, NOW(), NOW()),
(5, 1, 2006, 133, 1, 40, 400, '2024-01-12', '2024-01-26', TRUE, NOW(), NOW()),
(6, 1, 3007, 435, 15, 100, 1000, '2024-01-10', '2024-01-24', TRUE, NOW(), NOW()),
(7, 1, 3008, 245, 5, 100, 1000, '2024-01-10', '2024-01-24', TRUE, NOW(), NOW()),
(8, 1, 4010, 273, 10, 50, 300, '2024-01-14', '2024-01-21', TRUE, NOW(), NOW()),
(9, 1, 5015, 67, 3, 15, 80, '2024-01-14', '2024-01-21', TRUE, NOW(), NOW()),
(10, 1, 6020, 91, 2, 25, 150, '2024-01-13', '2024-01-27', TRUE, NOW(), NOW());

-- ========================================
-- TABLE 10 : STOCK_MOVEMENTS - MOUVEMENTS DE STOCK
-- ========================================
CREATE TABLE stock_movements (
    movement_id INT AUTO_INCREMENT PRIMARY KEY,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    movement_type ENUM('IN', 'OUT', 'ADJUSTMENT', 'RETURN') NOT NULL,
    quantity INT NOT NULL,
    previous_stock INT NOT NULL,
    new_stock INT NOT NULL,
    reference_type ENUM('SALE', 'RESTOCK', 'TRANSFER', 'ADJUSTMENT') NOT NULL,
    reference_id INT NOT NULL,
    movement_date DATE NOT NULL,
    movement_time TIME NOT NULL,
    employee_id INT NOT NULL,
    reason VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    INDEX idx_movement_date (movement_date),
    INDEX idx_product_movement (product_id, movement_date)
);

INSERT INTO stock_movements VALUES
-- Mouvements Transaction 100001
(90001, 1, 1001, 'OUT', -2, 147, 145, 'SALE', 100001, '2024-01-15', '14:30:00', 2, 'Vente transaction CST-240115-001', NOW()),
(90002, 1, 2005, 'OUT', -1, 90, 89, 'SALE', 100001, '2024-01-15', '14:30:00', 2, 'Vente transaction CST-240115-001', NOW()),
-- Mouvements Transaction 100002
(90003, 1, 1001, 'OUT', -1, 145, 144, 'SALE', 100002, '2024-01-15', '15:45:30', 3, 'Vente transaction CST-240115-002', NOW()),
(90004, 1, 3007, 'OUT', 5, 450, 445, 'SALE', 100002, '2024-01-15', '15:45:30', 3, 'Vente transaction CST-240115-002', NOW()),
(90005, 1, 1002, 'OUT', -2, 232, 230, 'SALE', 100002, '2024-01-15', '15:45:30', 3, 'Vente transaction CST-240115-002', NOW()),
(90006, 1, 4010, 'OUT', -7, 290, 283, 'SALE', 100002, '2024-01-15', '15:45:30', 3, 'Vente transaction CST-240115-002', NOW()),
-- Mouvements Transaction 100003
(90007, 1, 6020, 'OUT', -1, 98, 97, 'SALE', 100003, '2024-01-16', '09:15:20', 2, 'Vente transaction CST-240116-001', NOW()),
-- Mouvements Transaction 100004
(90008, 1, 1003, 'OUT', -2, 98, 96, 'SALE', 100004, '2024-01-16', '11:30:45', 4, 'Vente transaction CST-240116-002', NOW()),
-- Réapprovisionnement
(90009, 1, 1001, 'IN', 50, 97, 147, 'RESTOCK', 1, '2024-01-14', '08:00:00', 5, 'Réapprovisionnement fournisseur', NOW()),
(90010, 1, 6020, 'IN', 30, 68, 98, 'RESTOCK', 1, '2024-01-13', '08:30:00', 5, 'Réapprovisionnement fournisseur', NOW()),
-- Mouvements Transaction 100005
(90011, 1, 6020, 'OUT', -2, 97, 95, 'SALE', 100005, '2024-01-17', '10:20:15', 2, 'Vente transaction CST-240117-001', NOW()),
(90012, 1, 5015, 'OUT', -3, 76, 73, 'SALE', 100005, '2024-01-17', '10:20:15', 2, 'Vente transaction CST-240117-001', NOW()),
(90013, 1, 1001, 'OUT', -1, 144, 143, 'SALE', 100005, '2024-01-17', '10:20:15', 2, 'Vente transaction CST-240117-001', NOW()),
-- Mouvements Transaction 100006
(90014, 1, 1002, 'OUT', -3, 230, 227, 'SALE', 100006, '2024-01-17', '14:15:30', 3, 'Vente transaction CST-240117-002', NOW()),
(90015, 1, 3008, 'OUT', -5, 250, 245, 'SALE', 100006, '2024-01-17', '14:15:30', 3, 'Vente transaction CST-240117-002', NOW()),
(90016, 1, 2006, 'OUT', -7, 140, 133, 'SALE', 100006, '2024-01-17', '14:15:30', 3, 'Vente transaction CST-240117-002', NOW()),
-- Mouvements Transaction 100007
(90017, 1, 1001, 'OUT', -2, 143, 141, 'SALE', 100007, '2024-01-18', '09:45:00', 4, 'Vente transaction CST-240118-001', NOW()),
-- Mouvements Transaction 100008
(90018, 1, 4010, 'OUT', -10, 283, 273, 'SALE', 100008, '2024-01-18', '16:30:20', 2, 'Vente transaction CST-240118-002', NOW()),
(90019, 1, 3007, 'OUT', -5, 445, 440, 'SALE', 100008, '2024-01-18', '16:30:20', 2, 'Vente transaction CST-240118-002', NOW()),
-- Mouvements Transaction 100009
(90020, 1, 6020, 'OUT', -3, 95, 92, 'SALE', 100009, '2024-01-19', '08:25:40', 3, 'Vente transaction CST-240119-001', NOW()),
(90021, 1, 5015, 'OUT', -3, 73, 70, 'SALE', 100009, '2024-01-19', '08:25:40', 3, 'Vente transaction CST-240119-001', NOW()),
(90022, 1, 1003, 'OUT', -1, 96, 95, 'SALE', 100009, '2024-01-19', '08:25:40', 3, 'Vente transaction CST-240119-001', NOW()),
-- Mouvements Transaction 100010
(90023, 1, 1001, 'OUT', -2, 141, 139, 'SALE', 100010, '2024-01-19', '13:50:15', 4, 'Vente transaction CST-240119-002', NOW()),
(90024, 1, 2005, 'OUT', -2, 89, 87, 'SALE', 100010, '2024-01-19', '13:50:15', 4, 'Vente transaction CST-240119-002', NOW()),
-- Ajustement inventaire
(90025, 1, 1001, 'ADJUSTMENT', -1, 139, 138, 'ADJUSTMENT', 1, '2024-01-19', '18:00:00', 5, 'Casse produit endommagé', NOW()),
(90026, 1, 6020, 'ADJUSTMENT', -1, 92, 91, 'ADJUSTMENT', 1, '2024-01-19', '18:00:00', 5, 'Inventaire correction', NOW());