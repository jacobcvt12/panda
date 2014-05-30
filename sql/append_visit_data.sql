CREATE TABLE IF NOT EXISTS Visit_Agg_Data (
Date TEXT, 
MRLP_VISIT INTEGER,
MYA_Overview_Visit INTEGER, 
MRLP_and_MYA_Overview INTEGER, 
Earn_No_MRLP_MYA INTEGER, 
Use_No_MRLP_MYA INTEGER, 
Trip_Planner_No_MRLP_MYA INTEGER, 
Deals_No_MRLP_MYA_Use INTEGER
);

INSERT INTO 
	Visit_Agg_Data 
		(Date, 
		MRLP_Visit, 
		MYA_Overview_Visit, 
		MRLP_and_MYA_Overview, 
		Earn_No_MRLP_MYA, 
		Use_No_MRLP_MYA, 
		Trip_Planner_No_MRLP_MYA, 
		Deals_No_MRLP_MYA_Use)
SELECT 
	a.Date, 
	a.MRLP_Visit, 
	a.MYA_Overview_Visit, 
	a.MRLP_and_MYA_Overview, 
	a.Earn_No_MRLP_MYA, 
	a.Use_No_MRLP_MYA, 
	a.Trip_Planner_No_MRLP_MYA, 
	a.Deals_No_MRLP_MYA_Use
FROM 
	Visits_to_all_Personalized_Pages AS a
LEFT JOIN 
	Visit_Agg_Data AS b
ON 
	a.Date = b.Date
WHERE 
	b.Date IS NULL;
