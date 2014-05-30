CREATE TABLE IF NOT EXISTS Control_Non_Deals(
PageSectionPlacement TEXT, 
Page_Group TEXT, 
Site TEXT, 
Date TEXT, 
Department TEXT,
Sum_Of_Link_Impressions INTEGER);

DELETE FROM Control_Non_Deals;

INSERT INTO Control_Non_Deals
SELECT PageSectionPlacement, Page_Group, Site, Date, Department, Sum(Link_Impressions) AS Sum_Of_Link_Impressions
FROM mrlp
WHERE Rule_Group Not Like "%control%"
GROUP BY PageSectionPlacement, Page_Group, Site, Date, Department
HAVING Page_Group != "Deals LP"
ORDER BY PageSectionPlacement, Page_Group, Site, Department;