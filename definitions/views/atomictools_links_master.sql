CREATE OR REPLACE VIEW atomictools_links_master AS
    SELECT
        link.tools_contract, link.link_id, link.asset_contract, link.creator, link.state
        encode(link.txid::bytea, 'hex') txid,
        ARRAY(
            SELECT asset_id
            FROM atomictools_links_assets asset
            WHERE asset.link_id = link.link_id AND asset.tools_contract = link.tools_contract
        ) assets,
        link.created_at_block, link.created_at_time
    FROM atomictools_links link
