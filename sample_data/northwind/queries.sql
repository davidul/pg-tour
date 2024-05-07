SELECT o.order_date,
       o.shipped_date,
       s.company_name,
       o.ship_name FROM orders o, shippers s
WHERE o.ship_via = s.shipper_id;

SELECT o.ship_name,
       e.first_name,
       e.last_name
FROM orders o, employees e
WHERE o.employee_id = e.employee_id;