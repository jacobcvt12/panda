CREATE TABLE IF NOT EXISTS link_data_segmentation(
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
Placement_Name TEXT, 
Message_Type TEXT, 
ControlGroupKey TEXT, 
Page_Group TEXT, 
Rewards_Program TEXT, 
Rule_Group TEXT, 
Headline_Type TEXT, 
Site TEXT, 
Department TEXT,
Link_Impr_Adj INTEGER);

INSERT INTO link_data_segmentation (ComboKey, Date, Personalization_Rule_Key, Page, Segment, PageSection, Placement, PageSectionPlacement, ContentID, 
Link_Text, Rule_Name, Classification, Instances, Link_Clicks, Bookings, Revenue, Link_Impressions, Rewards_Enrollments, Bookings_Participation, 
Revenue_Participation, Credit_Card_Apps, Hotel_Availability_Search_Visits, Promo_Registrations, Placement_Name, Message_Type, ControlGroupKey, 
Page_Group, Rewards_Program, Rule_Group, Headline_Type, Site, Department, Link_Impr_Adj)
SELECT ComboKey, Date, Personalization_Rule_Key, Page, Segment, PageSection, Placement, PageSectionPlacement, ContentID, Link_Text, Rule_Name, 
Classification, Instances, Link_Clicks, Bookings, Revenue, Link_Impressions, Rewards_Enrollments, Bookings_Participation, Revenue_Participation, 
Credit_Card Apps, Hotel_Availability_Search_Visits, Promo_Registrations, Placement_Name, Message_Type, ControlGroupKey, Page_Group, Rewards_Program, 
Rule_Group, Headline_Type, Site, Department, Link_Impr_Adj
FROM mrlp 
LEFT JOIN link_data_segmentation ON mrlp.ComboKey = link_data_segmentation.ComboKey
WHERE mrlp.Message_Type = 'Segmented' AND link_data_segmentation.ComboKey IS NULL;
