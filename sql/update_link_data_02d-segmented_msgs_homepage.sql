UPDATE 
	mrlp 
SET 
	Message_Type = "Segmented"
WHERE 
	(Message_Type IS NULL OR 
	Message_Type = "") 
	AND 
	Page_Group = "Mcom Homepage" AND 
	DATE(Date) >= DATE("2013-06-27") AND 
	Segment LIKE "%MOBILE%";
