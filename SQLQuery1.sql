select * from orders

EXEC sp_columns 'OrdersFact';

ALTER TABLE DimCustomer ALTER COLUMN customer_id VARCHAR(50);


ALTER TABLE OrdersFact 
ADD 	accm_txn_create_time DATETIME, 
accm_txn_complete_time DATETIME, 
txn_process_time_hours DECIMAL(10,2);


select * from OrdersFact

-- Create table to track completion times
CREATE TABLE FactTransactionCompletion (
    txn_id INT PRIMARY KEY,
    acrm_txn_complete_time DATETIME NOT NULL,
    FOREIGN KEY (txn_id) REFERENCES OrdersFact(order_id)
);

-- Update existing records with creation time (assuming current time)
UPDATE OrdersFact
SET accm_txn_create_time = GETDATE(),
    txn_process_time_hours = NULL;