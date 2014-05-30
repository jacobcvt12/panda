UPDATE 
	mrlp 
SET 
	Message_Type = "Segmented"
WHERE 
	(Message_Type = "" OR 
	Message_Type IS NULL) 
	AND 
	DATE(Date) >= DATE("2013-08-01");
