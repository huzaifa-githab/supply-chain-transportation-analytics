SELECT COUNT(*) AS total_shipments
FROM shipments;

--Shipment Status Distribution
SELECT shipment_status, COUNT(*) AS count
FROM shipments
GROUP BY shipment_status;

--Shipments by Mode
SELECT shipment_mode, COUNT(*) AS total
FROM shipments
GROUP BY shipment_mode;

--On-Time Delivery Percentage
SELECT 
  ROUND(
    100.0 * SUM(CASE WHEN delivery_delay_days = 0 THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS on_time_percentage
FROM shipments
WHERE shipment_status <> 'Cancelled';

--Average Delivery Delay
SELECT ROUND(AVG(delivery_delay_days), 2) AS avg_delay_days
FROM shipments
WHERE shipment_status = 'Delayed';

--Average Delay by Destination City
SELECT destination_city,
       ROUND(AVG(delivery_delay_days), 2) AS avg_delay
FROM shipments
WHERE shipment_status = 'Delayed'
GROUP BY destination_city
ORDER BY avg_delay DESC;

--Carrier Performance (Avg Delay)
SELECT carrier_name,
       ROUND(AVG(delivery_delay_days), 2) AS avg_delay
FROM shipments
GROUP BY carrier_name
ORDER BY avg_delay DESC;