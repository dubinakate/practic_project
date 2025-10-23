-- расчет ключевых показателей сервиса
SELECT sum(revenue) AS total_revenue,
	   count(order_id) AS total_orders,
	   count(DISTINCT user_id) AS total_users,
	   sum(p.tickets_count) AS total_tickets,
	   sum(revenue)/sum(p.tickets_count) AS one_ticket_cost
FROM afisha.purchases p 
JOIN afisha.events e using(event_id)
JOIN afisha.city c using(city_id)
WHERE p.currency_code ='rub'
ORDER BY total_revenue DESC;

-- расчет выручки по типу мероприятия
SELECT e.event_type_main,
       sum(p.revenue) AS total_revenue
FROM afisha.purchases p 
JOIN afisha.events e USING(event_id)
WHERE p.currency_code= 'rub'
GROUP BY e.event_type_main 
ORDER BY total_revenue DESC;

-- расчет выручки по типу устройства
SELECT device_type_canonical,
	   sum(revenue) AS total_revenue
FROM afisha.purchases p 
WHERE p.currency_code= 'rub'
GROUP BY p.device_type_canonical
ORDER BY total_revenue DESC;

-- расчет выручки, количества заказов и средней выручки с заказа в разрезе недель
SELECT DATE_TRUNC('week', created_dt_msk)::date AS week,
	   sum(revenue) AS total_revenue,
	   count(order_id) AS total_orders,
	   sum(revenue)/count(order_id) AS revenue_per_order
FROM afisha.purchases p
WHERE currency_code='rub'
GROUP BY week
ORDER BY week;

-- выделение топ-7 регионов по выручке с дополнительным расчетов количества заказов, среднего количества билетов в заказе, средней выручки с заказа
SELECT r.region_name,
	   sum(revenue) AS total_revenue,
	   count(order_id) AS total_orders,
	   sum(p.tickets_count)/count(order_id) AS total_tickets,
	   sum(revenue)/sum(p.tickets_count) AS one_ticket_cost
FROM afisha.purchases p 
JOIN afisha.events e using(event_id)
JOIN afisha.city c using(city_id)
JOIN afisha.regions r using(region_id)
WHERE p.currency_code ='rub'
GROUP BY r.region_name 
ORDER BY total_revenue DESC
LIMIT 7;

-- выделение топ-7 событий по выручке с дополнительным расчетов количества заказов, среднего количества билетов в заказе, средней выручки с заказа
SELECT e.event_name_code,
	   sum(revenue) AS total_revenue,
	   count(order_id) AS total_orders,
	   sum(p.tickets_count)/count(order_id) AS total_tickets,
	   sum(revenue)/sum(p.tickets_count) AS one_ticket_cost
FROM afisha.purchases p 
JOIN afisha.events e using(event_id)
WHERE p.currency_code ='rub'
GROUP BY e.event_name_code 
ORDER BY total_revenue DESC
LIMIT 7;

-- выделение топ-7 площадок по выручке с дополнительным расчетов количества заказов, среднего количества билетов в заказе, средней выручки с заказа
SELECT e.organizers,
	   sum(revenue) AS total_revenue,
	   count(order_id) AS total_orders,
	   sum(p.tickets_count)/count(order_id) AS total_tickets,
	   sum(revenue)/sum(p.tickets_count) AS one_ticket_cost
FROM afisha.purchases p 
JOIN afisha.events e using(event_id)
WHERE p.currency_code ='rub'
GROUP BY e.organizers
ORDER BY total_revenue DESC
LIMIT 7


