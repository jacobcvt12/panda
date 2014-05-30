UPDATE 
	mrlp 
SET 
	Message_Type = "Personalized"
WHERE 
	(Message_Type IS NULL OR 
	Message_Type = "") 
	AND 
	Page_Group = "Deals LP" AND 
	Segment NOT LIKE "%targeted%";