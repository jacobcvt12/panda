UPDATE 
	mrlp 
SET 
	Message_Type = "Segmented"
WHERE 
	(Message_Type IS NULL OR 
	Message_Type = "") 
	AND 
	Page_Group = "MYA Overview" AND 
	Placement_Name = "Earn" AND 
	Rule_Group = "Control Group" AND 
	DATE(Date) >= DATE("2012-07-01");
