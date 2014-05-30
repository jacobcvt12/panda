UPDATE mrlp
SET Department = 
(SELECT Department
 FROM Control_Non_Deals
 WHERE
 mrlp.Date = Control_Non_Deals.Date 
 AND mrlp.Site = Control_Non_Deals.Site
 AND mrlp.Page_Group = Control_Non_Deals.Page_Group
 AND mrlp.PageSectionPlacement = Control_Non_Deals.PageSectionPlacement)

 WHERE Department = "TBD" 
AND Page_Group != "Deals LP" 
AND Rule_Group LIKE "%control%";
