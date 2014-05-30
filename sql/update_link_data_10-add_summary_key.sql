UPDATE 
	mrlp 
SET 
	SummaryKey = 
	(
		CASE
			WHEN DATE IS NULL OR 
				Page IS NULL OR 
				Segment IS NULL OR 
				PageSectionPlacement IS NULL
			THEN
				"Contains NULL values"
			ELSE
				STRFTIME("%m/%d/%Y", DATE) || "+" || Page || "+" || Segment || "+" || PageSectionPlacement
		END
	)
WHERE 
	SummaryKey IS NULL;
