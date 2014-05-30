SELECT 
	[Visit & Impression Data].Date, 
	[Visit & Impression Data].URL, 
	[Visit & Impression Data].Visits, 
	b.SumOfSumOfLink_Impressions AS Total_Impressions, 
	a.MaxOfSumOfLink_Impressions AS Max_Impressions
FROM 
	qry_visits_step2 AS a
INNER JOIN 
	[Visit & Impression Data] 
ON 
	a.Page1 = [Visit & Impression Data].URL AND 
	a.Date = [Visit & Impression Data].Date 
INNER JOIN 
	qry_visits_step3  AS b
ON 
	[Visit & Impression Data].URL = b.Page1 AND 
	[Visit & Impression Data].Date = b.Date;
