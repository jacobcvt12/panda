UPDATE 
	mrlp 
SET 
	Placement_Name = 
	(
		CASE 
			WHEN Page_Group = "Mcom Homepage"
				THEN "Flashcard-" || PageSection
			WHEN Page_Group = "Rewarding Events" 
				THEN "CC Tile"
			WHEN Page_Group = "MRLP"
				THEN CASE
					WHEN Site = "US"
						THEN CASE
							WHEN PageSection BETWEEN 3 AND 11
								THEN CASE
									WHEN PageSection = 5
										THEN "Headline 1-"
									WHEN PageSection = 6
										THEN "Headline 2-"
									WHEN PageSection = 7
										THEN "Utility-"
									WHEN PageSection = 9
										THEN "Tile Row 1-"
									WHEN PageSection = 11
										THEN "Tile Row 2-"
									WHEN (PageSection = 10 AND Segment LIKE "% - %")
										THEN "Tile Row 2-"
									ELSE "Other MRLP"
								END || CASE Placement
									WHEN 1
										THEN "Earn"
									WHEN 2
										THEN "Use"
									WHEN 3
										THEN "Benefits"
									ELSE ""
								END
							ELSE CASE PageSection
								WHEN 12
									THEN "Brand Explorer"
								WHEN 13
									THEN "Customer Service"
								WHEN 2
									THEN "Hero Image"
							END
						END
					ELSE CASE
						WHEN PageSection < 11
							THEN CASE
								WHEN PageSection = 4
									THEN "Headline 1-"
								WHEN PageSection = 5
									THEN "Headline 2-"
								WHEN PageSection = 6
									THEN "Utility-"
								WHEN PageSection = 8
									THEN "Tile Row 1-"
								WHEN PageSection = 10
									THEN "Tile Row 2-"
								WHEN (PageSection = 9 AND Segment LIKE "% - %")
									THEN "Tile Row 2-"
								ELSE "Other MRLP"
							END || CASE Placement
								WHEN 1
									THEN "Earn"
								WHEN 2
									THEN "Use"
								WHEN 3
									THEN "Benefits"
								ELSE ""
							END
						ELSE CASE PageSection
							WHEN 11
								THEN "Brand Explorer"
							WHEN 12
								THEN "Customer Service"
						END
					END
				END
			WHEN Page_Group = "MYA Overview"
				THEN CASE
					WHEN (PageSection = 2 AND SUBSTR(Placement, 1, 1) = "1") OR (PageSection = 1 AND SUBSTR(Placement, 1, 1) = "2")
						THEN "Save"
					WHEN PageSection = 2 AND SUBSTR(Placement, 1, 1) = "2"
						THEN "Earn"
					WHEN (PageSection = 3 AND SUBSTR(Placement, 1, 1) = "2") OR (PageSection = 2 AND SUBSTR(Placement, 1, 1) = "3")
						THEN "Use"
					WHEN PageSection = 7
						THEN "Customer Service"
					WHEN (PageSection IN (1, 2)) AND SUBSTR(Placement, 1, 1) = "4"
						THEN "Tile_" || SUBSTR(Placement, 1, 1)
				END
			WHEN Page_Group = "Deals LP"
				THEN CASE
					WHEN Segment LIKE "%ControlGroup%"
						THEN CASE
							WHEN PageSection = 4 AND Placement = 1
								THEN "MEOs"
							WHEN PageSection = 4 AND Placement = 2
								THEN "Top Deals"
							ELSE "Other"
						END
					WHEN (Segment LIKE "%-MEO%") OR (Segment LIKE "%Targeted%")
						THEN "MEOs"
					WHEN Segment LIKE "%DealsByDestination%"
						THEN "Top Deals"
					WHEN Segment LIKE "%OngoingDeals%"
						THEN "Ongoing Deals"
					WHEN Segment LIKE "%TopDeals%"
						THEN "Top Deals"
					WHEN Segment LIKE "%Packages%"
						THEN "Packages"
					WHEN Segment LIKE "%InternationalDeals%"
						THEN "International Deals"
				END
			WHEN Page_Group = "Earn"
				THEN CASE
					WHEN PageSection = 7 AND Placement = 2
						THEN "Benefits Tile"
					WHEN PageSection = 4 AND Placement = 1
						THEN "Hotel Brands-1"
					WHEN PageSection = 5 AND Placement = 1
						THEN "Hotel Brands-2"
					WHEN PageSection = 4 AND Placement = 2
						THEN "Partners-1"
					WHEN PageSection = 5 AND Placement = 2
						THEN "Partners-2"
					WHEN PageSection = 4 AND Placement = 3
						THEN "Bonus Offers-1"
					WHEN PageSection = 5 AND Placement = 3
						THEN "Bonus Offers-1"
				END
			WHEN Page_Group = "Use"
				THEN CASE
					WHEN PageSection = 7 AND Placement = 1
						THEN "Customer Service"
				END
			WHEN Page_Group LIKE "%Trip%" THEN
				CASE PageSection
					WHEN 1
						THEN "Image"
					WHEN 2
						THEN  "Link 1"
					WHEN 3
						THEN "Link 2"
					WHEN 4
						THEN "Link 3"
					WHEN 5
						THEN "Link 4"
				END
			WHEN Page_Group = "MR Customer Service"
				THEN "Res. & CS links"
			WHEN Page_Group = "Use Points-Leisure"
				THEN "Golf-Elite Members Only"
			WHEN Page_Group = "Use Points-Gift Card"
				THEN "Gift Card-Elite Members Only"
			ELSE "Undefined"		
		END
	)
	
WHERE 
	Placement_Name IS NULL AND 
	DATE(Date) >= DATE("2014-01-01");
