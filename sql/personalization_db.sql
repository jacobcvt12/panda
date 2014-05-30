CREATE TABLE IF NOT EXISTS Personalization_DB (

	ComboKey TEXT, 
	Date TEXT, 
	Personalization_Rule_Key TEXT, 
	Page TEXT, 
	Segment TEXT, 
	PageSection TEXT, 
	Placement TEXT, 
	PageSectionPlacement TEXT, 
	ContentID TEXT, 
	Link_Text TEXT, 
	Rule_Name TEXT, 
	Classification TEXT, 
	Instances INTEGER, 
	Link_Clicks INTEGER, 
	Bookings INTEGER, 
	Revenue INTEGER, 
	Link_Impressions INTEGER, 
	Rewards_Enrollments INTEGER, 
	Bookings_Participation INTEGER, 
	Revenue_Participation INTEGER, 
	Credit_Card_Apps INTEGER, 
	Hotel_Availability_Search_Visits INTEGER, 
	Promo_Registrations INTEGER, 
	Placement_Name TEXT, 
	Message_Type TEXT, 
	ControlGroupKey TEXT, 
	Page_Group TEXT, 
	Rewards_Program TEXT, 
	Rule_Group TEXT, 
	Headline_Type TEXT, 
	Link_Impr_Adj INTEGER,
	Site TEXT,
	Department TEXT
);

INSERT INTO Personalization_DB 
	(ComboKey, 
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
	Link_Clicks, 
	Bookings, 
	Revenue, 
	Link_Impressions, 
	Rewards_Enrollments, 
	Bookings_Participation, 
	Revenue_Participation, 
	Credit_Card_Apps, 
	Hotel_Availability_Search_Visits, 
	Promo_Registrations, 
	Placement_Name, 
	Message_Type, 
	ControlGroupKey, 
	Page_Group, 
	Rewards_Program, 
	Rule_Group, 
	Headline_Type, 
	Link_Impr_Adj)

SELECT 
	a.ComboKey, 
	a.Date, 
	a.Personalization_Rule_Key, 
	a.Page, 
	a.Segment, 
	a.PageSection, 
	a.Placement, 
	a.PageSectionPlacement, 
	a.ContentID, 
	a.Link_Text, 
	a.Rule_Name, 
	a.Classification, 
	a.Instances, 
	a.Link_Clicks, 
	a.Bookings, 
	a.Revenue, 
	a.Link_Impressions, 
	a.Rewards_Enrollments, 
	a.Bookings_Participation, 
	a.Revenue_Participation, 
	a.Credit_Card_Apps, 
	a.Hotel_Availability_Search_Visits, 
	a.Promo_Registrations, 
	a.Placement_Name, 
	a.Message_Type, 
	a.ControlGroupKey, 
	a.Page_Group, 
	a.Rewards_Program, 
	a.Rule_Group, 
	a.Headline_Type, 
	a.Link_Impr_Adj
FROM 
	mrlp AS a
LEFT JOIN 
	Personalization_DB AS b
ON 
	a.ComboKey = b.ComboKey
WHERE 
	DATE(a.Date) >= DATE("2013-01-01") AND 
	a.Message_Type = "Personalized" AND 
	b.ComboKey IS NULL
;

UPDATE 
	Personalization_DB 
SET 
	Site = Page, 
	Department = Segment
WHERE 
	DATE(Date) >= DATE("2013-01-01")
;



