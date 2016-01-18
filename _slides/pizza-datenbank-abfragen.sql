/* 
 * Sammlung von Pizza-Service-Datenbank Abfragen
 */ 


-- Zeige zu jeder Pizza den Standard-Belag

select pizza_name, topping_name 
  FROm pizza_compilation;


-- Zeige zu jeder Pizza den Standard-Belag, gruppiert pro Pizza

select pizza_name, topping_name 
  FROm pizza_compilation
GROUP BY pizza_name
  ;
-- Zeig mir zum Menu die Pizza-Bilder und toppings

SELECT num,menu.name,cost, pizza.img, toppings
  FROM menu
  LEFT JOIN
       pizza
    ON (menu.name = pizza.name)
  LEFT JOIN (
         SELECT pizza_name, string_agg(topping_name, ',') AS toppings
           FROM pizza_compilation
           GROUP BY pizza_name
        ) AS pizza_topping
    ON (pizza.name = pizza_topping.pizza_name)
 ORDER BY num;

 -- In welcher Strasse sind die meisten Kunden?

 -- Wer sind die 'besten' Kunden?