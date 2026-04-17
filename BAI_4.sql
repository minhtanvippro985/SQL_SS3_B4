
CREATE DATABASE IF NOT EXISTS SUPERMARKET_MNG;
USE SUPERMARKET_MNG;

CREATE TABLE ORDERS (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100),
    OrderDate DATETIME,
    TotalAmount DECIMAL(18, 2),
    Status VARCHAR(20), -- 'Completed', 'Canceled', 'Pending'
    IsDeleted TINYINT(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO ORDERS (CustomerName, OrderDate, TotalAmount, Status) VALUES
('Nguyễn Văn A', '2023-01-10', 500000, 'Completed'),
('Khách hàng vãng lai', '2023-02-15', 1200000, 'Canceled'), -- Rác
('Trần Thị B', '2023-05-20', 300000, 'Canceled'),           -- Rác
('Lê Văn C', '2024-01-05', 850000, 'Completed');



-- Tạo bảng lưu trữ để chứa các đơn hàng đã hủy
-- Bảng này giúp giải phóng bảng chính nhưng vẫn giữ dữ liệu cho Kế toán
CREATE TABLE ORDERS_HISTORY LIKE ORDERS;

INSERT INTO ORDERS_HISTORY
SELECT * FROM ORDERS 
WHERE Status = 'Canceled';


DELETE FROM ORDERS 
WHERE Status = 'Canceled';

SELECT * FROM ORDERS;


SELECT * FROM ORDERS_HISTORY;

SELECT SUM(TotalAmount) AS 'Tổng tiền đơn hủy' FROM ORDERS_HISTORY;