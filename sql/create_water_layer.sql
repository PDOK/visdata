-- CREATE TABLE water 

DROP TABLE IF EXISTS visdata.water_polygon CASCADE;
CREATE TABLE visdata.water_polygon (
            lod1 text,
            name_NL text,
            z_index integer,
            original_source text,
            original_id text,
            geom geometry(POLYGON,28992) 
        );

-- BGT waterdeel_vlak to water 
INSERT INTO visdata.water_polygon 
	SELECT
            CASE 
                WHEN s.bgt_type = 'watervlakte' THEN 'water_surface'
                WHEN s.bgt_type = 'greppel, droge sloot' OR s.bgt_type = 'waterloop' THEN 'water_course' 
            END AS lod1,
            ''				 	AS name_NL,
            s.relatievehoogteligging	AS z_index,
            'BGT' 				AS original_source,
            s.namespace || s.lokaalid 			AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
    	bgt.waterdeel_2dactueelbestaand AS s;

-- TOP10NL waterdeel_vlak to water 
INSERT INTO visdata.water_polygon
	SELECT
            CASE 
                WHEN 
                    s.typewater =  'meer, plas, ven, vijver' OR
                    s.typewater = 'meer, plas' OR 
                    s.typewater = 'droogvallend (LAT)' OR 
                    s.typewater = 'zee' OR 
                    s.typewater = 'overig' OR 
                    s.typewater = 'droogvallend' 
                THEN 'water_surface'
                WHEN 
                    s.typewater = 'waterloop' OR
                    s.typewater = 'greppel, droge sloot' 
                THEN 'water_course'
                ELSE s.typewater
            END  AS lod1,
            s.naamofficieel 	AS name_NL,
            s.hoogteniveau 		AS z_index,
            'Top10NL' 			AS original_source,
            s.gml_id 			AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
    	latest.waterdeel_vlak AS s;

-- TOP50NL waterdeel_vlak to water 
INSERT INTO visdata.water_polygon
    SELECT
              CASE 
                 WHEN 
                    s.typewater = 'meer, plas, ven, vijver' OR
                    s.typewater = 'meer, plas' OR 
                    s.typewater = 'droogvallend (LAT)' OR 
                    s.typewater = 'zee' OR 
                    s.typewater = 'overig' OR 
                    s.typewater = 'droogvallend' 
                THEN 'water_surface'
                WHEN 
                    s.typewater = 'waterloop' OR
                    s.typewater = 'greppel, droge sloot' 
                THEN 'water_course'
                ELSE s.typewater
            END  AS lod1,
            ''                  AS name_NL,
            s.hoogteniveau      AS z_index,
            'Top50NL'           AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
        top50_3.waterdeel AS s;


-- TOP100NL waterdeel_vlak to water 
INSERT INTO visdata.water_polygon
    SELECT
              CASE 
                 WHEN 
                    s.typewater =  'meer, plas, ven, vijver' OR
                    s.typewater = 'meer, plas' OR 
                    s.typewater = 'droogvallend (LAT)' OR 
                    s.typewater = 'zee' OR 
                    s.typewater = 'overig' OR 
                    s.typewater = 'droogvallend' 
                THEN 'water_surface'
                WHEN 
                    s.typewater = 'waterloop' OR
                    s.typewater = 'greppel, droge sloot' 
                THEN 'water_course'
                ELSE s.typewater
            END  AS lod1,
            ''                  AS name_NL,
            0                   AS z_index,
            'Top100NL'          AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
        top100.waterdeel AS s;

-- TOP250NL waterdeel_vlak to water 
INSERT INTO visdata.water_polygon
    SELECT
              CASE 
                 WHEN 
                    s.typewater =  'meer, plas, ven, vijver' OR
                    s.typewater = 'meer, plas' OR 
                    s.typewater = 'droogvallend (LAT)' OR 
                    s.typewater = 'zee' OR 
                    s.typewater = 'overig' OR 
                    s.typewater = 'droogvallend' 
                THEN 'water_surface'
                WHEN 
                    s.typewater = 'waterloop' OR
                    s.typewater = 'greppel, droge sloot' 
                THEN 'water_course'
                ELSE s.typewater
            END  AS lod1,
            s.naamnl            AS name_NL,
            0                   AS z_index,
            'Top250NL'          AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
        top250.waterdeel AS s;

-- TOP500NL waterdeel_vlak to water 
INSERT INTO visdata.water_polygon
    SELECT
               CASE 
                 WHEN 
                    s.typewater =  'meer, plas, ven, vijver' OR
                    s.typewater = 'meer, plas' OR 
                    s.typewater = 'droogvallend (LAT)' OR 
                    s.typewater = 'zee' OR 
                    s.typewater = 'overig' OR 
                    s.typewater = 'droogvallend' 
                THEN 'water_surface'
                WHEN 
                    s.typewater = 'waterloop' OR
                    s.typewater = 'greppel, droge sloot' 
                THEN 'water_course'
                ELSE s.typewater
            END  AS lod1,
            s.naamnl            AS name_NL,
            0                   AS z_index,
            'Top500NL'          AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
        top500.waterdeel AS s;

-- TOP1000NL waterdeel_vlak to water 
INSERT INTO visdata.water_polygon
    SELECT
               CASE 
                 WHEN 
                    s.typewater =  'meer, plas, ven, vijver' OR
                    s.typewater = 'meer, plas' OR 
                    s.typewater = 'droogvallend (LAT)' OR 
                    s.typewater = 'zee' OR 
                    s.typewater = 'overig' OR 
                    s.typewater = 'droogvallend' 
                THEN 'water_surface'
                WHEN 
                    s.typewater = 'waterloop' OR
                    s.typewater = 'greppel, droge sloot' 
                THEN 'water_course'
                ELSE s.typewater
            END  AS lod1,
            s.naamnl            AS name_NL,
            0                   AS z_index,
            'Top1000NL'         AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
        top1000.waterdeel AS s;

DELETE FROM visdata.water_polygon WHERE ST_Area(geom)=0;

-- test


SELECT distinct(lod1) AS lod1 FROM visdata.water_polygon;

