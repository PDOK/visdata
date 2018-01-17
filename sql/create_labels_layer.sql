DROP TABLE IF EXISTS visdata.labels_point CASCADE;
CREATE TABLE visdata.labels_point (
  lod1 text,
  lod2 text, 
  name text,
  z_index integer,
  original_source text,
  original_id text,
  geom geometry(POINT,28992) 
);

---BGT 
INSERT INTO visdata.labels_point
  SELECT
    'building_number'             AS lod1,
    ''                            AS lod2,
    s.tekst                       AS name,
    s.hoek                        AS z_index,
    'BGT'                         AS original_source,
    'NL.IMGeo.' || s."_id"   AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    bgtv3."Pand$nummeraanduidingreeks$positie" AS s
;

---BGT 
INSERT INTO visdata.labels_point
  SELECT
    CASE
      WHEN
        s."openbareRuimteType" = 'Weg'
      THEN 'road'
      WHEN 
        s."openbareRuimteType" ='Spoorbaan'
      THEN 'railways'
      WHEN 
        s."openbareRuimteType" ='Water'
      THEN 'water'
      WHEN
        s."openbareRuimteType" ='Kunstwerk'
      THEN 'functional'
      WHEN
        s."openbareRuimteType" ='Terrein'
      THEN 'residential'
      ELSE s."openbareRuimteType"
    END                           AS lod1,
    s."openbareRuimteType"        AS lod2,
    s."openbareRuimteNaam"        AS name,
    s.hoek                        AS z_index,
    'BGT'                         AS original_source,
    'NL.IMGeo.' || s."_id"   AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    bgtv3."OpenbareRuimteLabel$positie" AS s
;

-- TOP10NL
INSERT INTO visdata.labels_point
  SELECT
    CASE 
      WHEN 
        s.typegeografischgebied = 'overig'
        OR s.typegeografischgebied = 'duingebied'
        OR s.typegeografischgebied = 'bosgebied'
        OR s.typegeografischgebied = 'polder'
        OR s.typegeografischgebied = 'terp, wierde'
        OR s.typegeografischgebied = 'streek, veld'
        OR s.typegeografischgebied = 'heuvel, berg'
        OR s.typegeografischgebied = 'eiland'
        OR s.typegeografischgebied = 'heidegebied'
        OR s.typegeografischgebied = 'kaap, hoek'
      THEN 'natural_areas'
      WHEN 
        s.typegeografischgebied = 'watergebied'
        OR s.typegeografischgebied = 'zeegat, zeearm'
        OR s.typegeografischgebied = 'wad'
        OR s.typegeografischgebied = 'geul, vaargeul'
        OR s.typegeografischgebied = 'bank, ondiepte, plaat'
        OR s.typegeografischgebied = 'zee'
      THEN 'water'
      ELSE 
        s.typegeografischgebied
    END                                              AS lod1,
    s.typegeografischgebied                          AS lod2,
    COALESCE(
      NULLIF(s.naamfries, ''), 
      NULLIF(s.naamnl, ''), 
      '')                                            AS name,
    0                                                AS z_index,
    'TOP10NL'                                        AS original_source,
    'NL.TOP10NL.' || s.lokaalid                      AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    top10nlv2.geografischgebied AS s
;

-- TOP10NL
INSERT INTO visdata.labels_point
  SELECT
    CASE 
      WHEN 
        s.typefunctioneelgebied =  'boswachterij' 
        OR s.typefunctioneelgebied =  'infiltratiegebied' 
        OR s.typefunctioneelgebied =  'landgoed' 
        OR s.typefunctioneelgebied =  'natuurgebied, natuurreservaat' 
        OR s.typefunctioneelgebied =  'overig' 
        OR s.typefunctioneelgebied =  'park' 
        OR s.typefunctioneelgebied =  'tennispark' 
        OR s.typefunctioneelgebied =  'werf' 
      THEN 'natural_areas'
      WHEN 
        s.typefunctioneelgebied =  'haven' 
      THEN 'water'
      WHEN
        s.typefunctioneelgebied =  'emplacement' 
        OR s.typefunctioneelgebied =  'gebouwencomplex' 
      THEN 'residential'
      ELSE 
        s.typefunctioneelgebied
    END                                              AS lod1,
    s.typefunctioneelgebied                          AS lod2,
    COALESCE(
      NULLIF(s.naamfries, ''), 
      NULLIF(s.naamnl, ''), 
      '')                                            AS name,
    0                                                AS z_index,
    'TOP10NL'                                        AS original_source,
    'NL.TOP10NL.' || s.lokaalid                      AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    top10nlv2.functioneelgebied AS s
;

-- --TOP50NL
-- Geen plaats
-- Geen geografisch gebied punten en vlakken 

INSERT INTO visdata.labels_point
  SELECT
    'functional' AS lod1,
    s.typefunctioneelgebied AS lod2,
    COALESCE(
      NULLIF(s.naamfries, ''), 
      NULLIF(s.naamnl, ''), 
      '')             AS name,
    0                    AS z_index,
    'TOP50NL'          AS original_source,
    s.namespace || '.' || s.lokaalid  AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    top50nl.functioneelgebied_punt AS s ;

-- --------------------------------------------------------

-- --TOP100NL
-- -- Geen plaats
-- -- Geen geografisch gebied punten en vlakken 

INSERT INTO visdata.labels_point
  SELECT
    'functional' AS lod1,
    s.typefunctioneelgebied AS lod2,
    COALESCE(
      NULLIF(s.naamfries, ''), 
      NULLIF(s.naamnl, ''), 
      '')             AS name,
    0                    AS z_index,
    'TOP100NL'          AS original_source,
    s.namespace || '.' || s.lokaalid  AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    top100nl.functioneelgebied_punt AS s ;

-- ---------------------------------------------------

-- --TOP250NL

INSERT INTO visdata.labels_point
  SELECT
    'functional' AS lod1,
    s.typefunctioneelgebied AS lod2,
    COALESCE(
      NULLIF(s.naamfries, ''), 
      NULLIF(s.naamnl, ''), 
      '')             AS name,
    0                    AS z_index,
    'TOP250NL'          AS original_source,
    s.namespace || '.' || s.lokaalid  AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    top250nl.functioneelgebied_punt AS s ;

INSERT INTO visdata.labels_point
  SELECT
    CASE
      WHEN
        s.typegeografischgebied ='watergebied'
        OR s.typegeografischgebied ='zeegat, zeearm'
        OR s.typegeografischgebied ='bank, ondiepte, plaat'
      THEN 'water'
      WHEN
        s.typegeografischgebied ='bosgebied'
      THEN 'natural_areas'
      ELSE s.typegeografischgebied
    END                     AS lod1,
    s.typegeografischgebied AS lod2,
    COALESCE(
      NULLIF(s.naamfries, ''), 
      NULLIF(s.naamnl, ''), 
      '')                AS name,
    0                    AS z_index,
    'TOP250NL'          AS original_source,
    s.namespace || '.' || s.lokaalid  AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    top250nl.geografischgebied_punt AS s ;

-- ---------------------------------------------------
INSERT INTO visdata.labels_point
  SELECT
    'functional' AS lod1,
    s.typefunctioneelgebied AS lod2,
    COALESCE(
      NULLIF(s.naamfries, ''), 
      NULLIF(s.naamnl, ''), 
      '')             AS name,
    0                    AS z_index,
    'TOP500NL'          AS original_source,
    s.namespace || '.' || s.lokaalid  AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    top500nl.functioneelgebied_punt AS s ;

INSERT INTO visdata.labels_point
  SELECT
    CASE
      WHEN
        s.typegeografischgebied ='watergebied'
        OR s.typegeografischgebied ='zeegat, zeearm'
        OR s.typegeografischgebied ='bank, ondiepte, plaat'
      THEN 'water'
      WHEN
        s.typegeografischgebied ='bosgebied'
      THEN 'natural_areas'
      ELSE s.typegeografischgebied
    END                     AS lod1,
    s.typegeografischgebied AS lod2,
    COALESCE(
      NULLIF(s.naamfries, ''), 
      NULLIF(s.naamnl, ''), 
      '')                AS name,
    0                    AS z_index,
    'TOP500NL'          AS original_source,
    s.namespace || '.' || s.lokaalid  AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    top500nl.geografischgebied_punt AS s ;

-- ---------------------------------------------------

--TOP1000
INSERT INTO visdata.labels_point
  SELECT
    'functional' AS lod1,
    s.typefunctioneelgebied AS lod2,
    COALESCE(
      NULLIF(s.naamfries, ''), 
      NULLIF(s.naamnl, ''), 
      '')             AS name,
    0                    AS z_index,
    'TOP1000NL'          AS original_source,
    s.namespace || '.' || s.lokaalid  AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    top1000nl.functioneelgebied_punt AS s ;

INSERT INTO visdata.labels_point
  SELECT
    'water'              AS lod1,
    s.typegeografischgebied AS lod2,
    COALESCE(
      NULLIF(s.naamfries, ''), 
      NULLIF(s.naamnl, ''), 
      '')                AS name,
    0                    AS z_index,
    'TOP1000NL'          AS original_source,
    s.namespace || '.' || s.lokaalid  AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    top1000nl.geografischgebied_punt AS s ;

-- Controle
SELECT
    original_source,
    lod1,
    COUNT(*) AS aantal 
FROM
    visdata.labels_point
GROUP BY original_source, lod1
ORDER BY original_source, lod1;



------------------------------------------
-- MAKIGN LABELS COBINED
------------------------------------------
---- TOP10
DROP TABLE IF EXISTS visdata.labels_point_v1 CASCADE;
CREATE TABLE visdata.labels_point_v1 AS
  SELECT 
    namespace,
    lokaalid,
    'TOP10NL'::text          AS original_source,
    aantalinwoners::integer,
    COALESCE(
      NULLIF(naamofficieel, ''), 
      NULLIF(naamfries, ''), 
      NULLIF(naamnl, ''), 
      '') AS name,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(_geometry,1)))).geom::geometry(POINT,28992) AS wkb_geometry
  FROM 
    top10nlv2.plaats
;

-- TOP10
DROP TABLE IF EXISTS visdata.top10_labels_point_from_polygon CASCADE;
CREATE TABLE visdata.top10_labels_point_from_polygon AS
SELECT
    ST_Area(_geometry) AS area,
    namespace,
    lokaalid,
    'TOP10NL'::text          AS original_source,
    aantalinwoners::integer,
    COALESCE(
      NULLIF(naamofficieel, ''),
      NULLIF(naamfries, ''), 
      NULLIF(naamnl, ''), 
      '')                   AS name,
    (ST_Dump(ST_PointOnSurface(_geometry))).geom::geometry(POINT,28992) AS wkb_geometry
  FROM
    top10nlv2.plaats
  WHERE GeometryType(_geometry) = 'POLYGON' AND typegebied = 'buurtschap' OR typegebied = 'gehucht' OR typegebied = 'woonkern'
  GROUP BY 
    namespace,
    lokaalid,
    original_source,
    aantalinwoners, 
    name,
    _geometry
;

DELETE
FROM
    visdata.top10_labels_point_from_polygon a
        USING visdata.top10_labels_point_from_polygon b
WHERE
    a.area < b.area
    AND a.name = b.name
;

INSERT INTO visdata.labels_point_v1 
SELECT
  namespace,
  lokaalid,
  original_source::text,
  aantalinwoners::integer,
  name,
  wkb_geometry
FROM 
    visdata.top10_labels_point_from_polygon 
;

-- -- TOP250
-- INSERT INTO visdata.labels_point_v1 
--   SELECT 
--     s.namespace,
--     s.lokaalid,
--     'TOP250NL'::text          AS original_source,
--     s.aantalinwoners,
--     COALESCE(
--       NULLIF(s.naamfries, ''), 
--       NULLIF(s.naamnl, ''), 
--       '') AS name,
--     (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,1)))).geom::geometry(POINT,28992) AS wkb_geometry
--   FROM 
--     top250nl.plaats_punt AS s
--   left join
--     visdata.labels_point_v1 b on st_distance(s.wkb_geometry, b.wkb_geometry) <= 1000 AND (s.name=b.name ) 
--   WHERE 
--     typegebied = 'woonkern'
--     AND b.name is NULL
    
-- ;

-- --TOP250
-- --- plaats polygonene naar punt
-- DROP TABLE IF EXISTS visdata.top250_labels_point_from_polygon CASCADE;

-- CREATE TABLE visdata.top250_labels_point_from_polygon AS
-- SELECT
--     ST_Area(wkb_geometry) AS area,
--     lokaalid,
--     namespace,
--     'TOP250NL'::text          AS original_source,
--     aantalinwoners,
--     COALESCE(
--       NULLIF(naamofficieel, ''),
--       NULLIF(naamfries, ''), 
--       NULLIF(naamnl, ''), 
--       '')                   AS name,
--     (ST_Dump(ST_PointOnSurface(wkb_geometry))).geom::geometry(POINT,28992) AS wkb_geometry
--   FROM
--     top250nl.plaats_vlak
--   WHERE GeometryType(wkb_geometry) = 'POLYGON' AND typegebied = 'buurtschap' OR typegebied = 'gehucht' OR typegebied = 'woonkern'
--   GROUP BY 
--     namespace,
--     lokaalid,
--     original_source,
--     aantalinwoners, 
--     name,
--     wkb_geometry
-- ;

-- DELETE
-- FROM
--     visdata.top250_labels_point_from_polygon a
--         USING visdata.top250_labels_point_from_polygon b
-- WHERE
--     a.area < b.area
--     AND a.name = b.name;

-- INSERT INTO visdata.labels_point_v1 
-- SELECT
--   s.namespace,
--   s.lokaalid,
--   s.original_source::text,
--   s.aantalinwoners::integer,
--   s.name,
--   s.wkb_geometry
-- FROM 
--     visdata.top250_labels_point_from_polygon as s
--   left join
--     visdata.labels_point_v1 b on st_distance(s.wkb_geometry, b.wkb_geometry) <= 1000 and (s.name=b.name )
--   WHERE 
--     b.name is NULL
    
-- ;



-- TOP500
INSERT INTO visdata.labels_point_v1 
  SELECT 
    s.namespace,
    s.lokaalid,
    'TOP500NL'::text          AS original_source,
    s.aantalinwoners::integer,
    COALESCE(
      NULLIF(s.naamfries, ''), 
      NULLIF(s.naamnl, ''), 
      '') AS name,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,1)))).geom::geometry(POINT,28992) AS wkb_geometry
  FROM 
    top500nl.plaats_punt AS s
  left join
    visdata.labels_point_v1 b on st_distance(s.wkb_geometry, b.wkb_geometry) <= 5000 and (s.naamnl=b.name OR s.naamfries =b.name)
  WHERE 
    b.name is NULL
;

--TOP500
--- plaats polygonene naar punt
DROP TABLE IF EXISTS visdata.top500_labels_point_from_polygon CASCADE;

CREATE TABLE visdata.top500_labels_point_from_polygon AS
SELECT
    ST_Area(wkb_geometry) AS area,
    lokaalid,
    namespace,
    'TOP500NL'::text          AS original_source,
    aantalinwoners::integer,
    COALESCE(
      NULLIF(naamofficieel, ''),
      NULLIF(naamfries, ''), 
      NULLIF(naamnl, ''), 
      '')                   AS name,
    (ST_Dump(ST_PointOnSurface(wkb_geometry))).geom::geometry(POINT,28992) AS wkb_geometry
  FROM
    top500nl.plaats_vlak
  WHERE GeometryType(wkb_geometry) = 'POLYGON' AND typegebied = 'buurtschap' OR typegebied = 'gehucht' OR typegebied = 'woonkern'
  GROUP BY 
    namespace,
    lokaalid,
    original_source,
    aantalinwoners, 
    name,
    wkb_geometry
;

DELETE
FROM
    visdata.top500_labels_point_from_polygon a
        USING visdata.top500_labels_point_from_polygon b
WHERE
    a.area < b.area
    AND a.name = b.name;

INSERT INTO visdata.labels_point_v1 
SELECT
  s.namespace,
  s.lokaalid,
  s.original_source::text,
  s.aantalinwoners::integer,
  s.name,
  s.wkb_geometry
FROM 
    visdata.top500_labels_point_from_polygon as s
  left join
    visdata.labels_point_v1 b on st_distance(s.wkb_geometry, b.wkb_geometry) <= 5000 and (s.name=b.name )
  WHERE 
    b.name is NULL
    
;


-- TOP1000
INSERT INTO visdata.labels_point_v1 
  SELECT 
    s.namespace,
    s.lokaalid,
    'TOP1000NL'::text          AS original_source,
    s.aantalinwoners::integer,
    COALESCE(
      NULLIF(s.naamfries, ''), 
      NULLIF(s.naamnl, ''), 
      '') AS name,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,1)))).geom::geometry(POINT,28992) AS wkb_geometry
  FROM 
    top1000nl.plaats_punt AS s
  left join
    visdata.labels_point_v1 b on st_distance(s.wkb_geometry, b.wkb_geometry) <= 3000 and (s.naamnl=b.name or s.naamfries=b.name)
  WHERE 
    b.name is NULL
;

--TOP1000
--- plaats polygonene naar punt
DROP TABLE IF EXISTS visdata.top1000_labels_point_from_polygon CASCADE;

CREATE TABLE visdata.top1000_labels_point_from_polygon AS
SELECT
    ST_Area(wkb_geometry) AS area,
    lokaalid,
    namespace,
    'TOP1000NL'::text          AS original_source,
    aantalinwoners::integer,
    COALESCE(
      NULLIF(naamofficieel, ''),
      NULLIF(naamfries, ''), 
      NULLIF(naamnl, ''), 
      '')                   AS name,
    (ST_Dump(ST_PointOnSurface(wkb_geometry))).geom::geometry(POINT,28992) AS wkb_geometry
  FROM
    top1000nl.plaats_vlak
  WHERE GeometryType(wkb_geometry) = 'POLYGON' AND typegebied = 'buurtschap' OR typegebied = 'gehucht' OR typegebied = 'woonkern'
  GROUP BY 
    namespace,
    lokaalid,
    original_source,
    aantalinwoners, 
    name,
    wkb_geometry
;

DELETE
FROM
    visdata.top1000_labels_point_from_polygon a
        USING visdata.top1000_labels_point_from_polygon b
WHERE
    a.area < b.area
    AND a.name = b.name;

INSERT INTO visdata.labels_point_v1 
SELECT
  s.namespace,
  s.lokaalid,
  s.original_source::text,
  s.aantalinwoners::integer,
  s.name,
  s.wkb_geometry
FROM 
    visdata.top1000_labels_point_from_polygon as s
  left join
    visdata.labels_point_v1 b on st_distance(s.wkb_geometry, b.wkb_geometry) <= 7000 and (s.name=b.name )
  WHERE 
    b.name is NULL
;


--TOP100
-- GEEN DATA


--TOP50
-- GEED DATA


ALTER TABLE visdata.labels_point_v1 ADD COLUMN z_index integer; 


UPDATE visdata.labels_point_v1 AS s
SET z_index = 100000
    WHERE 
        s.name='Haarlem' 
         OR s.name='''s-Gravenhage'
         OR s.name='Middelburg' 
         OR s.name='Utrecht' 
         OR s.name='''s-Hertogenbosch' 
         OR s.name='Maastricht' 
         OR s.name='Arnhem' 
         OR s.name='Zwolle' 
         OR s.name='Assen' 
         OR s.name='Groningen' 
         OR s.name='Leeuwarden' 
         OR s.name='Lelystad'
;

UPDATE visdata.labels_point_v1 AS s
SET z_index = 10000
    WHERE aantalinwoners >=150000  
    AND (s.name!='Haarlem' 
         AND s.name!='''s-Gravenhage'
         AND s.name!='Middelburg' 
         AND s.name!='Utrecht' 
         AND s.name!='''s-Hertogenbosch' 
         AND s.name!='Maastricht' 
         AND s.name!='Arnhem' 
         AND s.name!='Zwolle' 
         AND s.name!='Assen' 
         AND s.name!='Groningen' 
         AND s.name!='Leeuwarden' 
         AND s.name!='Lelystad')
;

UPDATE visdata.labels_point_v1 AS s
SET z_index = 1000
    WHERE aantalinwoners  <150000 AND aantalinwoners >= 100000
    AND (s.name!='Haarlem' 
         AND s.name!='''s-Gravenhage'
         AND s.name!='Middelburg' 
         AND s.name!='Utrecht' 
         AND s.name!='''s-Hertogenbosch' 
         AND s.name!='Maastricht' 
         AND s.name!='Arnhem' 
         AND s.name!='Zwolle' 
         AND s.name!='Assen' 
         AND s.name!='Groningen' 
         AND s.name!='Leeuwarden' 
         AND s.name!='Lelystad')
;

UPDATE visdata.labels_point_v1 AS s
SET z_index = 100
    WHERE aantalinwoners  <100000 AND aantalinwoners >= 50000
    AND (s.name!='Haarlem' 
         AND s.name!='''s-Gravenhage'
         AND s.name!='Middelburg' 
         AND s.name!='Utrecht' 
         AND s.name!='''s-Hertogenbosch' 
         AND s.name!='Maastricht' 
         AND s.name!='Arnhem' 
         AND s.name!='Zwolle' 
         AND s.name!='Assen' 
         AND s.name!='Groningen' 
         AND s.name!='Leeuwarden' 
         AND s.name!='Lelystad')
;

UPDATE visdata.labels_point_v1 AS s
SET z_index = 10
    WHERE aantalinwoners  <50000 AND aantalinwoners >= 10000
    AND (s.name!='Haarlem' 
         AND s.name!='''s-Gravenhage'
         AND s.name!='Middelburg' 
         AND s.name!='Utrecht' 
         AND s.name!='''s-Hertogenbosch' 
         AND s.name!='Maastricht' 
         AND s.name!='Arnhem' 
         AND s.name!='Zwolle' 
         AND s.name!='Assen' 
         AND s.name!='Groningen' 
         AND s.name!='Leeuwarden' 
         AND s.name!='Lelystad')
;

UPDATE visdata.labels_point_v1 AS s
SET z_index = 1
    WHERE aantalinwoners  < 10000 AND aantalinwoners >= 1
    AND (s.name!='Haarlem' 
         AND s.name!='''s-Gravenhage'
         AND s.name!='Middelburg' 
         AND s.name!='Utrecht' 
         AND s.name!='''s-Hertogenbosch' 
         AND s.name!='Maastricht' 
         AND s.name!='Arnhem' 
         AND s.name!='Zwolle' 
         AND s.name!='Assen' 
         AND s.name!='Groningen' 
         AND s.name!='Leeuwarden' 
         AND s.name!='Lelystad')
;

UPDATE visdata.labels_point_v1 AS s
SET z_index = 1
    WHERE aantalinwoners  < 10000 AND aantalinwoners >= 1
    AND (s.name!='Haarlem' 
         AND s.name!='''s-Gravenhage'
         AND s.name!='Middelburg' 
         AND s.name!='Utrecht' 
         AND s.name!='''s-Hertogenbosch' 
         AND s.name!='Maastricht' 
         AND s.name!='Arnhem' 
         AND s.name!='Zwolle' 
         AND s.name!='Assen' 
         AND s.name!='Groningen' 
         AND s.name!='Leeuwarden' 
         AND s.name!='Lelystad')
;


UPDATE visdata.labels_point_v1 AS s
SET z_index = 0
    WHERE aantalinwoners  IS NULL OR aantalinwoners = 0 
;

SELECT z_index, count(*) FROM visdata.labels_point_v1 GROUP BY z_index ORDER BY z_index;

INSERT INTO visdata.labels_point
  SELECT
    'residential'              AS lod1,
    ''                 AS lod2,
    name               AS name,
    s.z_index   AS z_index,
    s.original_source  AS original_source,
    s.namespace || '.' || s.lokaalid  AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    visdata.labels_point_v1 AS s ;

