CREATE VIEW IF NOT EXISTS qry_visits_step1 AS
SELECT 
	Date,
	CASE
		WHEN Page LIKE "%https%"
			THEN SUBSTR(Page, 9)
		ELSE 
			SUBSTR(Page, 8)
	END AS Page1,
	PageSectionPlacement, 
	Sum(Link_Impressions) AS SumOfLink_Impressions, 
	Sum(Link_Impr_Adj) AS SumOfLink_Impr_Adj, 
	Message_Type, 
	Segment, 
	Page_Group || "_" || PageSectionPlacement AS Page_Placement, 
	Department
FROM 
	Personalization_DB
GROUP BY 
	Date, 
	CASE
		WHEN Page LIKE "%https%"
			THEN SUBSTR(Page, 9)
		ELSE 
			SUBSTR(Page, 8)
	END, 
	PageSectionPlacement, 
	Message_Type, 
	Segment, 
	Page_Group || "_" || PageSectionPlacement, 
	Department
HAVING 
	DATE(Date) >= DATE("2011-06-01") AND 
	Message_Type = "Personalized" AND 
	Segment <> "ControlGroup" AND 
	(Page_Group || "_" || PageSectionPlacement) <> "MYA Trip Inspirations_pageSection=1:placement=1" AND 
	Department = "MR"
ORDER BY 
	Date, 
	Page_Group || "_" || 
	PageSectionPlacement;
