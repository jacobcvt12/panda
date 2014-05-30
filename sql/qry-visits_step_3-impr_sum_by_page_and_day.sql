CREATE VIEW qry_visits_step3 AS
SELECT 
	Date AS Expr1, 
	Page1 AS Expr2, 
	Sum(SumOfLink_Impressions) AS SumOfSumOfLink_Impressions
FROM 
	qry_visits_step1
GROUP BY 
	Date, 
	Page1;
