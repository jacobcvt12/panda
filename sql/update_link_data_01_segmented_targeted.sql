UPDATE 
	mrlp 
SET 
	Message_Type = "Segmented"
WHERE 
	Segment Like "%targeted%" AND 
	PageSectionPlacement <> "pageSection=6:placement=3" AND 
	DATE(Date) >= DATE("2013-07-14");
