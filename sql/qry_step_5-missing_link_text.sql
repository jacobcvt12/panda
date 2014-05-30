SELECT 
	Message_Type, 
	ComboKey, 
	Date, 
	Personalization_Rule_Key, 
	Page, 
	Segment, 
	PageSection, 
	Placement, 
	PageSectionPlacement, 
	ContentID, 
	Link_Text, 
	Rule_Name, 
	Classification, 
	Instances, 
	Bookings, 
	Revenue, 
	Link_Impressions, 
	Rewards_Enrollments, 
	Bookings_Participation, 
	Revenue_Participation
FROM 
	mrlp
WHERE 
	Message_Type = 'Personalized' AND 
	Personalization_Rule_Key NOT LIKE '%ritz%' 
	AND (Link_Text IS NULL OR Link_Text = 'Need Link Desc');
