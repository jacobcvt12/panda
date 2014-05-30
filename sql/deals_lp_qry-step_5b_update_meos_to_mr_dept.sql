UPDATE 
	mrlp 
SET 
	Department = "MR"
WHERE 
	Page_Group = "Deals LP" AND 
	Placement_Name = "MEOs" AND 
	DATE(Date) >= DATE("2013-11-01");