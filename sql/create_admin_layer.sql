DROP TABLE IF EXISTS visdata.admin_polygon CASCADE;
CREATE TABLE visdata.admin_polygon (
  lod1 text,
  name text,
  z_index integer,
  original_source text,
  original_id text,
  geom geometry(POLYGON,28992) 
);

-- BGT: Geen data

-- TOP10NL
INSERT INTO visdata.admin_polygon
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
      ELSE 
        s.typeregistratiefgebied
    END                                              AS lod1,
    COALESCE(s.naamfries, s.naamofficieel, s.naamnl) AS name,
    0                                                AS z_index,
    'TOP10NL'                                        AS original_source,
    'NL.TOP10NL.' || s.lokaalid                      AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top10nlv2.registratiefgebied AS s
  WHERE 
    s.typeregistratiefgebied != 'territoriale zee' 
    AND s.typeregistratiefgebied != 'enclave'
;

-- TOP50NL 
INSERT INTO visdata.admin_polygon
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
      ELSE 
        s.typeregistratiefgebied
    END                                 AS lod1,
    COALESCE(s.naamfries, s.naamnl)     AS name,
    0                                   AS z_index,
    'TOP50NL'                           AS original_source,
    namespace || '.' || lokaalid        AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top50nl.registratiefgebied_vlak AS s
  WHERE
    s.typeregistratiefgebied != 'territoriale zee' 
    AND s.typeregistratiefgebied != 'enclave'
;

-- TOP100NL 
INSERT INTO visdata.admin_polygon
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
      ELSE 
        s.typeregistratiefgebied
    END                                AS lod1,
    COALESCE(s.naamfries, s.naamnl)    AS name,
    0                                  AS z_index,
    'TOP100NL'                         AS original_source,
    namespace || '.' || lokaalid       AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top100nl.registratiefgebied_vlak AS s
  WHERE 
    s.typeregistratiefgebied != 'territoriale zee' 
    AND s.typeregistratiefgebied != 'enclave'
;

-- TOP250NL 
INSERT INTO visdata.admin_polygon
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
      ELSE 
        s.typeregistratiefgebied
    END                                                 AS lod1,
    COALESCE(s.naamfries, s.naamofficieel, s.naamnl)    AS name,
    0                                                   AS z_index,
    'TOP250NL'                                          AS original_source,
    namespace || '.' || lokaalid                        AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top250nl.registratiefgebied_vlak AS s
  WHERE 
    s.typeregistratiefgebied != 'territoriale zee'
    AND s.typeregistratiefgebied != 'enclave'
;

-- TOP500NL 
INSERT INTO visdata.admin_polygon
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
      ELSE 
        s.typeregistratiefgebied
    END                                                 AS lod1,
    COALESCE(s.naamfries, s.naamofficieel, s.naamnl)    AS name,
    0                                                   AS z_index,
    'TOP500NL'                                          AS original_source,
    namespace || '.' || lokaalid                        AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top500nl.registratiefgebied_vlak AS s
  WHERE 
    s.typeregistratiefgebied != 'territoriale zee'
    AND s.typeregistratiefgebied != 'enclave'
;

-- TOP1000NL 
INSERT INTO visdata.admin_polygon
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
      ELSE 
        s.typeregistratiefgebied
    END                                                 AS lod1,
    COALESCE(s.naamfries, s.naamofficieel, s.naamnl)    AS name,
    0                                                   AS z_index,
    'TOP1000NL'                                         AS original_source,
    namespace || '.' || lokaalid                        AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top1000nl.registratiefgebied_vlak AS s
  WHERE 
     s.typeregistratiefgebied != 'territoriale zee'
     AND s.typeregistratiefgebied != 'enclave'
;

-- Indexen aanmaken
CREATE INDEX admin_polygon_sidx ON visdata.admin_polygon USING GIST(geom);
CREATE INDEX admin_polygon_source ON visdata.admin_polygon(original_source);

--Controle
SELECT
  original_source,
  lod1,
  COUNT(*) AS aantal 
FROM
  visdata.admin_polygon 
GROUP BY original_source, lod1 
ORDER BY original_source, lod1;