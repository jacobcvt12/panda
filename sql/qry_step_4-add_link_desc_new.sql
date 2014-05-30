-- make sure indexes are created!
-- greatly speeds up joins in query 4
CREATE INDEX IF NOT EXISTS mrlp_contentid_idx
ON mrlp (ContentID);

CREATE INDEX IF NOT EXISTS guid_contentid_idx
ON mrlp_guid_metadata (ContentID);

UPDATE mrlp
SET Link_Text =
(SELECT Link_Text FROM mrlp_guid_metadata
 WHERE mrlp.ContentID = mrlp_guid_metadata.ContentID),
Classification = 
(SELECT Classification FROM mrlp_guid_metadata
 WHERE mrlp.ContentID = mrlp_guid_metadata.ContentID)
WHERE Link_Text IS NULL;