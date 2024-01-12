CREATE DATABASE exercises_db;

\c exercises_db;

CREATE TABLE customers (
    customer_id integer NOT NULL PRIMARY KEY,
    register_ts timestamp NOT NULL,
    email varchar(255) NOT NULL,
    gender char(2) NOT NULL
);

CREATE TABLE products (
    product_id integer NOT NULL PRIMARY KEY,
    publish_ts timestamp NOT NULL,
    category varchar(255) NOT NULL
);

CREATE TABLE orderlines (
    orderline_id integer NOT NULL PRIMARY KEY,
    order_id integer NOT NULL,
    order_ts timestamp NOT NULL,
    customer_id integer NOT NULL,
    product_id integer NOT NULL,
    product_qty integer NOT NULL,
    product_price numeric(6, 2)
);

INSERT INTO
    customers (customer_id, register_ts, email, gender)
VALUES
    (1, '2017-02-01 09:34:55', 'a@b.com', 'm'),
    (2, '2017-03-02 12:24:51', 's@d.com', 'f'),
    (3, '2017-03-11 07:11:22', 'x@s.com', 'f'),
    (4, '2017-03-12 03:14:25', 'e@w.com', 'm'),
    (5, '2017-04-01 11:34:55', 'w@t.com', 'f'),
    (6, '2017-04-22 22:34:55', 't@b.com', 'f'),
    (7, '2017-05-05 05:34:55', 'y@u.com', 'm'),
    (8, '2017-05-21 21:34:55', 'd@d.com', 'f'),
    (9, '2017-05-25 20:11:04', 'q@g.com', 'm'),
    (10, '2017-05-29 06:14:15', 'p@k.com', 'm'),
    (11, '2017-06-01 12:14:55', 'h@l.com', 'm');

INSERT INTO
    products (product_id, publish_ts, category)
VALUES
    (1, '2017-01-01 09:00:00', 'a'),
    (2, '2017-01-01 09:00:00', 'a'),
    (3, '2017-01-01 09:00:00', 'a'),
    (4, '2017-01-01 09:00:00', 'b'),
    (5, '2017-01-01 09:00:00', 'b'),
    (6, '2017-01-01 09:00:00', 'b'),
    (7, '2017-01-01 09:00:00', 'c'),
    (8, '2017-01-01 09:00:00', 'c'),
    (9, '2017-01-01 09:00:00', 'c'),
    (10, '2017-03-01 09:00:00', 'b'),
    (11, '2017-03-01 09:00:00', 'c'),
    (12, '2017-03-01 09:00:00', 'b'),
    (13, '2017-03-01 09:00:00', 'c'),
    (14, '2017-03-01 09:00:00', 'a'),
    (15, '2017-03-01 09:00:00', 'a'),
    (16, '2017-05-01 09:00:00', 'c'),
    (17, '2017-05-01 09:00:00', 'a'),
    (18, '2017-05-01 09:00:00', 'b'),
    (19, '2017-05-01 09:00:00', 'a'),
    (20, '2017-05-01 09:00:00', 'a');

INSERT INTO
    orderlines (
        orderline_id,
        order_id,
        order_ts,
        customer_id,
        product_id,
        product_qty,
        product_price
    )
VALUES
    (1, 1, '2017-02-01 09:34:55', 1, 5, 1, 12.99),
    (2, 1, '2017-02-01 09:34:55', 1, 3, 2, 5.99),
    (3, 2, '2017-03-11 07:11:22', 3, 5, 1, 12.99),
    (4, 3, '2017-03-12 03:14:25', 4, 1, 1, 17.99),
    (5, 4, '2017-02-01 09:34:55', 1, 3, 2, 5.99),
    (6, 6, '2017-04-01 11:34:55', 5, 7, 1, 22.99),
    (7, 7, '2017-04-11 09:04:00', 4, 9, 1, 12.99),
    (8, 7, '2017-04-11 09:04:00', 4, 6, 2, 5.99),
    (9, 7, '2017-04-11 09:04:00', 4, 7, 1, 12.99),
    (10, 8, '2017-04-22 22:34:55', 6, 10, 2, 9.99),
    (11, 9, '2017-04-24 12:34:55', 1, 12, 1, 4.99),
    (12, 10, '2017-04-24 12:44:15', 3, 12, 3, 4.99),
    (13, 11, '2017-04-28 11:14:05', 6, 5, 1, 12.99),
    (14, 11, '2017-04-28 11:14:05', 6, 18, 1, 15.99),
    (15, 12, '2017-05-04 07:11:22', 8, 5, 1, 12.99),
    (16, 13, '2017-05-05 05:34:55', 7, 15, 1, 14.99),
    (17, 13, '2017-05-05 05:34:55', 7, 3, 2, 5.99),
    (18, 13, '2017-05-05 05:34:55', 7, 16, 1, 13.99),
    (19, 14, '2017-05-25 20:11:04', 9, 5, 1, 12.99),
    (20, 15, '2017-05-29 06:14:15', 10, 20, 5, 6.99),
    (21, 16, '2017-05-29 07:11:22', 3, 5, 1, 12.99),
    (22, 16, '2017-05-29 07:11:22', 1, 20, 2, 6.99),
    (23, 17, '2017-05-30 09:34:55', 7, 15, 2, 14.99),
    (24, 17, '2017-05-30 09:34:55', 7, 14, 1, 15.99),
    (25, 18, '2017-05-30 19:24:15', 6, 20, 1, 6.99),
    (26, 19, '2017-06-01 06:04:15', 1, 16, 1, 13.99),
    (27, 20, '2017-06-01 12:14:55', 11, 15, 1, 14.99),
    (28, 21, '2017-06-02 11:34:55', 9, 3, 2, 5.99),
    (29, 21, '2017-06-02 11:34:55', 9, 5, 1, 12.99),
    (30, 22, '2017-06-03 18:11:11', 1, 15, 1, 14.99),
    (31, 22, '2017-06-03 18:11:11', 1, 16, 2, 13.99),
    (32, 22, '2017-06-03 18:11:11', 1, 20, 1, 6.99),
    (33, 22, '2017-06-03 18:11:11', 1, 5, 1, 12.99);