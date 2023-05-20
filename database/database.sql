use restaurant;

CREATE TABLE IF NOT EXISTS restaurants (
  username VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  address VARCHAR(255) NULL,
  phone VARCHAR(20) NULL,
  PRIMARY KEY (username)
);

CREATE TABLE IF NOT EXISTS menu_items (
  id VARCHAR(255) NOT NULL,
  restaurant_username VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(255),
  price DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (restaurant_username) REFERENCES restaurants(username)
);

CREATE TABLE IF NOT EXISTS orders (
  id VARCHAR(255) NOT NULL,
  restaurant_username VARCHAR(255) NOT NULL,
  customer_name VARCHAR(255) NOT NULL,
  customer_phone VARCHAR(20) NOT NULL,
  status ENUM('received', 'preparing', 'out_for_delivery', 'delivered') NOT NULL,
  order_date DATETIME NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (restaurant_username) REFERENCES restaurants(username)
);

CREATE TABLE IF NOT EXISTS order_items (
  id VARCHAR(255) NOT NULL,
  order_id VARCHAR(255) NOT NULL,
  menu_item_id VARCHAR(255) NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (menu_item_id) REFERENCES menu_items(id)
);

CREATE TABLE IF NOT EXISTS invoices (
  id VARCHAR(255) NOT NULL,
  order_id VARCHAR(255) NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  payment_date DATETIME NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (order_id) REFERENCES orders(id)
);
