/* Challenge: We want to understand the distribution of sunglasses order volumes by color and see how the data is spread. Count the number of sunglasses orders for each color but only include colors with less than 5 orders. Then, count how many colors fall under each number of orders (i.e. how many colors have 1 order, 2 orders, 3 orders, and 4 orders).

Your final output should have 2 columns:

num_orders
num_colors
Hint: you should use 1 CTE and end up with 3 rows in your final output. */

WITH less_than_five AS (
SELECT COUNT(Item_purchased) AS Sunglasses_count,
	Color
FROM shopping_trends
WHERE Item_Purchased = 'Sunglasses'
GROUP BY Color
HAVING COUNT(Item_purchased) < 5
)
SELECT Sunglasses_count AS num_orders,
	 COUNT(color) AS num_colors
FROM less_than_five
GROUP BY Sunglasses_count