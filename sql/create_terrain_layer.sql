DROP TABLE IF EXISTS visdata.terrain CASCADE;
CREATE TABLE visdata.terrain (
            lod1 text,
            lod2 text,
            name text,
            z_index integer,
            original_source text,
            original_id text,
            geom geometry(POLYGON,28992) 
        );

-- BGT terrein_vlak  
INSERT INTO visdata.terrain 
      SELECT
            'natural'                     AS lod1,
            CASE 
                WHEN 
                    s.bgt_fysiekvoorkomen = 'gemengd bos' OR
                    s.bgt_fysiekvoorkomen = 'loofbos' OR
                    s.bgt_fysiekvoorkomen = 'houtwal' OR
                    s.bgt_fysiekvoorkomen = 'naaldbos' 
                THEN 'high_vegetation'
                WHEN 
                    s.bgt_fysiekvoorkomen = 'grasland overig' OR
                    s.bgt_fysiekvoorkomen = 'groenvoorziening' OR
                    s.bgt_fysiekvoorkomen = 'struiken' OR
                    s.bgt_fysiekvoorkomen = 'moeras' OR
                    s.bgt_fysiekvoorkomen = 'rietland' OR
                    s.bgt_fysiekvoorkomen = 'transitie' 
                THEN 'low_vegetation'
                WHEN
                    s.bgt_fysiekvoorkomen = 'boomteelt' OR
                    s.bgt_fysiekvoorkomen = 'bouwland' OR
                    s.bgt_fysiekvoorkomen = 'grasland agrarisch' OR
                    s.bgt_fysiekvoorkomen = 'fruitteelt'
                THEN 'agriculture'
                ELSE s.bgt_fysiekvoorkomen 
            END  AS lod2,
            ''                            AS name,
            s.relatievehoogteligging      AS z_index,
            'BGT'                         AS original_source,
            s.namespace || s.lokaalid                     AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
      bgt.begroeidterreindeel_2dactueelbestaand AS s;

INSERT INTO visdata.terrain 
      SELECT
            'human-made'                  AS lod1,
            CASE
                WHEN 
                    s.bgt_fysiekvoorkomen = 'gesloten verharding' OR
                    s.bgt_fysiekvoorkomen = 'half verhard' OR
                    s.bgt_fysiekvoorkomen = 'transitie' OR
                    s.bgt_fysiekvoorkomen = 'open verharding'
                THEN 'closed'
                WHEN
                    s.bgt_fysiekvoorkomen = 'onverhard' OR
                    s.bgt_fysiekvoorkomen = 'zand' OR
                    s.bgt_fysiekvoorkomen = 'erf'
                THEN 'open'
                ELSE s.bgt_fysiekvoorkomen
            END AS lod2,
            ''                            AS name,
            s.relatievehoogteligging      AS z_index,
            'BGT'                         AS original_source,
            s.namespace || s.lokaalid               AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
      bgt.onbegroeidterreindeel_2dactueelbestaand AS s;

INSERT INTO visdata.terrain 
      SELECT
            'natural'                     AS lod1,
            'low_vegetation'              AS lod2,
            ''                            AS name,
            s.relatievehoogteligging      AS z_index,
            'BGT'                         AS original_source,
            s.namespace || s.lokaalid               AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
      bgt.ondersteunendwaterdeel_2dactueelbestaand AS s;

INSERT INTO visdata.terrain 
      SELECT
            'human-made'                    AS lod1,
            CASE
                WHEN 
                    s.bgt_fysiekvoorkomen = 'gesloten verharding' OR
                    s.bgt_fysiekvoorkomen = 'half verhard' OR
                    s.bgt_fysiekvoorkomen = 'transitie' OR
                    s.bgt_fysiekvoorkomen = 'open verharding'
                THEN 'closed'
                WHEN
                    s.bgt_fysiekvoorkomen = 'onverhard' OR
                    s.bgt_fysiekvoorkomen = 'zand'
                THEN 'open'
                WHEN 
                    s.bgt_fysiekvoorkomen = 'groenvoorziening'
                THEN 'low_vegetation'
                ELSE s.bgt_fysiekvoorkomen
            END AS lod2,
            ''                            AS name,
            s.relatievehoogteligging      AS z_index,
            'BGT'                         AS original_source,
            s.namespace || s.lokaalid                     AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
      bgt.ondersteunendwegdeel_2dactueelbestaand AS s;

INSERT INTO visdata.terrain 
      SELECT
            'human-made'                  AS lod1,
            'closed'                      AS lod2,
            ''                            AS name,
            s.relatievehoogteligging      AS z_index,
            'BGT'                         AS original_source,
            s.namespace || s.lokaalid               AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
      bgt.overbruggingsdeel_2dactueelbestaand AS s;


INSERT INTO visdata.terrain 
      SELECT
            'human-made'                  AS lod1,
            CASE
                WHEN 
                    s.bgt_fysiekvoorkomen = 'gesloten verharding' OR
                    s.bgt_fysiekvoorkomen = 'half verhard' OR
                    s.bgt_fysiekvoorkomen = 'transitie' OR
                    s.bgt_fysiekvoorkomen = 'open verharding'
                THEN 'closed'
                WHEN
                    s.bgt_fysiekvoorkomen = 'onverhard' OR
                    s.bgt_fysiekvoorkomen = 'zand'
                THEN 'open'
                ELSE s.bgt_fysiekvoorkomen
            END AS lod2,
            ''                            AS name,
            s.relatievehoogteligging      AS z_index,
            'BGT'                         AS original_source,
            s.namespace || s.lokaalid               AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
      bgt.wegdeel_2dactueelbestaand AS s;

-- TOP10NL terrein_vlak 
INSERT INTO visdata.terrain
      SELECT
             CASE 
                WHEN 
                    s.typelandgebruik= 'aanlegsteiger' OR 
                    s.typelandgebruik= 'overig' OR
                    s.typelandgebruik= 'spoorbaanlichaam' OR
                    s.typelandgebruik= 'bebouwd gebied' OR
                    s.typelandgebruik= 'braakliggend' OR
                    s.typelandgebruik= 'kassengebied'
                THEN 'human-made'
                WHEN  
                    s.typelandgebruik= 'bos: gemengd bos' OR 
                    s.typelandgebruik= 'dodenakker met bos'OR 
                    s.typelandgebruik= 'zand'OR 
                    s.typelandgebruik= 'grasland'OR 
                    s.typelandgebruik= 'bos: griend'OR 
                    s.typelandgebruik= 'bos: griend'OR 
                    s.typelandgebruik= 'heide'OR 
                    s.typelandgebruik= 'populieren'OR 
                    s.typelandgebruik= 'bos: loofbos'OR 
                    s.typelandgebruik= 'duin'OR 
                    s.typelandgebruik= 'akkerland'OR 
                    s.typelandgebruik= 'basaltblokken, steenglooiing'OR 
                    s.typelandgebruik= 'dodenakker'OR 
                    s.typelandgebruik= 'fruitkwekerij' OR 
                    s.typelandgebruik= 'boomkwekerij' OR 
                    s.typelandgebruik= 'boomgaard' OR 
                    s.typelandgebruik= 'bos: naaldbos'OR
                    s.typelandgebruik= 'bos'
                THEN 'natural'
                ELSE s.typelandgebruik
            END AS lod1,
            CASE 
                WHEN 
                    s.typelandgebruik= 'aanlegsteiger' OR 
                    s.typelandgebruik= 'overig' OR
                    s.typelandgebruik= 'spoorbaanlichaam' OR
                    s.typelandgebruik= 'bebouwd gebied'
                THEN 'closed'
                WHEN
                    s.typelandgebruik= 'zand'OR
                    s.typelandgebruik= 'duin'OR
                    s.typelandgebruik= 'basaltblokken, steenglooiing' OR
                    s.typelandgebruik= 'braakliggend'
                THEN 'open'
                WHEN  
                    s.typelandgebruik= 'bos: gemengd bos' OR 
                    s.typelandgebruik= 'dodenakker met bos'OR
                    s.typelandgebruik= 'bos: griend'OR 
                    s.typelandgebruik= 'populieren'OR 
                    s.typelandgebruik= 'bos: loofbos'OR 
                    s.typelandgebruik= 'bos: naaldbos' OR
                    s.typelandgebruik= 'bos'
                THEN 'high_vegetation'
                WHEN
                    s.typelandgebruik= 'grasland'OR 
                    s.typelandgebruik= 'heide'
                THEN 'low_vegetation'
                WHEN
                    s.typelandgebruik= 'akkerland'OR 
                    s.typelandgebruik= 'dodenakker'OR 
                    s.typelandgebruik= 'fruitkwekerij' OR 
                    s.typelandgebruik= 'boomkwekerij' OR 
                    s.typelandgebruik= 'boomgaard' OR
                    s.typelandgebruik= 'kassengebied'
                THEN 'agriculture'
                ELSE s.typelandgebruik
            END AS lod2,
            s.naam                  AS name,
            s.hoogteniveau          AS z_index,
            'Top10NL'               AS original_source,
            s.gml_id                AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
      latest.terrein_vlak AS s
    WHERE 
        s.typelandgebruik != 'bebouwd gebied';


-- TOP50NL terrein_vlak  
INSERT INTO visdata.terrain
    SELECT
            CASE 
                WHEN 
                    s.typelandgebruik= 'aanlegsteiger' OR 
                    s.typelandgebruik= 'overig' OR
                    s.typelandgebruik= 'spoorbaanlichaam' OR
                    s.typelandgebruik= 'bebouwd gebied' OR
                    s.typelandgebruik= 'braakliggend' OR
                    s.typelandgebruik= 'kassengebied'
                THEN 'human-made'
                WHEN  
                    s.typelandgebruik= 'bos: gemengd bos' OR 
                    s.typelandgebruik= 'dodenakker met bos'OR 
                    s.typelandgebruik= 'zand'OR 
                    s.typelandgebruik= 'grasland'OR 
                    s.typelandgebruik= 'bos: griend'OR 
                    s.typelandgebruik= 'bos: griend'OR 
                    s.typelandgebruik= 'heide'OR 
                    s.typelandgebruik= 'populieren'OR 
                    s.typelandgebruik= 'bos: loofbos'OR 
                    s.typelandgebruik= 'duin'OR 
                    s.typelandgebruik= 'akkerland'OR 
                    s.typelandgebruik= 'basaltblokken, steenglooiing'OR 
                    s.typelandgebruik= 'dodenakker'OR 
                    s.typelandgebruik= 'fruitkwekerij' OR 
                    s.typelandgebruik= 'boomkwekerij' OR 
                    s.typelandgebruik= 'boomgaard' OR 
                    s.typelandgebruik= 'bos: naaldbos'OR
                    s.typelandgebruik= 'bos'
                THEN 'natural'
                ELSE s.typelandgebruik
            END AS lod1,
            CASE 
                WHEN 
                    s.typelandgebruik= 'aanlegsteiger' OR 
                    s.typelandgebruik= 'overig' OR
                    s.typelandgebruik= 'spoorbaanlichaam' OR
                    s.typelandgebruik= 'bebouwd gebied'
                THEN 'closed'
                WHEN
                    s.typelandgebruik= 'zand'OR
                    s.typelandgebruik= 'duin'OR
                    s.typelandgebruik= 'basaltblokken, steenglooiing' OR
                    s.typelandgebruik= 'braakliggend'
                THEN 'open'
                WHEN  
                    s.typelandgebruik= 'bos: gemengd bos' OR 
                    s.typelandgebruik= 'dodenakker met bos'OR
                    s.typelandgebruik= 'bos: griend'OR 
                    s.typelandgebruik= 'populieren'OR 
                    s.typelandgebruik= 'bos: loofbos'OR 
                    s.typelandgebruik= 'bos: naaldbos' OR
                    s.typelandgebruik= 'bos'
                THEN 'high_vegetation'
                WHEN
                    s.typelandgebruik= 'grasland'OR 
                    s.typelandgebruik= 'heide'
                THEN 'low_vegetation'
                WHEN
                    s.typelandgebruik= 'akkerland'OR 
                    s.typelandgebruik= 'dodenakker'OR 
                    s.typelandgebruik= 'fruitkwekerij' OR 
                    s.typelandgebruik= 'boomkwekerij' OR 
                    s.typelandgebruik= 'boomgaard' OR
                    s.typelandgebruik= 'kassengebied'
                THEN 'agriculture'
                ELSE s.typelandgebruik
            END AS lod2,
            ''                  AS name,
            0                   AS z_index,
            'Top50NL'           AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
        top50_3.terrein AS s
    WHERE 
      s.typelandgebruik != 'bebouwd gebied';


INSERT INTO visdata.terrain
    SELECT
            CASE 
                WHEN 
                    s.typeweg= 'parkeerplaats'
                    OR s.typeweg= 'parkeerplaats: carpool'
                    OR s.typeweg= 'parkeerplaats: P+R'
                    OR s.typeweg= 'rolbaan, platform'
                    OR s.typeweg= 'startbaan, landingsbaan'
                THEN 'human-made'
            END  AS lod1,
            'closed'            AS lod2,
            ''                  AS name,
            0                   AS z_index,
            'Top50NL'           AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
        top50_3.wegdeel AS s
    WHERE 
        s.typeweg = 'parkeerplaats'
        OR s.typeweg= 'parkeerplaats: carpool'
        OR s.typeweg= 'parkeerplaats: P+R'
        OR s.typeweg= 'rolbaan, platform'
        OR s.typeweg= 'startbaan, landingsbaan'
    ;

-- TOP100NL terrein_vlak  
INSERT INTO visdata.terrain
    SELECT
         CASE 
                WHEN 
                    s.typelandgebruik= 'aanlegsteiger' OR 
                    s.typelandgebruik= 'overig' OR
                    s.typelandgebruik= 'spoorbaanlichaam' OR
                    s.typelandgebruik= 'bebouwd gebied' OR
                    s.typelandgebruik= 'braakliggend' OR
                    s.typelandgebruik= 'kassengebied'
                THEN 'human-made'
                WHEN  
                    s.typelandgebruik= 'bos: gemengd bos' OR 
                    s.typelandgebruik= 'dodenakker met bos'OR 
                    s.typelandgebruik= 'zand'OR 
                    s.typelandgebruik= 'grasland'OR 
                    s.typelandgebruik= 'bos: griend'OR 
                    s.typelandgebruik= 'bos: griend'OR 
                    s.typelandgebruik= 'heide'OR 
                    s.typelandgebruik= 'populieren'OR 
                    s.typelandgebruik= 'bos: loofbos'OR 
                    s.typelandgebruik= 'duin'OR 
                    s.typelandgebruik= 'akkerland'OR 
                    s.typelandgebruik= 'basaltblokken, steenglooiing'OR 
                    s.typelandgebruik= 'dodenakker'OR 
                    s.typelandgebruik= 'fruitkwekerij' OR 
                    s.typelandgebruik= 'boomkwekerij' OR 
                    s.typelandgebruik= 'boomgaard' OR 
                    s.typelandgebruik= 'bos: naaldbos'OR
                    s.typelandgebruik= 'bos'
                THEN 'natural'
                ELSE s.typelandgebruik
            END AS lod1,
            CASE 
                WHEN 
                    s.typelandgebruik= 'aanlegsteiger' OR 
                    s.typelandgebruik= 'overig' OR
                    s.typelandgebruik= 'spoorbaanlichaam' OR
                    s.typelandgebruik= 'bebouwd gebied'
                THEN 'closed'
                WHEN
                    s.typelandgebruik= 'zand'OR
                    s.typelandgebruik= 'duin'OR
                    s.typelandgebruik= 'basaltblokken, steenglooiing' OR
                    s.typelandgebruik= 'braakliggend'
                THEN 'open'
                WHEN  
                    s.typelandgebruik= 'bos: gemengd bos' OR 
                    s.typelandgebruik= 'dodenakker met bos'OR
                    s.typelandgebruik= 'bos: griend'OR 
                    s.typelandgebruik= 'populieren'OR 
                    s.typelandgebruik= 'bos: loofbos'OR 
                    s.typelandgebruik= 'bos: naaldbos' OR
                    s.typelandgebruik= 'bos'
                THEN 'high_vegetation'
                WHEN
                    s.typelandgebruik= 'grasland'OR 
                    s.typelandgebruik= 'heide'
                THEN 'low_vegetation'
                WHEN
                    s.typelandgebruik= 'akkerland'OR 
                    s.typelandgebruik= 'dodenakker'OR 
                    s.typelandgebruik= 'fruitkwekerij' OR 
                    s.typelandgebruik= 'boomkwekerij' OR 
                    s.typelandgebruik= 'boomgaard' OR
                    s.typelandgebruik= 'kassengebied'
                THEN 'agriculture'
                ELSE s.typelandgebruik
            END AS lod2,
            ''                  AS name,
            0                   AS z_index,
            'Top100NL'         AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom 
    FROM 
        top100.terrein AS s;

-- TOP250NL terrein_vlak  
INSERT INTO visdata.terrain
    SELECT
           CASE 
                WHEN 
                    s.typelandgebruik= 'aanlegsteiger' OR 
                    s.typelandgebruik= 'overig' OR
                    s.typelandgebruik= 'spoorbaanlichaam' OR
                    s.typelandgebruik= 'bebouwd gebied' OR
                    s.typelandgebruik= 'braakliggend' OR
                    s.typelandgebruik= 'kassengebied'
                THEN 'human-made'
                WHEN  
                    s.typelandgebruik= 'bos: gemengd bos' OR 
                    s.typelandgebruik= 'dodenakker met bos'OR 
                    s.typelandgebruik= 'zand'OR 
                    s.typelandgebruik= 'grasland'OR 
                    s.typelandgebruik= 'bos: griend'OR 
                    s.typelandgebruik= 'bos: griend'OR 
                    s.typelandgebruik= 'heide'OR 
                    s.typelandgebruik= 'populieren'OR 
                    s.typelandgebruik= 'bos: loofbos'OR 
                    s.typelandgebruik= 'duin'OR 
                    s.typelandgebruik= 'akkerland'OR 
                    s.typelandgebruik= 'basaltblokken, steenglooiing'OR 
                    s.typelandgebruik= 'dodenakker'OR 
                    s.typelandgebruik= 'fruitkwekerij' OR 
                    s.typelandgebruik= 'boomkwekerij' OR 
                    s.typelandgebruik= 'boomgaard' OR 
                    s.typelandgebruik= 'bos: naaldbos'OR
                    s.typelandgebruik= 'bos'
                THEN 'natural'
                ELSE s.typelandgebruik
            END AS lod1,
            CASE 
                WHEN 
                    s.typelandgebruik= 'aanlegsteiger' OR 
                    s.typelandgebruik= 'overig' OR
                    s.typelandgebruik= 'spoorbaanlichaam' OR
                    s.typelandgebruik= 'bebouwd gebied'
                THEN 'closed'
                WHEN
                    s.typelandgebruik= 'zand'OR
                    s.typelandgebruik= 'duin'OR
                    s.typelandgebruik= 'basaltblokken, steenglooiing' OR
                    s.typelandgebruik= 'braakliggend'
                THEN 'open'
                WHEN  
                    s.typelandgebruik= 'bos: gemengd bos' OR 
                    s.typelandgebruik= 'dodenakker met bos'OR
                    s.typelandgebruik= 'bos: griend'OR 
                    s.typelandgebruik= 'populieren'OR 
                    s.typelandgebruik= 'bos: loofbos'OR 
                    s.typelandgebruik= 'bos: naaldbos' OR
                    s.typelandgebruik= 'bos'
                THEN 'high_vegetation'
                WHEN
                    s.typelandgebruik= 'grasland'OR 
                    s.typelandgebruik= 'heide'
                THEN 'low_vegetation'
                WHEN
                    s.typelandgebruik= 'akkerland'OR 
                    s.typelandgebruik= 'dodenakker'OR 
                    s.typelandgebruik= 'fruitkwekerij' OR 
                    s.typelandgebruik= 'boomkwekerij' OR 
                    s.typelandgebruik= 'boomgaard' OR
                    s.typelandgebruik= 'kassengebied'
                THEN 'agriculture'
                ELSE s.typelandgebruik
            END AS lod2,
            ''                  AS name,
            0                   AS z_index,
            'Top250NL'         AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom 
    FROM 
        top250.terrein AS s;

-- TOP500NL terrein_vlak  
INSERT INTO visdata.terrain
    SELECT
            CASE 
                WHEN 
                    s.typelandgebruik= 'aanlegsteiger' OR 
                    s.typelandgebruik= 'overig' OR
                    s.typelandgebruik= 'spoorbaanlichaam' OR
                    s.typelandgebruik= 'bebouwd gebied' OR
                    s.typelandgebruik= 'braakliggend' OR
                    s.typelandgebruik= 'kassengebied'
                THEN 'human-made'
                WHEN  
                    s.typelandgebruik= 'bos: gemengd bos' OR 
                    s.typelandgebruik= 'dodenakker met bos'OR 
                    s.typelandgebruik= 'zand'OR 
                    s.typelandgebruik= 'grasland'OR 
                    s.typelandgebruik= 'bos: griend'OR 
                    s.typelandgebruik= 'bos: griend'OR 
                    s.typelandgebruik= 'heide'OR 
                    s.typelandgebruik= 'populieren'OR 
                    s.typelandgebruik= 'bos: loofbos'OR 
                    s.typelandgebruik= 'duin'OR 
                    s.typelandgebruik= 'akkerland'OR 
                    s.typelandgebruik= 'basaltblokken, steenglooiing'OR 
                    s.typelandgebruik= 'dodenakker'OR 
                    s.typelandgebruik= 'fruitkwekerij' OR 
                    s.typelandgebruik= 'boomkwekerij' OR 
                    s.typelandgebruik= 'boomgaard' OR 
                    s.typelandgebruik= 'bos: naaldbos'OR
                    s.typelandgebruik= 'bos'
                THEN 'natural'
                ELSE s.typelandgebruik
            END AS lod1,
            CASE 
                WHEN 
                    s.typelandgebruik= 'aanlegsteiger' OR 
                    s.typelandgebruik= 'overig' OR
                    s.typelandgebruik= 'spoorbaanlichaam' OR
                    s.typelandgebruik= 'bebouwd gebied'
                THEN 'closed'
                WHEN
                    s.typelandgebruik= 'zand'OR
                    s.typelandgebruik= 'duin'OR
                    s.typelandgebruik= 'basaltblokken, steenglooiing' OR
                    s.typelandgebruik= 'braakliggend'
                THEN 'open'
                WHEN  
                    s.typelandgebruik= 'bos: gemengd bos' OR 
                    s.typelandgebruik= 'dodenakker met bos'OR
                    s.typelandgebruik= 'bos: griend'OR 
                    s.typelandgebruik= 'populieren'OR 
                    s.typelandgebruik= 'bos: loofbos'OR 
                    s.typelandgebruik= 'bos: naaldbos' OR
                    s.typelandgebruik= 'bos'
                THEN 'high_vegetation'
                WHEN
                    s.typelandgebruik= 'grasland'OR 
                    s.typelandgebruik= 'heide'
                THEN 'low_vegetation'
                WHEN
                    s.typelandgebruik= 'akkerland'OR 
                    s.typelandgebruik= 'dodenakker'OR 
                    s.typelandgebruik= 'fruitkwekerij' OR 
                    s.typelandgebruik= 'boomkwekerij' OR 
                    s.typelandgebruik= 'boomgaard' OR
                    s.typelandgebruik= 'kassengebied'
                THEN 'agriculture'
                ELSE s.typelandgebruik
            END AS lod2,
            ''                  AS name,
            0                   AS z_index,
            'Top500NL'         AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom 
    FROM 
        top500.terrein AS s;

-- TOP1000NL terrein_vlak  
INSERT INTO visdata.terrain
    SELECT
            CASE 
                WHEN 
                    s.typelandgebruik= 'aanlegsteiger' OR 
                    s.typelandgebruik= 'overig' OR
                    s.typelandgebruik= 'spoorbaanlichaam' OR
                    s.typelandgebruik= 'bebouwd gebied' OR
                    s.typelandgebruik= 'braakliggend' OR
                    s.typelandgebruik= 'kassengebied'
                THEN 'human-made'
                WHEN  
                    s.typelandgebruik= 'bos: gemengd bos' OR 
                    s.typelandgebruik= 'dodenakker met bos'OR 
                    s.typelandgebruik= 'zand'OR 
                    s.typelandgebruik= 'grasland'OR 
                    s.typelandgebruik= 'bos: griend'OR 
                    s.typelandgebruik= 'bos: griend'OR 
                    s.typelandgebruik= 'heide'OR 
                    s.typelandgebruik= 'populieren'OR 
                    s.typelandgebruik= 'bos: loofbos'OR 
                    s.typelandgebruik= 'duin'OR 
                    s.typelandgebruik= 'akkerland'OR 
                    s.typelandgebruik= 'basaltblokken, steenglooiing'OR 
                    s.typelandgebruik= 'dodenakker'OR 
                    s.typelandgebruik= 'fruitkwekerij' OR 
                    s.typelandgebruik= 'boomkwekerij' OR 
                    s.typelandgebruik= 'boomgaard' OR 
                    s.typelandgebruik= 'bos: naaldbos'OR
                    s.typelandgebruik= 'bos'
                THEN 'natural'
                ELSE s.typelandgebruik
            END AS lod1,
            CASE 
                WHEN 
                    s.typelandgebruik= 'aanlegsteiger' OR 
                    s.typelandgebruik= 'overig' OR
                    s.typelandgebruik= 'spoorbaanlichaam' OR
                    s.typelandgebruik= 'bebouwd gebied'
                THEN 'closed'
                WHEN
                    s.typelandgebruik= 'zand'OR
                    s.typelandgebruik= 'duin'OR
                    s.typelandgebruik= 'basaltblokken, steenglooiing' OR
                    s.typelandgebruik= 'braakliggend'
                THEN 'open'
                WHEN  
                    s.typelandgebruik= 'bos: gemengd bos' OR 
                    s.typelandgebruik= 'dodenakker met bos'OR
                    s.typelandgebruik= 'bos: griend'OR 
                    s.typelandgebruik= 'populieren'OR 
                    s.typelandgebruik= 'bos: loofbos'OR 
                    s.typelandgebruik= 'bos: naaldbos' OR
                    s.typelandgebruik= 'bos'
                THEN 'high_vegetation'
                WHEN
                    s.typelandgebruik= 'grasland'OR 
                    s.typelandgebruik= 'heide'
                THEN 'low_vegetation'
                WHEN
                    s.typelandgebruik= 'akkerland'OR 
                    s.typelandgebruik= 'dodenakker'OR 
                    s.typelandgebruik= 'fruitkwekerij' OR 
                    s.typelandgebruik= 'boomkwekerij' OR 
                    s.typelandgebruik= 'boomgaard' OR
                    s.typelandgebruik= 'kassengebied'
                THEN 'agriculture'
                ELSE s.typelandgebruik
            END AS lod2,
            ''                  AS name,
            0                   AS z_index,
            'Top1000NL'         AS original_source,
            s.gml_id            AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
        top1000.terrein AS s;


-- test
DELETE FROM visdata.terrain WHERE ST_Area(geom)=0;
SELECT distinct (lod1) AS lod1 FROM visdata.terrain;
SELECT distinct (lod2) AS lod2 FROM visdata.terrain;
SELECT distinct (original_source) FROM visdata.terrain;
