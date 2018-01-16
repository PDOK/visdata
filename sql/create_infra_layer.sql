DROP TABLE IF EXISTS visdata.infrastructure_line CASCADE;
CREATE TABLE visdata.infrastructure_line (
            lod1 text,
            lod2 text,
            name_NL text,
            z_index integer,
            original_source text,
            original_id text,
            geom geometry(LINESTRING,28992) 
        );

---bgt
INSERT INTO visdata.infrastructure_line
    SELECT
            'railway' AS lod1,
            CASE 
                WHEN 
                    s.bgt_functie= 'trein'
                THEN 'train'
                WHEN 
                    s.bgt_functie= 'metro' 
                    OR s.bgt_functie = 'sneltram' 
                THEN 'metro'
                WHEN 
                    s.bgt_functie= 'tram'
                THEN 'tram'
                ELSE s.bgt_functie
            END AS lod2,
            ''         AS name_NL,
            s.relatievehoogteligging     AS z_index,
            'BGT'          AS original_source,
            s.namespace || s.lokaalid AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,2)))).geom::geometry(LINESTRING,28992) AS geom
    FROM 
        bgt.spoor_2dactueelbestaand AS s;

--top10
INSERT INTO visdata.infrastructure_line
    SELECT
             CASE 
                WHEN 
                    s.typeweg= '(1:autosnelweg)'
                    OR s.typeweg= '(1:lokale weg)'
                    OR s.typeweg = '(1:overig)'
                    OR s.typeweg = '(1:straat)'
                    OR s.typeweg= '(1:hoofdweg)' 
                    OR s.typeweg = '(1:regionale weg)'
                THEN 'roads'
                WHEN 
                    s.typeweg= '(1:veerverbinding)'
                THEN 'ferry'
                WHEN 
                    s.typeweg = '(1:startbaan, landingsbaan)'
                    OR s.typeweg = '(1:rolbaan, platform)'
                THEN 'flight'
                ELSE s.typeweg
            END AS lod1,
            CASE 
                WHEN 
                    s.typeweg= '(1:autosnelweg)'
                THEN 'highway'
                WHEN 
                    s.typeweg= '(1:hoofdweg)' 
                    OR s.typeweg = '(1:regionale weg)'
                THEN 'artiary'
                WHEN 
                    s.typeweg= '(1:lokale weg)'
                    OR s.typeweg = '(1:overig)'
                    OR s.typeweg = '(1:straat)'
                THEN 'local'
                WHEN 
                    s.typeweg= '(1:veerverbinding)'
                THEN 'ferry'
                WHEN 
                    s.typeweg = '(1:startbaan, landingsbaan)'
                    OR s.typeweg = '(1:rolbaan, platform)'
                THEN 'flight'
                ELSE s.typeweg
            END  AS lod2,
            s.naam              AS name_NL,
            s.hoogteniveau     AS z_index,
            'Top10NL'         AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,2)))).geom::geometry(LINESTRING,28992) AS geom
    FROM 
        latest.wegdeel_hartlijn AS s;

---top10
INSERT INTO visdata.infrastructure_line
    SELECT
            'railway' AS lod1,
            CASE 
                WHEN 
                    s.typespoorbaan= 'trein'
                THEN 'train'
                WHEN 
                    s.typespoorbaan= 'metro' 
                    OR s.typespoorbaan = 'sneltram' 
                THEN 'metro'
                WHEN 
                    s.typespoorbaan= 'tram'
                THEN 'tram'
                ELSE s.typespoorbaan
            END AS lod2,
            s.baanvaknaam      AS name_NL,
            s.hoogteniveau     AS z_index,
            'Top10NL'          AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,2)))).geom::geometry(LINESTRING,28992) AS geom
    FROM 
        latest.spoorbaandeel_lijn AS s;

---Top50
INSERT INTO visdata.infrastructure_line
    SELECT
            CASE 
                WHEN 
                    s.typeweg= 'hoofdweg' 
                    OR s.typeweg = 'regionale weg'
                    OR s.typeweg= 'autosnelweg'
                    OR s.typeweg= 'lokale weg'
                    OR s.typeweg = 'overig'
                    OR s.typeweg = 'straat'
                THEN 'roads'
                WHEN 
                    s.typeweg= 'veerverbinding'
                THEN 'ferry'
                WHEN 
                    s.typeweg = 'startbaan, landingsbaan'
                    OR s.typeweg = 'rolbaan, platform'
                THEN 'flight'
                ELSE s.typeweg
                END  AS lod1,
            CASE 
                WHEN 
                    s.typeweg= 'autosnelweg'
                THEN 'highway'
                WHEN 
                    s.typeweg= 'hoofdweg' 
                    OR s.typeweg = 'regionale weg'
                THEN 'artiary'
                WHEN 
                	s.typeweg= 'lokale weg'
                	OR s.typeweg = 'overig'
                	OR s.typeweg = 'straat'
                THEN 'local'
                WHEN 
                    s.typeweg= 'veerverbinding'
                THEN 'ferry'
                WHEN 
                	s.typeweg = 'startbaan, landingsbaan'
                THEN 'flight'
                ELSE s.typeweg
            END  AS lod2,
            ''                  AS name_NL,
            0                   AS z_index,
            'Top50NL'         AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,2)))).geom::geometry(LINESTRING,28992) AS geom
    FROM 
        top50_3.wegdeel AS s
    WHERE 
        s.typeweg != 'parkeerplaats'
        OR s.typeweg != 'parkeerplaats: carpool'
        OR s.typeweg != 'parkeerplaats: P+R'
;

---top50
INSERT INTO visdata.infrastructure_line
    SELECT
            'railway' AS lod1,
            CASE 
                WHEN 
                    s.typespoorbaan= 'trein'
                THEN 'train'
                WHEN 
                    s.typespoorbaan= 'metro' 
                    OR s.typespoorbaan = 'sneltram' 
                THEN 'metro'
                WHEN 
                    s.typespoorbaan= 'tram'
                THEN 'tram'
                ELSE s.typespoorbaan
            END AS lod2,
            ''      AS name_NL,
            s.hoogteniveau     AS z_index,
            'Top50NL'          AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,2)))).geom::geometry(LINESTRING,28992) AS geom
    FROM 
        top50_3.spoorbaandeel AS s;


--top100
INSERT INTO visdata.infrastructure_line
    SELECT
            CASE 
                WHEN 
                    s.typeweg= 'hoofdweg' 
                    OR s.typeweg = 'regionale weg'
                    OR s.typeweg= 'autosnelweg'
                    OR s.typeweg= 'lokale weg'
                    OR s.typeweg = 'overig'
                    OR s.typeweg = 'straat'
                THEN 'roads'
                WHEN 
                    s.typeweg= 'veerverbinding'
                THEN 'ferry'
                WHEN 
                    s.typeweg = 'startbaan, landingsbaan'
                    OR s.typeweg = 'rolbaan, platform'
                THEN 'flight'
                ELSE s.typeweg
                END  AS lod1,
            CASE 
                WHEN 
                    s.typeweg= 'autosnelweg'
                THEN 'highway'
                WHEN 
                    s.typeweg= 'hoofdweg' 
                    OR s.typeweg = 'regionale weg'
                THEN 'artiary'
                WHEN 
                    s.typeweg= 'lokale weg'
                    OR s.typeweg = 'overig'
                    OR s.typeweg = 'straat'
                THEN 'local'
                WHEN 
                    s.typeweg= 'veerverbinding'
                THEN 'ferry'
                WHEN 
                    s.typeweg = 'startbaan, landingsbaan'
                THEN 'flight'
                ELSE s.typeweg
            END  AS lod2,
            ''                  AS name_NL,
            0                   AS z_index,
            'Top100NL'         AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,2)))).geom::geometry(LINESTRING,28992) AS geom
    FROM 
        top100.wegdeel AS s
    WHERE 
        s.typeweg != 'parkeerplaats'
        OR s.typeweg != 'parkeerplaats: carpool'
        OR s.typeweg != 'parkeerplaats: P+R'
    ;

---top100
INSERT INTO visdata.infrastructure_line
    SELECT
            'railway' AS lod1,
            CASE 
                WHEN 
                    s.typespoorbaan= 'trein'
                THEN 'train'
                WHEN 
                    s.typespoorbaan= 'metro' 
                    OR s.typespoorbaan = 'sneltram' 
                THEN 'metro'
                WHEN 
                    s.typespoorbaan= 'tram'
                THEN 'tram'
                ELSE s.typespoorbaan
            END AS lod2,
            ''      AS name_NL,
            s.hoogteniveau     AS z_index,
            'Top100NL'          AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,2)))).geom::geometry(LINESTRING,28992) AS geom
    FROM 
        top100.spoorbaandeel AS s;

--top250
INSERT INTO visdata.infrastructure_line
    SELECT
            CASE 
                WHEN 
                    s.typeweg= 'hoofdweg' 
                    OR s.typeweg = 'regionale weg'
                    OR s.typeweg= 'autosnelweg'
                    OR s.typeweg= 'lokale weg'
                    OR s.typeweg = 'overig'
                    OR s.typeweg = 'straat'
                THEN 'roads'
                WHEN 
                    s.typeweg= 'veerverbinding'
                THEN 'ferry'
                WHEN 
                    s.typeweg = 'startbaan, landingsbaan'
                    OR s.typeweg = 'rolbaan, platform'
                THEN 'flight'
                ELSE s.typeweg
                END  AS lod1,
            CASE 
                WHEN 
                    s.typeweg= 'autosnelweg'
                THEN 'highway'
                WHEN 
                    s.typeweg= 'hoofdweg' 
                    OR s.typeweg = 'regionale weg'
                THEN 'artiary'
                WHEN 
                    s.typeweg= 'lokale weg'
                    OR s.typeweg = 'overig'
                    OR s.typeweg = 'straat'
                THEN 'local'
                WHEN 
                    s.typeweg= 'veerverbinding'
                THEN 'ferry'
                WHEN 
                    s.typeweg = 'startbaan, landingsbaan'
                THEN 'flight'
                ELSE s.typeweg
            END  AS lod2,
            ''                  AS name_NL,
            0                   AS z_index,
            'Top250NL'         AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,2)))).geom::geometry(LINESTRING,28992) AS geom
    FROM 
        top250.wegdeel AS s
    WHERE 
        s.typeweg != 'parkeerplaats'
        OR s.typeweg != 'parkeerplaats: carpool'
        OR s.typeweg != 'parkeerplaats: P+R'
    ;

---top250
INSERT INTO visdata.infrastructure_line
    SELECT
            'railway' AS lod1,
            CASE 
                WHEN 
                    s.typespoorbaan= 'trein'
                THEN 'train'
                WHEN 
                    s.typespoorbaan= 'metro' 
                    OR s.typespoorbaan = 'sneltram' 
                THEN 'metro'
                WHEN 
                    s.typespoorbaan= 'tram'
                THEN 'tram'
                ELSE s.typespoorbaan
            END AS lod2,
            ''      AS name_NL,
            0     AS z_index,
            'Top250NL'          AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,2)))).geom::geometry(LINESTRING,28992) AS geom
    FROM 
        top250.spoorbaandeel AS s;

--top500
INSERT INTO visdata.infrastructure_line
    SELECT
            CASE 
                WHEN 
                    s.typeweg= 'hoofdweg' 
                    OR s.typeweg = 'regionale weg'
                    OR s.typeweg= 'autosnelweg'
                    OR s.typeweg= 'lokale weg'
                    OR s.typeweg = 'overig'
                    OR s.typeweg = 'straat'
                THEN 'roads'
                WHEN 
                    s.typeweg= 'veerverbinding'
                THEN 'ferry'
                WHEN 
                    s.typeweg = 'startbaan, landingsbaan'
                    OR s.typeweg = 'rolbaan, platform'
                THEN 'flight'
                ELSE s.typeweg
                END  AS lod1,
            CASE 
                WHEN 
                    s.typeweg= 'autosnelweg'
                THEN 'highway'
                WHEN 
                    s.typeweg= 'hoofdweg' 
                    OR s.typeweg = 'regionale weg'
                THEN 'artiary'
                WHEN 
                    s.typeweg= 'lokale weg'
                    OR s.typeweg = 'overig'
                    OR s.typeweg = 'straat'
                THEN 'local'
                WHEN 
                    s.typeweg= 'veerverbinding'
                THEN 'ferry'
                WHEN 
                    s.typeweg = 'startbaan, landingsbaan'
                THEN 'flight'
                ELSE s.typeweg
            END  AS lod2,
            ''                  AS name_NL,
            0                   AS z_index,
            'Top500NL'         AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,2)))).geom::geometry(LINESTRING,28992) AS geom
    FROM 
        top500.wegdeel AS s
    WHERE 
        s.typeweg != 'parkeerplaats'
        OR s.typeweg != 'parkeerplaats: carpool'
        OR s.typeweg != 'parkeerplaats: P+R'
    ;

---top500
INSERT INTO visdata.infrastructure_line
    SELECT
            'railway' AS lod1,
            CASE 
                WHEN 
                    s.typespoorbaan= 'trein'
                THEN 'train'
                WHEN 
                    s.typespoorbaan= 'metro' 
                    OR s.typespoorbaan = 'sneltram' 
                THEN 'metro'
                WHEN 
                    s.typespoorbaan= 'tram'
                THEN 'tram'
                ELSE s.typespoorbaan
            END AS lod2,
            ''      AS name_NL,
            0     AS z_index,
            'Top500NL'          AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,2)))).geom::geometry(LINESTRING,28992) AS geom
    FROM 
        top500.spoorbaandeel AS s;


--top1000
INSERT INTO visdata.infrastructure_line
    SELECT
            CASE 
                WHEN 
                    s.typeweg= 'hoofdweg' 
                    OR s.typeweg = 'regionale weg'
                    OR s.typeweg= 'autosnelweg'
                    OR s.typeweg= 'lokale weg'
                    OR s.typeweg = 'overig'
                    OR s.typeweg = 'straat'
                THEN 'roads'
                WHEN 
                    s.typeweg= 'veerverbinding'
                THEN 'ferry'
                WHEN 
                    s.typeweg = 'startbaan, landingsbaan'
                    OR s.typeweg = 'rolbaan, platform'
                THEN 'flight'
                ELSE s.typeweg
                END  AS lod1,
            CASE 
                WHEN 
                    s.typeweg= 'autosnelweg'
                THEN 'highway'
                WHEN 
                    s.typeweg= 'hoofdweg' 
                    OR s.typeweg = 'regionale weg'
                THEN 'artiary'
                WHEN 
                    s.typeweg= 'lokale weg'
                    OR s.typeweg = 'overig'
                    OR s.typeweg = 'straat'
                THEN 'local'
                WHEN 
                    s.typeweg= 'veerverbinding'
                THEN 'ferry'
                WHEN 
                    s.typeweg = 'startbaan, landingsbaan'
                THEN 'flight'
                ELSE s.typeweg
            END  AS lod2,
            ''                  AS name_NL,
            0                   AS z_index,
            'Top1000NL'         AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,2)))).geom::geometry(LINESTRING,28992) AS geom
    FROM 
        top1000.wegdeel AS s
    WHERE 
        s.typeweg != 'parkeerplaats'
        OR s.typeweg != 'parkeerplaats: carpool'
        OR s.typeweg != 'parkeerplaats: P+R'
    ;

---top1000
INSERT INTO visdata.infrastructure_line
    SELECT
            'railway' AS lod1,
            CASE 
                WHEN 
                    s.typespoorbaan= 'trein'
                THEN 'train'
                WHEN 
                    s.typespoorbaan= 'metro' 
                    OR s.typespoorbaan = 'sneltram' 
                THEN 'metro'
                WHEN 
                    s.typespoorbaan= 'tram'
                THEN 'tram'
                ELSE s.typespoorbaan
            END AS lod2,
            ''      AS name_NL,
            0     AS z_index,
            'Top1000NL'          AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,2)))).geom::geometry(LINESTRING,28992) AS geom
    FROM 
        top1000.spoorbaandeel AS s;
--test
SELECT distinct (lod1) FROM visdata.infrastructure_line;
SELECT distinct (lod2) FROM visdata.infrastructure_line;

SELECT count(*) FROM visdata.infrastructure_line WHERE ST_Length(geom)=0;