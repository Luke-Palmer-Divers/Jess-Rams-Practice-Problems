/* Problem: Pull a list of all the shopping transactions where the purchase_amount_usd is less than the state's (location) average purchase amount. 
Include the following columns:

	Customer_ID
	Location
	purchase_amount_usd
	state_avg (you have to make this one!)
	diff_from_avg (you have to make this one!) */

With state_averages AS (
SELECT DISTINCT Location AS location, 
	   AVG(Purchase_Amount_USD) AS state_average
FROM shopping_trends
GROUP BY Location
)

SELECT	st.Customer_ID,
		sa.Location, 
		st.Purchase_Amount_USD,
		sa.state_average,
		st.Purchase_Amount_USD - sa.state_average AS diff_from_avg
FROM shopping_trends AS st
JOIN state_averages AS sa
	ON st.location = sa.location

