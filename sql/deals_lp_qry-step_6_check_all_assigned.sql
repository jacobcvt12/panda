CREATE VIEW IF NOT EXISTS deals_lp_qry_step_6_check_all_assigned AS
SELECT 
	Page_Group, 
	Department, 
	Rule_Group, 
	Placement_Name, 
	PageSection, 
	Placement, 
	Segment, 
	Date, 
	Sum(Link_Impr_Adj) AS SumOfLink_Impr_Adj
FROM 
	mrlp
GROUP BY 
	Page_Group, 
	Department, 
	Rule_Group, 
	Placement_Name, 
	PageSection, 
	Placement, 
	Segment, 
	Date
HAVING 
	Page_Group = "Deals LP" AND 
	DATE(Date) >= DATE("2014-01-01")
ORDER BY Department;
