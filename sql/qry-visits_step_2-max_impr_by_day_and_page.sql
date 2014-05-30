CREATE VIEW IF NOT EXISTS qry_visits_step2 AS
SELECT 
	Date AS Expr1, 
	Page1 AS Expr2, 
	MAX(SumOfLink_Impressions) AS MaxOfSumOfLink_Impressions
FROM 
	qry_visits_step1
GROUP BY 
	Date, 
	Page1;
