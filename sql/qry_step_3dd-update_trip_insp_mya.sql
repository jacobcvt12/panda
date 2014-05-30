UPDATE mrlp 
SET Department = "MR"
WHERE Department != "MR"
AND (Page_Group = "MYA Overview" 
OR Page_Group LIKE "%trip%");
