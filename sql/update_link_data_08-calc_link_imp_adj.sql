UPDATE 
	mrlp 
SET 
	Link_Impr_Adj = Link_Impressions
WHERE 
	Link_Impr_Adj < 1 AND 
	DATE(Date) >= DATE("2012-10-01");
