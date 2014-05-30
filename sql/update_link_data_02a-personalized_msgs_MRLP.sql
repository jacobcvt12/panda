UPDATE 
	mrlp 
SET 
	Message_Type = "Personalized"
WHERE 
	(Message_Type Is Null Or 
	Message_Type = "") 
	AND 
	Site = "US" AND 
	PageSectionPlacement IN 
		("pageSection=6:placement=1",
		"pageSection=5:placement=3",
		"pageSection=6:placement=3") 
	AND 
	Page_Group = "MRLP" AND 
	Segment NOT LIKE "%targeted%";
