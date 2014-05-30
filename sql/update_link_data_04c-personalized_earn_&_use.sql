UPDATE 
	mrlp 
SET 
	Message_Type = "Personalized"
WHERE 
	(Message_Type = "" OR 
	Message_Type IS NULL) 
	AND 
	(Page LIKE "%/rewards/use-points.mi" OR 
	Page LIKE "%/rewards/earn-points.mi") 
	AND 
	Rule_Group NOT LIKE "%Wailea%" AND 
	PageSection <> "7";
