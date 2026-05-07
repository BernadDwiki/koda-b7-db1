CREATE TABLE transaction (
    transaction_id SERIAL PRIMARY KEY,
    customer_id int,
    amount int
)

INSERT INTO transaction (customer_id, amount)
VALUES (101, 500),
(101, 300),
(102, 150);

table TRANSACTION;


SELECT t1.customer_id, t1.amount
FROM TRANSACTION t1
WHERE amount > (
    SELECT AVG(amount) 
    FROM TRANSACTION t2
    WHERE t1.customer_id = t2.customer_id -- dia hanya akan mencari rata rata pada customer id yang sama, yang beda gausah dihitung
);