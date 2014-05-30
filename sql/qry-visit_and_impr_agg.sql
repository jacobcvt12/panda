CREATE VIEW IF NOT EXISTS qry_visit_and_impr_agg AS
SELECT 
	a.Date, 
	a.MRLP_Visit + a.MYA_Overview_Visit + a.Earn_No_MRLP_MYA + 
		a.Use_No_MRLP_MYA + a.Trip_Planner_No_MRLP_MYA + 
		a.Deals_No_MRLP_MYA_Use - a.MRLP_and_MYA_Overview AS Visits, 
	Sum(b.SumOfLink_Impressions) AS SumOfSumOfLink_Impressions, 
	Sum(b.SumOfLink_Impr_Adj) AS SumOfSumOfLink_Impr_Adj
FROM 
	Visit_Agg_Data AS a
INNER JOIN 
	qry_visits_step1 AS b
ON 
	a.Date = b.Date
GROUP BY 
	a.Date, 
	a.MRLP_Visit + a.MYA_Overview_Visit + a.Earn_No_MRLP_MYA + 
		a.Use_No_MRLP_MYA + a.Trip_Planner_No_MRLP_MYA + 
		a.Deals_No_MRLP_MYA_Use - a.MRLP_and_MYA_Overview
HAVING 
	DATE(a.Date) >= DATE("2011-06-01")
;