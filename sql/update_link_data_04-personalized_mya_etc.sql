UPDATE 
	mrlp 
SET 
	Message_Type = "Personalized"
WHERE 
	(Message_Type = "" OR 
	Message_Type IS NULL) 
	AND 
	Page LIKE "%/myaccount/default.mi%" AND 
	Placement NOT LIKE "4%";
