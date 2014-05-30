UPDATE 
	mrlp 
SET 
	Message_Type = "Personalized"
WHERE 
	(Message_Type IS NULL OR 
	Message_Type = "") 
	AND 
	Page_Group = "Mcom Homepage" AND 
	(Segment LIKE "MERC\_%" OR 
	Segment LIKE "%ControlGroup%") 
	AND 
	DATE(Date) >= DATE("2013-06-01");
