UPDATE mrlp
SET Link_Text =
(SELECT Link_Text FROM mrlp_guid_metadata
 WHERE mrlp.ContentID = mrlp_guid_metadata.ContentID),
Classification = 
(SELECT Classification FROM mrlp_guid_metadata
 WHERE mrlp.ContentID = mrlp_guid_metadata.ContentID);