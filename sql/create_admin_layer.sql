DROP TABLE IF EXISTS visdata.admin CASCADE;
CREATE TABLE visdata.admin (
            lod1 text,
            name text,
            z_index integer,
            original_source text,
            original_id text,
            geom geometry(POLYGON,28992) 
        );

-- bgt REGISTRATIEFGEBIED IS NIET VERPLICHT!
-- --BGT
-- INSERT INTO visdata.admin
-- SELECT
--     17 AS minzoom,
--     16 AS maxzoom,
--     'neighborhood' AS lod1,
--     s.naam AS name,
--     0 AS z_index,
--     'BGT' AS original_source,
--     s.namespace || s.lokaalid AS original_id,
--     (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
-- FROM 
--     bgt.buurt_2dactueelbestaand AS s
-- ;

-- INSERT INTO visdata.admin
-- SELECT
--     17 AS minzoom,
--     14 AS maxzoom,
--     'city-district' AS lod1,
--     s.naam AS name,
--     0 AS z_index,
--     'BGT' AS original_source,
--     s.namespace || s.lokaalid AS original_id,
--     (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
-- FROM 
--     bgt.wijk_2dactueelbestaand AS s
-- ;

-- INSERT INTO visdata.admin
-- SELECT
--     17 AS minzoom,
--     0 AS maxzoom,
--     'waterhouse' AS lod1,
--     s.naam AS name,
--     0 AS z_index,
--     'BGT' AS original_source,
--     s.namespace || s.lokaalid AS original_id,
--     (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
-- FROM 
--     bgt.waterschap_2dactueelbestaand AS s
-- ;

-- TOP10NL 
INSERT INTO visdata.admin
    SELECT
            CASE 
                WHEN 
                    s.typeregistratiefgebied = 'land'
                THEN 'country'
                WHEN 
                    s.typeregistratiefgebied = 'provincie' 
                THEN 'province'
                WHEN 
                    s.typeregistratiefgebied = 'gemeente'
                THEN 'municipality'
                else s.typeregistratiefgebied
            END AS lod1,
            s.naamnl             AS name,
            0                    AS z_index,
            'Top10NL'          AS original_source,
            s.gml_id             AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
        latest.registratiefgebied_vlak AS s
         WHERE 
        s.typeregistratiefgebied != 'territoriale zee' 
        AND      s.typeregistratiefgebied != 'enclave'
;

-- TOP50NL 
INSERT INTO visdata.admin
    SELECT
            CASE 
                WHEN 
                    s.typeregistratiefgebied = 'land'
                THEN 'country'
                WHEN 
                    s.typeregistratiefgebied = 'provincie' 
                THEN 'province'
                WHEN 
                    s.typeregistratiefgebied = 'gemeente'
                THEN 'municipality'
                else s.typeregistratiefgebied
            END AS lod1,
            s.naamnl             AS name,
            0                    AS z_index,
            'Top50NL'          AS original_source,
            s.gml_id             AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
        top50_3.registratiefgebied AS s
    WHERE
        s.typeregistratiefgebied != 'territoriale zee' 
    	
        AND s.typeregistratiefgebied != 'enclave'
;


-- TOP100NL 
INSERT INTO visdata.admin
    SELECT
            CASE 
                WHEN 
                    s.typeregistratiefgebied = 'land'
                THEN 'country'
                WHEN 
                    s.typeregistratiefgebied = 'provincie' 
                THEN 'province'
                WHEN 
                    s.typeregistratiefgebied = 'gemeente'
                THEN 'municipality'
                else s.typeregistratiefgebied
            END AS lod1,
            s.naamnl             AS name,
            0                    AS z_index,
            'Top100NL'          AS original_source,
            s.gml_id             AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
        top100.registratiefgebied AS s
    WHERE 
        s.typeregistratiefgebied != 'territoriale zee' 
        AND      s.typeregistratiefgebied != 'enclave'

;


-- TOP250NL 
INSERT INTO visdata.admin
    SELECT
            CASE 
                WHEN 
                    s.typeregistratiefgebied = 'land'
                THEN 'country'
                WHEN 
                    s.typeregistratiefgebied = 'provincie' 
                THEN 'province'
                WHEN 
                    s.typeregistratiefgebied = 'gemeente'
                THEN 'municipality'
             else s.typeregistratiefgebied
            END AS lod1,
            s.naamnl             AS name,
            0                    AS z_index,
            'Top250NL'          AS original_source,
            s.gml_id             AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
        top250.registratiefgebied AS s
    WHERE 
    	s.typeregistratiefgebied != 'territoriale zee'
        AND      s.typeregistratiefgebied != 'enclave'

;


-- TOP500NL 
INSERT INTO visdata.admin
    SELECT
            CASE 
                WHEN 
                    s.typeregistratiefgebied = 'land'
                THEN 'country'
                WHEN 
                    s.typeregistratiefgebied = 'provincie' 
                THEN 'province'
                WHEN 
                    s.typeregistratiefgebied = 'gemeente'
                THEN 'municipality'
             else s.typeregistratiefgebied
            END AS lod1,
            s.naamnl             AS name,
            0                    AS z_index,
            'Top500NL'          AS original_source,
            s.gml_id             AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
        top500.registratiefgebied AS s
    WHERE 
    	s.typeregistratiefgebied != 'territoriale zee'
        AND s.typeregistratiefgebied != 'enclave'

;

-- TOP1000NL 
INSERT INTO visdata.admin
    SELECT
            CASE 
                WHEN 
                    s.typeregistratiefgebied = 'land'
                THEN 'country'
                WHEN 
                    s.typeregistratiefgebied = 'provincie' 
                THEN 'province'
                WHEN 
                    s.typeregistratiefgebied = 'gemeente'
                THEN 'municipality'
               else s.typeregistratiefgebied
            END AS lod1,
            s.naamnl             AS name,
            0                    AS z_index,
            'Top1000NL'          AS original_source,
            s.gml_id             AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
        top1000.registratiefgebied AS s
    WHERE 
       s.typeregistratiefgebied != 'territoriale zee'
       AND s.typeregistratiefgebied != 'enclave'

;

--test
SELECT distinct(lod1) FROM visdata.admin;
SELECT count(*) FROM visdata.admin WHERE ST_Area(geom)=0;