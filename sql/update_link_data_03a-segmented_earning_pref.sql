UPDATE 
	mrlp 
SET 
	Message_Type = "Segmented"
WHERE 
	(Message_Type IS NULL OR 
	Message_Type = "") 
	AND 
	Rule_Group = "Earning Preference" AND 
	Segment NOT LIKE "%Redeem%";
