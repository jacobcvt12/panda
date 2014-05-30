CREATE TABLE IF NOT EXISTS monthly_content(
Year TEXT,
Month TEXT,
Page_Group TEXT,
Department TEXT,
PageSection TEXT,
Placement TEXT,
ContentID TEXT,
Sum_Of_Link_Impressions INTEGER,
Sum_Of_Instances INTEGER);

SELECT 
	STRFTIME('%Y', Date) AS Year, 
	STRFTIME('%m', Date) AS Month, 
	Page_Group, 
	Department, 
	PageSection, 
	Placement, 
	ContentID, 
	Sum(Link_Impressions) AS Sum_Of_Link_Impressions,
	Sum(Instances) AS Sum_Of_Instances
FROM 
	mrlp
GROUP BY 
	STRFTIME('%Y', Date), 
	STRFTIME('%m', Date), 
	Page_Group, 
	Department, 
	PageSection, 
	Placement, 
	ContentID
HAVING 
	STRFTIME('%Y', Date) = '2013' AND 
	STRFTIME('%m', Date) = '06' AND 
	Page_Group = 'Deals LP'
ORDER BY 
	STRFTIME('%m', Date);