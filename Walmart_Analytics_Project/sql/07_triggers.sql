/*
=========================================================
Project : Walmart Retail Analytics
File    : 07_triggers.sql
Purpose : Business Triggers
=========================================================
*/

USE walmart_analytics;

DELIMITER $$

-- =====================================================
-- Trigger 1
-- Prevent Negative Inventory
-- =====================================================

CREATE TRIGGER trg_prevent_negative_inventory
BEFORE UPDATE
ON inventory
FOR EACH ROW

BEGIN

    IF NEW.available_quantity < 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Inventory cannot be negative';

    END IF;

END$$

-- =====================================================
-- Trigger 2
-- Auto Update Inventory Status
-- =====================================================

CREATE TRIGGER trg_inventory_status
BEFORE UPDATE
ON inventory
FOR EACH ROW

BEGIN

    IF NEW.available_quantity <= NEW.reorder_level THEN

        SET NEW.inventory_status='LOW STOCK';

    ELSE

        SET NEW.inventory_status='IN STOCK';

    END IF;

END$$

-- =====================================================
-- Trigger 3
-- Validate Order Amount
-- =====================================================

CREATE TRIGGER trg_validate_order_amount
BEFORE INSERT
ON orders
FOR EACH ROW

BEGIN

    IF NEW.total_amount < 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Total Amount cannot be negative';

    END IF;

END$$

DELIMITER ;

SHOW TRIGGERS
FROM walmart_analytics;

UPDATE inventory
SET available_quantity=-5
WHERE inventory_id=1;

UPDATE inventory
SET available_quantity=2
WHERE inventory_id=1;

SELECT inventory_status
FROM inventory
WHERE inventory_id=1;

INSERT INTO orders
VALUES
(
999999,
1,
1,
CURDATE(),
'UPI',
'Completed',
100,
0,
18,
40,
-100
);