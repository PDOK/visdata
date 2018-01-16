DROP TABLE IF EXISTS visdata.terrain CASCADE;
CREATE TABLE visdata.terrain (
            lod1 text,
            lod2 text,
			lod3 text,
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
                    s."fysiekVoorkomen" = 'gemengd bos' OR
                    s."fysiekVoorkomen" = 'loofbos' OR
                    s."fysiekVoorkomen" = 'houtwal' OR
                    s."fysiekVoorkomen" = 'naaldbos' 
                THEN 'high_vegetation'
                WHEN 
                    s."fysiekVoorkomen" = 'grasland overig' OR
                    s."fysiekVoorkomen" = 'groenvoorziening' OR
                    s."fysiekVoorkomen" = 'heide' OR
                    s."fysiekVoorkomen" = 'struiken' OR
                    s."fysiekVoorkomen" = 'moeras' OR
                    s."fysiekVoorkomen" = 'rietland' OR
                    s."fysiekVoorkomen" = 'transitie' 
                THEN 'low_vegetation'
                WHEN
                    s."fysiekVoorkomen" = 'boomteelt' OR
                    s."fysiekVoorkomen" = 'bouwland' OR
                    s."fysiekVoorkomen" = 'grasland agrarisch' OR
                    s."fysiekVoorkomen" = 'fruitteelt'
                THEN 'agriculture'
                ELSE s."fysiekVoorkomen" 
            END AS lod2,
			s."fysiekVoorkomen" AS lod3,
            ''                            AS name,
            s."relatieveHoogteligging"    AS z_index,
            'BGT'                         AS original_source,
            'NL.IMGeo.' || s."lokaalID"     AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
      bgtv3."BegroeidTerreindeel" AS s;

INSERT INTO visdata.terrain 
      SELECT
            'human-made'                  AS lod1,
            CASE
                WHEN 
                    s."fysiekVoorkomen" = 'gesloten verharding' OR
                    s."fysiekVoorkomen" = 'half verhard' OR
                    s."fysiekVoorkomen" = 'transitie' OR
                    s."fysiekVoorkomen" = 'open verharding'
                THEN 'closed'
                WHEN
                    s."fysiekVoorkomen" = 'onverhard' OR
                    s."fysiekVoorkomen" = 'zand' OR
                    s."fysiekVoorkomen" = 'erf'
                THEN 'open'
                ELSE s."fysiekVoorkomen"
            END AS lod2,
			s."fysiekVoorkomen" AS lod3,
            ''                            AS name,
            s."relatieveHoogteligging"    AS z_index,
            'BGT'                         AS original_source,
            'NL.IMGeo.' || s."lokaalID"     AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
      bgtv3."OnbegroeidTerreindeel" AS s;

INSERT INTO visdata.terrain 
      SELECT
            'natural'                     AS lod1,
            'low_vegetation'              AS lod2,
			type                          AS lod3,
            ''                            AS name,
            s."relatieveHoogteligging"      AS z_index,
            'BGT'                         AS original_source,
            'NL.IMGeo.' || s."lokaalID"               AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
      bgtv3."OndersteunendWaterdeel" AS s;

INSERT INTO visdata.terrain 
      SELECT
			CASE
                WHEN 
                    s."fysiekVoorkomen" = 'groenvoorziening'
                THEN 'natural'
				ELSE 'human-made'
			END AS lod1,
            CASE
                WHEN 
                    s."fysiekVoorkomen" = 'gesloten verharding' OR
                    s."fysiekVoorkomen" = 'half verhard' OR
                    s."fysiekVoorkomen" = 'transitie' OR
                    s."fysiekVoorkomen" = 'open verharding'
                THEN 'closed'
                WHEN
                    s."fysiekVoorkomen" = 'onverhard' OR
                    s."fysiekVoorkomen" = 'zand'
                THEN 'open'
                WHEN 
                    s."fysiekVoorkomen" = 'groenvoorziening'
                THEN 'low_vegetation'
                ELSE s."fysiekVoorkomen"
            END AS lod2,
			s."fysiekVoorkomen" AS lod3,
            ''                            AS name,
            s."relatieveHoogteligging"      AS z_index,
            'BGT'                         AS original_source,
            'NL.IMGeo.' || s."lokaalID"                     AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
      bgtv3."OndersteunendWegdeel" AS s;

INSERT INTO visdata.terrain 
      SELECT
            'human-made'                  AS lod1,
            'closed'                      AS lod2,
			"typeOverbruggingsdeel"       AS lod3,
            ''                            AS name,
            s."relatieveHoogteligging"      AS z_index,
            'BGT'                         AS original_source,
            'NL.IMGeo.' || s."lokaalID"               AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
      bgtv3."Overbruggingsdeel" AS s;

INSERT INTO visdata.terrain 
      SELECT
            'human-made'                  AS lod1,
            CASE
                WHEN 
                    s."fysiekVoorkomen" = 'gesloten verharding' OR
                    s."fysiekVoorkomen" = 'half verhard' OR
                    s."fysiekVoorkomen" = 'transitie' OR
                    s."fysiekVoorkomen" = 'open verharding'
                THEN 'closed'
                WHEN
                    s."fysiekVoorkomen" = 'onverhard' OR
                    s."fysiekVoorkomen" = 'zand'
                THEN 'open'
                ELSE s."fysiekVoorkomen"
            END AS lod2,
			s."fysiekVoorkomen" AS lod3,
            ''                            AS name,
            s."relatieveHoogteligging"      AS z_index,
            'BGT'                         AS original_source,
            'NL.IMGeo.' || s."lokaalID"               AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
      bgtv3."Wegdeel" AS s;

-- TOP10NL terrein_vlak 
INSERT INTO visdata.terrain
      SELECT
             CASE 
                WHEN 
                    s.typelandgebruik = 'aanlegsteiger' OR 
                    s.typelandgebruik = 'overig' OR
                    s.typelandgebruik = 'spoorbaanlichaam' OR
                    s.typelandgebruik = 'bebouwd gebied' OR
                    s.typelandgebruik = 'braakliggend' OR
                    s.typelandgebruik = 'kassengebied'
                THEN 'human-made'
                WHEN  
                    s.typelandgebruik = 'bos: gemengd bos' OR 
                    s.typelandgebruik = 'dodenakker met bos' OR 
                    s.typelandgebruik = 'zand' OR 
                    s.typelandgebruik = 'grasland' OR 
                    s.typelandgebruik = 'bos: griend' OR 
                    s.typelandgebruik = 'heide' OR 
                    s.typelandgebruik = 'populieren' OR 
                    s.typelandgebruik = 'bos: loofbos' OR 
                    s.typelandgebruik = 'duin' OR 
                    s.typelandgebruik = 'akkerland' OR 
                    s.typelandgebruik = 'basaltblokken, steenglooiing' OR 
                    s.typelandgebruik = 'dodenakker' OR 
                    s.typelandgebruik = 'fruitkwekerij' OR 
                    s.typelandgebruik = 'boomkwekerij' OR 
                    s.typelandgebruik = 'boomgaard' OR 
                    s.typelandgebruik = 'bos: naaldbos' OR
                    s.typelandgebruik = 'bos'
                THEN 'natural'
                ELSE s.typelandgebruik
            END AS lod1,
            CASE 
                WHEN 
                    s.typelandgebruik = 'aanlegsteiger' OR 
                    s.typelandgebruik = 'overig' OR
                    s.typelandgebruik = 'spoorbaanlichaam' OR
                    s.typelandgebruik = 'bebouwd gebied'
                THEN 'closed'
                WHEN
                    s.typelandgebruik = 'zand' OR
                    s.typelandgebruik = 'duin' OR
                    s.typelandgebruik = 'basaltblokken, steenglooiing' OR
                    s.typelandgebruik = 'braakliggend'
                THEN 'open'
                WHEN  
                    s.typelandgebruik = 'bos: gemengd bos' OR 
                    s.typelandgebruik = 'dodenakker met bos' OR
                    s.typelandgebruik = 'bos: griend' OR 
                    s.typelandgebruik = 'populieren' OR 
                    s.typelandgebruik = 'bos: loofbos' OR 
                    s.typelandgebruik = 'bos: naaldbos' OR
                    s.typelandgebruik = 'bos'
                THEN 'high_vegetation'
                WHEN
                    s.typelandgebruik = 'grasland' OR 
                    s.typelandgebruik = 'heide'
                THEN 'low_vegetation'
                WHEN
                    s.typelandgebruik = 'akkerland' OR 
                    s.typelandgebruik = 'dodenakker' OR 
                    s.typelandgebruik = 'fruitkwekerij' OR 
                    s.typelandgebruik = 'boomkwekerij' OR 
                    s.typelandgebruik = 'boomgaard' OR
                    s.typelandgebruik = 'kassengebied'
                THEN 'agriculture'
                ELSE s.typelandgebruik
            END AS lod2,
			s.typelandgebruik AS lod3,
            s.naam                  	AS name,
            s.hoogteniveau::integer    	AS z_index,
            'TOP10NL'               	AS original_source,
            'NL.TOP10NL.'|| s.lokaalid	AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s._geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
      top10nlv2.terrein AS s
    WHERE 
        s.typelandgebruik != 'bebouwd gebied';

-- TOP50NL terrein_vlak  
INSERT INTO visdata.terrain
    SELECT
            CASE 
                WHEN 
                    s.typelandgebruik = 'aanlegsteiger' OR 
                    s.typelandgebruik = 'overig' OR
                    s.typelandgebruik = 'spoorbaanlichaam' OR
                    s.typelandgebruik = 'bebouwd gebied' OR
                    s.typelandgebruik = 'braakliggend' OR
                    s.typelandgebruik = 'kassengebied'
                THEN 'human-made'
                WHEN  
                    s.typelandgebruik = 'bos: gemengd bos' OR 
                    s.typelandgebruik = 'dodenakker met bos' OR 
                    s.typelandgebruik = 'zand' OR 
                    s.typelandgebruik = 'grasland' OR 
                    s.typelandgebruik = 'bos: griend' OR 
                    s.typelandgebruik = 'heide' OR 
                    s.typelandgebruik = 'populieren' OR 
                    s.typelandgebruik = 'bos: loofbos' OR 
                    s.typelandgebruik = 'duin' OR 
                    s.typelandgebruik = 'akkerland' OR 
                    s.typelandgebruik = 'basaltblokken, steenglooiing' OR 
                    s.typelandgebruik = 'dodenakker' OR 
                    s.typelandgebruik = 'fruitkwekerij' OR 
                    s.typelandgebruik = 'boomkwekerij' OR 
                    s.typelandgebruik = 'boomgaard' OR 
                    s.typelandgebruik = 'bos: naaldbos' OR
                    s.typelandgebruik = 'bos'
                THEN 'natural'
                ELSE s.typelandgebruik
            END AS lod1,
            CASE 
                WHEN 
                    s.typelandgebruik = 'aanlegsteiger' OR 
                    s.typelandgebruik = 'overig' OR
                    s.typelandgebruik = 'spoorbaanlichaam' OR
                    s.typelandgebruik = 'bebouwd gebied'
                THEN 'closed'
                WHEN
                    s.typelandgebruik = 'zand' OR
                    s.typelandgebruik = 'duin' OR
                    s.typelandgebruik = 'basaltblokken, steenglooiing' OR
                    s.typelandgebruik = 'braakliggend'
                THEN 'open'
                WHEN  
                    s.typelandgebruik = 'bos: gemengd bos' OR 
                    s.typelandgebruik = 'dodenakker met bos' OR
                    s.typelandgebruik = 'bos: griend' OR 
                    s.typelandgebruik = 'populieren' OR 
                    s.typelandgebruik = 'bos: loofbos' OR 
                    s.typelandgebruik = 'bos: naaldbos' OR
                    s.typelandgebruik = 'bos'
                THEN 'high_vegetation'
                WHEN
                    s.typelandgebruik = 'grasland' OR 
                    s.typelandgebruik = 'heide'
                THEN 'low_vegetation'
                WHEN
                    s.typelandgebruik = 'akkerland' OR 
                    s.typelandgebruik = 'dodenakker' OR 
                    s.typelandgebruik = 'fruitkwekerij' OR 
                    s.typelandgebruik = 'boomkwekerij' OR 
                    s.typelandgebruik = 'boomgaard' OR
                    s.typelandgebruik = 'kassengebied'
                THEN 'agriculture'
                ELSE s.typelandgebruik
            END AS lod2,
			s.typelandgebruik   AS lod3,
            ''                  AS name,
            0                   AS z_index,
            'TOP50NL'           AS original_source,
            namespace || '.' || lokaalid AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
        top50nl.terrein_vlak AS s
    WHERE 
      s.typelandgebruik != 'bebouwd gebied';

INSERT INTO visdata.terrain
    SELECT
            CASE 
                WHEN 
                    s.typeweg = 'parkeerplaats'
                    OR s.typeweg = 'parkeerplaats: carpool'
                    OR s.typeweg = 'parkeerplaats: P+R'
                    OR s.typeweg = 'rolbaan, platform'
                    OR s.typeweg = 'startbaan, landingsbaan'
                THEN 'human-made'
            END  AS lod1,
            'closed'            AS lod2,
			s.typeweg           AS lod3,
            ''                  AS name,
            0                   AS z_index,
            'TOP50NL'           AS original_source,
            namespace || '.' || lokaalid AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
        top50nl.wegdeel_vlak AS s
    WHERE 
        s.typeweg = 'parkeerplaats'
        OR s.typeweg = 'parkeerplaats: carpool'
        OR s.typeweg = 'parkeerplaats: P+R'
        OR s.typeweg = 'rolbaan, platform'
        OR s.typeweg = 'startbaan, landingsbaan'
    ;

-- TOP100NL terrein_vlak  
INSERT INTO visdata.terrain
    SELECT
         CASE 
                WHEN 
                    s.typelandgebruik = 'aanlegsteiger' OR 
                    s.typelandgebruik = 'overig' OR
                    s.typelandgebruik = 'spoorbaanlichaam' OR
                    s.typelandgebruik = 'bebouwd gebied' OR
                    s.typelandgebruik = 'braakliggend' OR
                    s.typelandgebruik = 'kassengebied'
                THEN 'human-made'
                WHEN  
                    s.typelandgebruik = 'bos: gemengd bos' OR 
                    s.typelandgebruik = 'dodenakker met bos' OR 
                    s.typelandgebruik = 'zand' OR 
                    s.typelandgebruik = 'grasland' OR 
                    s.typelandgebruik = 'bos: griend' OR 
                    s.typelandgebruik = 'heide' OR 
                    s.typelandgebruik = 'populieren' OR 
                    s.typelandgebruik = 'bos: loofbos' OR 
                    s.typelandgebruik = 'duin' OR 
                    s.typelandgebruik = 'akkerland' OR 
                    s.typelandgebruik = 'basaltblokken, steenglooiing' OR 
                    s.typelandgebruik = 'dodenakker' OR 
                    s.typelandgebruik = 'fruitkwekerij' OR 
                    s.typelandgebruik = 'boomkwekerij' OR 
                    s.typelandgebruik = 'boomgaard' OR 
                    s.typelandgebruik = 'bos: naaldbos' OR
                    s.typelandgebruik = 'bos'
                THEN 'natural'
                ELSE s.typelandgebruik
            END AS lod1,
            CASE 
                WHEN 
                    s.typelandgebruik = 'aanlegsteiger' OR 
                    s.typelandgebruik = 'overig' OR
                    s.typelandgebruik = 'spoorbaanlichaam' OR
                    s.typelandgebruik = 'bebouwd gebied'
                THEN 'closed'
                WHEN
                    s.typelandgebruik = 'zand' OR
                    s.typelandgebruik = 'duin' OR
                    s.typelandgebruik = 'basaltblokken, steenglooiing' OR
                    s.typelandgebruik = 'braakliggend'
                THEN 'open'
                WHEN  
                    s.typelandgebruik = 'bos: gemengd bos' OR 
                    s.typelandgebruik = 'dodenakker met bos' OR
                    s.typelandgebruik = 'bos: griend' OR 
                    s.typelandgebruik = 'populieren' OR 
                    s.typelandgebruik = 'bos: loofbos' OR 
                    s.typelandgebruik = 'bos: naaldbos' OR
                    s.typelandgebruik = 'bos'
                THEN 'high_vegetation'
                WHEN
                    s.typelandgebruik = 'grasland' OR 
                    s.typelandgebruik = 'heide'
                THEN 'low_vegetation'
                WHEN
                    s.typelandgebruik = 'akkerland' OR 
                    s.typelandgebruik = 'dodenakker' OR 
                    s.typelandgebruik = 'fruitkwekerij' OR 
                    s.typelandgebruik = 'boomkwekerij' OR 
                    s.typelandgebruik = 'boomgaard' OR
                    s.typelandgebruik = 'kassengebied'
                THEN 'agriculture'
                ELSE s.typelandgebruik
            END AS lod2,
			s.typelandgebruik   AS lod3,
            ''                  AS name,
            0                   AS z_index,
            'TOP100NL'         AS original_source,
            namespace || '.' || lokaalid AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom 
    FROM 
        top100nl.terrein_vlak AS s;

-- TOP250NL terrein_vlak  
INSERT INTO visdata.terrain
    SELECT
           CASE 
                WHEN 
                    s.typelandgebruik = 'aanlegsteiger' OR 
                    s.typelandgebruik = 'overig' OR
                    s.typelandgebruik = 'spoorbaanlichaam' OR
                    s.typelandgebruik = 'bebouwd gebied' OR
                    s.typelandgebruik = 'braakliggend' OR
                    s.typelandgebruik = 'kassengebied'
                THEN 'human-made'
                WHEN  
                    s.typelandgebruik = 'bos: gemengd bos' OR 
                    s.typelandgebruik = 'dodenakker met bos' OR 
                    s.typelandgebruik = 'zand' OR 
                    s.typelandgebruik = 'grasland' OR 
                    s.typelandgebruik = 'bos: griend' OR 
                    s.typelandgebruik = 'heide' OR 
                    s.typelandgebruik = 'populieren' OR 
                    s.typelandgebruik = 'bos: loofbos' OR 
                    s.typelandgebruik = 'duin' OR 
                    s.typelandgebruik = 'akkerland' OR 
                    s.typelandgebruik = 'basaltblokken, steenglooiing' OR 
                    s.typelandgebruik = 'dodenakker' OR 
                    s.typelandgebruik = 'fruitkwekerij' OR 
                    s.typelandgebruik = 'boomkwekerij' OR 
                    s.typelandgebruik = 'boomgaard' OR 
                    s.typelandgebruik = 'bos: naaldbos' OR
                    s.typelandgebruik = 'bos'
                THEN 'natural'
                ELSE s.typelandgebruik
            END AS lod1,
            CASE 
                WHEN 
                    s.typelandgebruik = 'aanlegsteiger' OR 
                    s.typelandgebruik = 'overig' OR
                    s.typelandgebruik = 'spoorbaanlichaam' OR
                    s.typelandgebruik = 'bebouwd gebied'
                THEN 'closed'
                WHEN
                    s.typelandgebruik = 'zand' OR
                    s.typelandgebruik = 'duin' OR
                    s.typelandgebruik = 'basaltblokken, steenglooiing' OR
                    s.typelandgebruik = 'braakliggend'
                THEN 'open'
                WHEN  
                    s.typelandgebruik = 'bos: gemengd bos' OR 
                    s.typelandgebruik = 'dodenakker met bos' OR
                    s.typelandgebruik = 'bos: griend' OR 
                    s.typelandgebruik = 'populieren' OR 
                    s.typelandgebruik = 'bos: loofbos' OR 
                    s.typelandgebruik = 'bos: naaldbos' OR
                    s.typelandgebruik = 'bos'
                THEN 'high_vegetation'
                WHEN
                    s.typelandgebruik = 'grasland' OR 
                    s.typelandgebruik = 'heide'
                THEN 'low_vegetation'
                WHEN
                    s.typelandgebruik = 'akkerland' OR 
                    s.typelandgebruik = 'dodenakker' OR 
                    s.typelandgebruik = 'fruitkwekerij' OR 
                    s.typelandgebruik = 'boomkwekerij' OR 
                    s.typelandgebruik = 'boomgaard' OR
                    s.typelandgebruik = 'kassengebied'
                THEN 'agriculture'
                ELSE s.typelandgebruik
            END AS lod2,
			s.typelandgebruik   AS lod3,
            ''                  AS name,
            0                   AS z_index,
            'TOP250NL'         AS original_source,
            namespace || '.' || lokaalid AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom 
    FROM 
        top250nl.terrein_vlak AS s;

-- TOP500NL terrein_vlak  
INSERT INTO visdata.terrain
    SELECT
            CASE 
                WHEN 
                    s.typelandgebruik = 'aanlegsteiger' OR 
                    s.typelandgebruik = 'overig' OR
                    s.typelandgebruik = 'spoorbaanlichaam' OR
                    s.typelandgebruik = 'bebouwd gebied' OR
                    s.typelandgebruik = 'braakliggend' OR
                    s.typelandgebruik = 'kassengebied'
                THEN 'human-made'
                WHEN  
                    s.typelandgebruik = 'bos: gemengd bos' OR 
                    s.typelandgebruik = 'dodenakker met bos' OR 
                    s.typelandgebruik = 'zand' OR 
                    s.typelandgebruik = 'grasland' OR 
                    s.typelandgebruik = 'bos: griend' OR 
                    s.typelandgebruik = 'heide' OR 
                    s.typelandgebruik = 'populieren' OR 
                    s.typelandgebruik = 'bos: loofbos' OR 
                    s.typelandgebruik = 'duin' OR 
                    s.typelandgebruik = 'akkerland' OR 
                    s.typelandgebruik = 'basaltblokken, steenglooiing' OR 
                    s.typelandgebruik = 'dodenakker' OR 
                    s.typelandgebruik = 'fruitkwekerij' OR 
                    s.typelandgebruik = 'boomkwekerij' OR 
                    s.typelandgebruik = 'boomgaard' OR 
                    s.typelandgebruik = 'bos: naaldbos' OR
                    s.typelandgebruik = 'bos'
                THEN 'natural'
                ELSE s.typelandgebruik
            END AS lod1,
            CASE 
                WHEN 
                    s.typelandgebruik = 'aanlegsteiger' OR 
                    s.typelandgebruik = 'overig' OR
                    s.typelandgebruik = 'spoorbaanlichaam' OR
                    s.typelandgebruik = 'bebouwd gebied'
                THEN 'closed'
                WHEN
                    s.typelandgebruik = 'zand' OR
                    s.typelandgebruik = 'duin' OR
                    s.typelandgebruik = 'basaltblokken, steenglooiing' OR
                    s.typelandgebruik = 'braakliggend'
                THEN 'open'
                WHEN  
                    s.typelandgebruik = 'bos: gemengd bos' OR 
                    s.typelandgebruik = 'dodenakker met bos' OR
                    s.typelandgebruik = 'bos: griend' OR 
                    s.typelandgebruik = 'populieren' OR 
                    s.typelandgebruik = 'bos: loofbos' OR 
                    s.typelandgebruik = 'bos: naaldbos' OR
                    s.typelandgebruik = 'bos'
                THEN 'high_vegetation'
                WHEN
                    s.typelandgebruik = 'grasland' OR 
                    s.typelandgebruik = 'heide'
                THEN 'low_vegetation'
                WHEN
                    s.typelandgebruik = 'akkerland' OR 
                    s.typelandgebruik = 'dodenakker' OR 
                    s.typelandgebruik = 'fruitkwekerij' OR 
                    s.typelandgebruik = 'boomkwekerij' OR 
                    s.typelandgebruik = 'boomgaard' OR
                    s.typelandgebruik = 'kassengebied'
                THEN 'agriculture'
                ELSE s.typelandgebruik
            END AS lod2,
			s.typelandgebruik   AS lod3,
            ''                  AS name,
            0                   AS z_index,
            'TOP500NL'         AS original_source,
            namespace || '.' || lokaalid AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom 
    FROM 
        top500nl.terrein_vlak AS s;

-- TOP1000NL terrein_vlak  
INSERT INTO visdata.terrain
    SELECT
            CASE 
                WHEN 
                    s.typelandgebruik = 'aanlegsteiger' OR 
                    s.typelandgebruik = 'overig' OR
                    s.typelandgebruik = 'spoorbaanlichaam' OR
                    s.typelandgebruik = 'bebouwd gebied' OR
                    s.typelandgebruik = 'braakliggend' OR
                    s.typelandgebruik = 'kassengebied'
                THEN 'human-made'
                WHEN  
                    s.typelandgebruik = 'bos: gemengd bos' OR 
                    s.typelandgebruik = 'dodenakker met bos' OR 
                    s.typelandgebruik = 'zand' OR 
                    s.typelandgebruik = 'grasland' OR 
                    s.typelandgebruik = 'bos: griend' OR 
                    s.typelandgebruik = 'heide' OR 
                    s.typelandgebruik = 'populieren' OR 
                    s.typelandgebruik = 'bos: loofbos' OR 
                    s.typelandgebruik = 'duin' OR 
                    s.typelandgebruik = 'akkerland' OR 
                    s.typelandgebruik = 'basaltblokken, steenglooiing' OR 
                    s.typelandgebruik = 'dodenakker' OR 
                    s.typelandgebruik = 'fruitkwekerij' OR 
                    s.typelandgebruik = 'boomkwekerij' OR 
                    s.typelandgebruik = 'boomgaard' OR 
                    s.typelandgebruik = 'bos: naaldbos' OR
                    s.typelandgebruik = 'bos'
                THEN 'natural'
                ELSE s.typelandgebruik
            END AS lod1,
            CASE 
                WHEN 
                    s.typelandgebruik = 'aanlegsteiger' OR 
                    s.typelandgebruik = 'overig' OR
                    s.typelandgebruik = 'spoorbaanlichaam' OR
                    s.typelandgebruik = 'bebouwd gebied'
                THEN 'closed'
                WHEN
                    s.typelandgebruik = 'zand' OR
                    s.typelandgebruik = 'duin' OR
                    s.typelandgebruik = 'basaltblokken, steenglooiing' OR
                    s.typelandgebruik = 'braakliggend'
                THEN 'open'
                WHEN  
                    s.typelandgebruik = 'bos: gemengd bos' OR 
                    s.typelandgebruik = 'dodenakker met bos' OR
                    s.typelandgebruik = 'bos: griend' OR 
                    s.typelandgebruik = 'populieren' OR 
                    s.typelandgebruik = 'bos: loofbos' OR 
                    s.typelandgebruik = 'bos: naaldbos' OR
                    s.typelandgebruik = 'bos'
                THEN 'high_vegetation'
                WHEN
                    s.typelandgebruik = 'grasland' OR 
                    s.typelandgebruik = 'heide'
                THEN 'low_vegetation'
                WHEN
                    s.typelandgebruik = 'akkerland' OR 
                    s.typelandgebruik = 'dodenakker' OR 
                    s.typelandgebruik = 'fruitkwekerij' OR 
                    s.typelandgebruik = 'boomkwekerij' OR 
                    s.typelandgebruik = 'boomgaard' OR
                    s.typelandgebruik = 'kassengebied'
                THEN 'agriculture'
                ELSE s.typelandgebruik
            END AS lod2,
			s.typelandgebruik   AS lod3,
            ''                  AS name,
            0                   AS z_index,
            'TOP1000NL'         AS original_source,
            namespace || '.' || lokaalid AS original_id,
            (ST_Dump(ST_ForceRHR(ST_CollectionExtract(s.wkb_geometry,3)))).geom::geometry(POLYGON,28992) AS geom
    FROM 
        top1000nl.terrein_vlak AS s;

		
DELETE FROM visdata.terrain WHERE ST_Area(geom)=0;

-- Controle
SELECT
	original_source,
	lod1,
	lod2,
	COUNT(*) AS aantal 
FROM
	visdata.terrain 
GROUP BY original_source, lod1, lod2 
ORDER BY original_source, lod1, lod2;

SELECT
	original_source,
	lod1,
	lod2,
	lod3,
	COUNT(*) AS aantal 
FROM
	visdata.terrain 
GROUP BY original_source, lod1, lod2, lod3 
ORDER BY original_source, lod1, lod2, lod3;
