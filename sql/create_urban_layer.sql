-- CREATE TABLE urban 

DROP TABLE IF EXISTS visdata.urban_polygon CASCADE;
CREATE TABLE visdata.urban_polygon (
      lod1 text,
      lod2 text,
      name text,
      z_index integer,
      original_source text,
      original_id text,
      geom geometry(POLYGON,28992) 
    );

	
-- BGT panden to urban
---------------------------------------------------

INSERT INTO visdata.urban_polygon 
  SELECT
      'buildings'               	AS lod1,
      'main_building'           	AS lod2,
      ''                        	AS name,
      s."relatieveHoogteligging"  	AS z_index,
      'BGT'                     	AS original_source,
      'NL.IMGeo.' || s."lokaalID" 	AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    bgtv3."Pand" AS s;

INSERT INTO visdata.urban_polygon 
  SELECT
      'buildings'               	AS lod1,
      'other_buildings'         	AS lod2,
      ''                        	AS name,
      s."relatieveHoogteligging"  	AS z_index,
      'BGT'                     	AS original_source,
      'NL.IMGeo.' || s."lokaalID"	AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    bgtv3."OverigBouwwerk" AS s;

INSERT INTO visdata.urban_polygon 
  SELECT
      'buildings'               	AS lod1,
      'other_buildings'         	AS lod2,
      ''                        	AS name,
      s."relatieveHoogteligging"  	AS z_index,
      'BGT'                     	AS original_source,
      'NL.IMGeo.' || s."lokaalID"	AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    bgtv3."Kunstwerkdeel" AS s;

INSERT INTO visdata.urban_polygon 
  SELECT
      'buildings'               	AS lod1,
      'other_buildings'         	AS lod2,
      ''                        	AS name,
      s."relatieveHoogteligging"  	AS z_index,
      'BGT'                     	AS original_source,
      'NL.IMGeo.' || s."lokaalID"	AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    bgtv3."GebouwInstallatie" AS s;

INSERT INTO visdata.urban_polygon 
  SELECT
      'buildings'               	AS lod1,
      'walls'              			AS lod2,
      ''                        	AS name,
      s."relatieveHoogteligging"  	AS z_index,
      'BGT'                     	AS original_source,
      'NL.IMGeo.' || s."lokaalID"	AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    bgtv3."OverigeScheiding" AS s;

INSERT INTO visdata.urban_polygon 
  SELECT
      'buildings'               	AS lod1,
      'walls'              			AS lod2,
      ''                        	AS name,
      s."relatieveHoogteligging"  	AS z_index,
      'BGT'                     	AS original_source,
      'NL.IMGeo.' || s."lokaalID"	AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    bgtv3."Scheiding" AS s;


-- TOP10NL
-------------------------------------------------------------

INSERT INTO visdata.urban_polygon
  SELECT
      'buildings'               	AS lod1,
      'main_building'           	AS lod2,
      s.naam                    	AS name,
      s.hoogteniveau::integer      	AS z_index,
      'Top10NL'                 	AS original_source,
      'NL.TOP10NL.'|| s.lokaalid	AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top10nlv2.gebouw AS s;

-- INSERT INTO visdata.urban_polygon
--   SELECT
--       'urban_area'              AS lod1,
--       s.naamnl                  AS name,
--       0                         AS z_index,
--       'Top10NL'                 AS original_source,
--       s.lokaalid                  AS original_id,
--       (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
--   FROM 
--     latest.plaats_vlak AS s;

-- INSERT INTO visdata.urban_polygon
--   SELECT
--       'urban_area'              AS lod1,
--       s.naam                  AS name,
--       0                         AS z_index,
--       'Top10NL'                 AS original_source,
--       s.lokaalid                  AS original_id,
--       (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
--   FROM 
--     latest.terrein_vlak AS s
--   WHERE
--     typelandgebruik = 'bebouwd gebied';


-- TOP50NL
----------------------------------------------------------

INSERT INTO visdata.urban_polygon
  SELECT
      'buildings'               	AS lod1,
      ''                        	AS lod2,
      s.naamnl                  	AS name,
      0                         	AS z_index,
      'Top50NL'                 	AS original_source,
      namespace || '.' || lokaalid 	AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top50nl.gebouw_vlak AS s;

INSERT INTO visdata.urban_polygon
  SELECT
      'urban_area'              	AS lod1,
      ''                        	AS lod2,
      ''                        	AS name,
      0                         	AS z_index,
      'Top50NL'                 	AS original_source,
      namespace || '.' || lokaalid 	AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top50nl.terrein_vlak AS s
  WHERE s.typelandgebruik = 'bebouwd gebied';

  
-- TOP100NL
---------------------------------------------------------------
INSERT INTO visdata.urban_polygon
  SELECT
      'buildings'               	AS lod1,
      ''                        	AS lod2,
      s.naamnl                  	AS name,
      0                         	AS z_index,
      'Top100NL'                	AS original_source,
      namespace || '.' || lokaalid 	AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top100nl.gebouw_vlak AS s;

INSERT INTO visdata.urban_polygon
  SELECT
      'urban_area'              	AS lod1,
      ''                        	AS lod2,
      ''                        	AS name,
      0                         	AS z_index,
      'Top100NL'                	AS original_source,
      namespace || '.' || lokaalid 	AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top100nl.terrein_vlak AS s
  WHERE s.typelandgebruik = 'bebouwd gebied';


-- TOP250NL
---------------------------------------------------------------
INSERT INTO visdata.urban_polygon
  SELECT
      'urban_area'              	AS lod1,
      ''                        	AS lod2,
      s.naamnl                  	AS name,
      0                         	AS z_index,
      'Top250NL'                	AS original_source,
      namespace || '.' || lokaalid 	AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top250nl.plaats_vlak AS s;

	
-- TOP500NL
---------------------------------------------------------------
INSERT INTO visdata.urban_polygon
  SELECT
      'urban_area'              	AS lod1,
      ''                        	AS lod2,
      s.naamnl                  	AS name,
      0                         	AS z_index,
      'Top500NL'                	AS original_source,
      namespace || '.' || lokaalid 	AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top500nl.plaats_vlak AS s;


-- TOP1000NL
---------------------------------------------------------------
INSERT INTO visdata.urban_polygon
  SELECT
      'urban_area'              	AS lod1,
      ''                        	AS lod2,
      s.naamnl                  	AS name,
      0                         	AS z_index,
      'Top1000NL'               	AS original_source,
      namespace || '.' || lokaalid 	AS original_id,
      (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
  FROM 
    top1000nl.plaats_vlak AS s;


DELETE FROM visdata.water_polygon WHERE ST_Area(geom)=0;

-- Controle
SELECT
	original_source,
	lod1,
	lod2,
	COUNT(*) AS aantal 
FROM
	visdata.urban_polygon 
GROUP BY original_source, lod1, lod2 
ORDER BY original_source, lod1, lod2;
