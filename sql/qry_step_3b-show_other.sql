CREATE TABLE IF NOT EXISTS Other_Rule_Page_Group(
Date TEXT, 
Personalization_Rule_Key TEXT,
Page TEXT,
Site TEXT,
Segment TEXT,
PageSection TEXT,
Placement TEXT,
PageSectionPlacement TEXT, 
Link_Impr_Adj TEXT,
Instances INTEGER,
Message_Type TEXT,
Department TEXT,
Page_Group TEXT,
Rewards_Program TEXT,
Rule_Group TEXT);

DELETE FROM Other_Rule_Page_Group;

INSERT INTO 
	Other_Rule_Page_Group
SELECT 
	Date, 
	Personalization_Rule_Key, 
	Page, 
	Site, 
	Segment, 
	PageSection, 
	Placement, 
	PageSectionPlacement, 
	Link_Impr_Adj, 
	Instances, 
	Message_Type, 
	Department, 
	Page_Group, 
	Rewards_Program, 
	Rule_Group
FROM 
	mrlp
WHERE 
	Page NOT LIKE "%vacation%" 
	AND 
	(Rule_Group = "Other" OR 
	Page_Group = "Other" OR 
	Site = "Other")
ORDER BY Page, Site;