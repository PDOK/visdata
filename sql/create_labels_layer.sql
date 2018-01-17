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

-- TOP10NL
INSERT INTO visdata.labels_point
  SELECT
    CASE 
      WHEN 
        s.typegebied ='wijk'
        OR s.typegebied ='buurtschap'
        OR s.typegebied ='woonkern'
        OR s.typegebied ='gehucht'
        OR s.typegebied ='stadsdeel'
        OR s.typegebied ='buurt'
        OR s.typegebied ='recreatiekern'
        OR s.typegebied ='industriekern'
        OR s.typegebied ='deelkern'
      THEN 'residential'
      ELSE s.typegebied
    END                                              AS lod1,
    s.typegebied                          AS lod2,
    COALESCE(
      NULLIF(s.naamofficieel, ''),
      NULLIF(s.naamfries, ''), 
      NULLIF(s.naamnl, ''), 
      '')                                            AS name,
    0                                                AS z_index,
    'TOP10NL'                                        AS original_source,
    'NL.TOP10NL.' || s.lokaalid                      AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    top10nlv2.plaats AS s
;





--------------------------------------------------------

--TOP50NL
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

--------------------------------------------------------

--TOP100NL
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
    'TOP100NL'          AS original_source,
    s.namespace || '.' || s.lokaalid  AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    top100nl.functioneelgebied_punt AS s ;

---------------------------------------------------

--TOP250NL
INSERT INTO visdata.labels_point
  SELECT
    'residential'        AS lod1,
    s.typegebied         AS lod2,
    COALESCE(
      NULLIF(s.naamofficieel, ''),
      NULLIF(s.naamfries, ''), 
      NULLIF(s.naamnl, ''), 
      '')                AS name_NL,
    0                    AS z_index,
    'TOP250NL'          AS original_source,
    s.namespace || '.' || s.lokaalid  AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    top250nl.plaats_punt AS s ;

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
      '')                AS name_NL,
    0                    AS z_index,
    'TOP250NL'          AS original_source,
    s.namespace || '.' || s.lokaalid  AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    top250nl.geografischgebied_punt AS s ;

---------------------------------------------------

--TOP500NL
INSERT INTO visdata.labels_point
  SELECT
    'residential'        AS lod1,
    s.typegebied         AS lod2,
    COALESCE(
      NULLIF(s.naamofficieel, ''),
      NULLIF(s.naamfries, ''), 
      NULLIF(s.naamnl, ''), 
      '')                AS name_NL,
    0                    AS z_index,
    'TOP500NL'          AS original_source,
    s.namespace || '.' || s.lokaalid  AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    top500nl.plaats_punt AS s ;

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
      '')                AS name_NL,
    0                    AS z_index,
    'TOP500NL'          AS original_source,
    s.namespace || '.' || s.lokaalid  AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    top500nl.geografischgebied_punt AS s ;

---------------------------------------------------

-- TOP1000

INSERT INTO visdata.labels_point
  SELECT
    'residential'        AS lod1,
    s.typegebied         AS lod2,
    COALESCE(
      NULLIF(s.naamofficieel, ''),
      NULLIF(s.naamfries, ''), 
      NULLIF(s.naamnl, ''), 
      '')                AS name_NL,
    0                    AS z_index,
    'TOP1000NL'          AS original_source,
    s.namespace || '.' || s.lokaalid  AS original_id,
    (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,1)))).geom::geometry(POINT,28992) AS geom
  FROM 
    top1000nl.plaats_punt AS s ;

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
      '')                AS name_NL,
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


