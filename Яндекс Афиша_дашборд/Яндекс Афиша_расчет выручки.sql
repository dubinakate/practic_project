-- расчет выручки по типу мероприятия
SELECT e.event_type_main,
       sum(p.revenue) AS total_revenue
FROM afisha.purchases p 
JOIN afisha.events e USING(event_id)
WHERE p.currency_code= {{currency_code}}
GROUP BY e.event_type_main 
ORDER BY total_revenue DESC

-- расчет выручки по типу устройства
WITH set_config_precode AS (
  SELECT set_config('synchronize_seqscans', 'off', true)
)


SELECT device_type_canonical,
	   sum(revenue) AS total_revenue
FROM afisha.purchases p 
WHERE p.currency_code= {{selected_currency}}
GROUP BY p.device_type_canonical
ORDER BY total_revenue DESC

