UPDATE 
	mrlp 
SET 
	Message_Type = "Segmented"
WHERE 
	Rule_Group = "Control Group" AND 
	ContentID IN 
		("674e7327324cf310VgnVCM100000997882a2RCRD", 
		"b2b9f6e09a67f310VgnVCM100000997882a2RCRD", 
		"61cf35268a2ef310VgnVCM100000997882a2RCRD", 
		"06830c60c32ef310VgnVCM100000997882a2RCRD");