-- CREATE TABLE urban 

DROP TABLE IF EXISTS visdata.urban_polygon CASCADE;
CREATE TABLE visdata.urban_polygon (
      lod1 text,
      lod2 text,
      name_NL text,
      z_index integer,
      original_source text,
      original_id text,
      geom geometry(POLYGON,28992) 
    );

---------------------------------------------------
-- BGT panden to urban

INSERT INTO visdata.urban_polygon 
  SELECT
      'buildings'               AS lod1,
      'main_building'           AS lod2,
      ''                        AS name_NL,
      s.relatievehoogteligging  AS z_index,
      'BGT'                     AS original_source,
      s.namespace || s.lokaalid                 AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    bgt.pand_2dactueelbestaand AS s;

INSERT INTO visdata.urban_polygon 
  SELECT
      'buildings'               AS lod1,
      'other_buildings'         AS lod2,
      ''                        AS name_NL,
      s.relatievehoogteligging  AS z_index,
      'BGT'                     AS original_source,
      s.namespace || s.lokaalid                 AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    bgt.installatie_2dactueelbestaand AS s;

INSERT INTO visdata.urban_polygon 
  SELECT
      'buildings'               AS lod1,
      'other_buildings'         AS lod2,
      ''                        AS name_NL,
      s.relatievehoogteligging  AS z_index,
      'BGT'                     AS original_source,
      s.namespace || s.lokaalid                 AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    bgt.overigbouwwerk_2dactueelbestaand AS s;

INSERT INTO visdata.urban_polygon 
  SELECT
      'buildings'               AS lod1,
      'other_buildings'         AS lod2,
      ''                        AS name_NL,
      s.relatievehoogteligging  AS z_index,
      'BGT'                     AS original_source,
      s.namespace || s.lokaalid                 AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    bgt.kunstwerkdeel_2dactueelbestaand AS s;

INSERT INTO visdata.urban_polygon 
  SELECT
      'buildings'               AS lod1,
      'other_buildings'         AS lod2,
      ''                        AS name_NL,
      s.relatievehoogteligging  AS z_index,
      'BGT'                     AS original_source,
      s.namespace || s.lokaalid                 AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    bgt.gebouwinstallatie_2dactueelbestaand AS s;

INSERT INTO visdata.urban_polygon 
  SELECT
      'buildings'               AS lod1,
      'structures'              AS lod2,
      ''                        AS name_NL,
      s.relatievehoogteligging  AS z_index,
      'BGT'                     AS original_source,
      s.namespace || s.lokaalid                 AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    bgt.overigescheiding_2dactueelbestaand AS s;



-------------------------------------------------------------
-- Top10NL

INSERT INTO visdata.urban_polygon
  SELECT
      'buildings'               AS lod1,
      'main_building'           AS lod2,
      s.naam                    AS name_NL,
      s.hoogteniveau            AS z_index,
      'Top10NL'                 AS original_source,
      s.gml_id                  AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    latest.gebouw_vlak AS s;

-- INSERT INTO visdata.urban_polygon
--   SELECT
--       'urban_area'              AS lod1,
--       s.naamnl                  AS name_NL,
--       0                         AS z_index,
--       'Top10NL'                 AS original_source,
--       s.gml_id                  AS original_id,
--       (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
--   FROM 
--     latest.plaats_vlak AS s;

-- INSERT INTO visdata.urban_polygon
--   SELECT
--       'urban_area'              AS lod1,
--       s.naam                  AS name_NL,
--       0                         AS z_index,
--       'Top10NL'                 AS original_source,
--       s.gml_id                  AS original_id,
--       (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
--   FROM 
--     latest.terrein_vlak AS s
--   WHERE
--     typelandgebruik = 'bebouwd gebied';

-- Top50 
----------------------------------------------------------

INSERT INTO visdata.urban_polygon
  SELECT
      'buildings'               AS lod1,
      ''                        AS lod2,
      s.naamnl                  AS name_NL,
      0                         AS z_index,
      'Top50NL'                 AS original_source,
      s.gml_id                  AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top50_3.gebouw AS s;

INSERT INTO visdata.urban_polygon
  SELECT
      'urban_area'              AS lod1,
      ''                        AS lod2,
      ''                        AS name_NL,
      0                         AS z_index,
      'Top50NL'                 AS original_source,
      s.gml_id                  AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top50_3.terrein AS s
  WHERE s.typelandgebruik = 'bebouwd gebied';

--- TOP 100
---------------------------------------------------------------
INSERT INTO visdata.urban_polygon
  SELECT
      'buildings'               AS lod1,
      ''                        AS lod2,
      s.naamnl                  AS name_NL,
      0                         AS z_index,
      'Top100NL'                AS original_source,
      s.gml_id                  AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top100.gebouw AS s;

INSERT INTO visdata.urban_polygon
  SELECT
      'urban_area'              AS lod1,
      ''                        AS lod2,
      ''                        AS name_NL,
      0                         AS z_index,
      'Top100NL'                AS original_source,
      s.gml_id                  AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top100.terrein AS s
  WHERE s.typelandgebruik = 'bebouwd gebied';


--- TOP 250
---------------------------------------------------------------
INSERT INTO visdata.urban_polygon
  SELECT
      'urban_area'              AS lod1,
      ''                        AS lod2,
      s.naamnl                  AS name_NL,
      0                         AS z_index,
      'Top250NL'                AS original_source,
      s.gml_id                  AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top250.plaats AS s;

--- TOP 500
---------------------------------------------------------------
INSERT INTO visdata.urban_polygon
  SELECT
      'urban_area'              AS lod1,
      ''                        AS lod2,
      s.naamnl                  AS name_NL,
      0                         AS z_index,
      'Top500NL'                AS original_source,
      s.gml_id                  AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top500.plaats AS s;


--- TOP 1000
---------------------------------------------------------------
INSERT INTO visdata.urban_polygon
  SELECT
      'urban_area'              AS lod1,
      ''                        AS lod2,
      s.naamnl                  AS name_NL,
      0                         AS z_index,
      'Top1000NL'               AS original_source,
      s.gml_id                  AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top1000.plaats AS s;




-- test
DELETE FROM visdata.urban_polygon WHERE ST_Area(geom)=0;
SELECT distinct(lod1)       AS lod1 FROM visdata.urban_polygon;
SELECT distinct(lod2)       AS lod2 FROM visdata.urban_polygon;
