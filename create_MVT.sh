# -- CREATE MVT 

# -- Select data that intersects with tile area in PostGIS
# -- Scale coordinates to vector tile's coordinates
# -- Clip data to tile area
# -- Encode Vector Tile File
# -- Serve Vector Tile

rm -rf /data/tiles_gen/*
mkdir -p /data/tiles_gen

# BGT
tippecanoe --allow-existing --no-tile-stats --no-feature-limit \
--no-tile-size-limit --no-line-simplification --no-polygon-splitting  --no-tiny-polygon-reduction --no-tile-compression \
--output-to-directory=/data/tiles_gen \
--maximum-zoom=17 --minimum-zoom=16 \
--named-layer=admin:/data/geojson/admin_10.geojson \
--named-layer=water:/data/geojson/water_bgt.geojson \
--named-layer=water-line:/data/geojson/water-line_bgt.geojson \
--named-layer=terrain:/data/geojson/terrain_bgt.geojson \
--named-layer=urban:/data/geojson/urban_bgt.geojson \
--named-layer=infra:/data/geojson/infra_bgt.geojson

#top10
tippecanoe --allow-existing --no-tile-stats --no-feature-limit --no-tile-size-limit \
--coalesce-smallest-as-needed --no-tiny-polygon-reduction --no-line-simplification --no-polygon-splitting --no-tile-compression \
--output-to-directory=/data/tiles_gen \
--maximum-zoom=15 --minimum-zoom=14 \
--named-layer=admin:/data/geojson/admin_10.geojson \
--named-layer=water:/data/geojson/water_10.geojson \
--named-layer=water-line:/data/geojson/water-line_10.geojson \
--named-layer=terrain:/data/geojson/terrain_10.geojson \
--named-layer=urban:/data/geojson/urban_10.geojson \
--named-layer=infra:/data/geojson/infra_10.geojson

#top50
tippecanoe --allow-existing --no-tile-stats --no-feature-limit --no-tile-size-limit \
--coalesce-smallest-as-needed --no-tiny-polygon-reduction --no-line-simplification --no-polygon-splitting --no-tile-compression \
--output-to-directory=/data/tiles_gen \
--maximum-zoom=13 --minimum-zoom=12 \
--named-layer=admin:/data/geojson/admin_50.geojson \
--named-layer=water:/data/geojson/water_50.geojson \
--named-layer=water-line:/data/geojson/water-line_50.geojson \
--named-layer=terrain:/data/geojson/terrain_50.geojson \
--named-layer=urban:/data/geojson/urban_50.geojson \
--named-layer=infra:/data/geojson/infra_50.geojson

#top100
tippecanoe --allow-existing --no-tile-stats --no-feature-limit --no-tile-size-limit \
--coalesce-smallest-as-needed --no-tiny-polygon-reduction --no-line-simplification --no-polygon-splitting --no-tile-compression \
--output-to-directory=/data/tiles_gen \
--maximum-zoom=11 --minimum-zoom=10 \
--named-layer=admin:/data/geojson/admin_100.geojson \
--named-layer=water:/data/geojson/water_100.geojson \
--named-layer=water-line:/data/geojson/water-line_100.geojson \
--named-layer=terrain:/data/geojson/terrain_100.geojson \
--named-layer=urban:/data/geojson/urban_100.geojson \
--named-layer=infra:/data/geojson/infra_100.geojson

#top250
tippecanoe --allow-existing --no-tile-stats --no-feature-limit --no-tile-size-limit \
--drop-smallest-as-needed --no-tiny-polygon-reduction --no-line-simplification --no-polygon-splitting --no-tile-compression \
--output-to-directory=/data/tiles_gen \
--maximum-zoom=9 --minimum-zoom=8 \
--named-layer=admin:/data/geojson/admin_250.geojson \
--named-layer=water:/data/geojson/water_250.geojson \
--named-layer=water-line:/data/geojson/water-line_250.geojson \
--named-layer=terrain:/data/geojson/terrain_250.geojson \
--named-layer=urban:/data/geojson/urban_250.geojson \
--named-layer=infra:/data/geojson/infra_250.geojson

#top500
tippecanoe --allow-existing --no-tile-stats --no-feature-limit --no-tile-size-limit \
--drop-smallest-as-needed --no-tiny-polygon-reduction --no-line-simplification --no-polygon-splitting --no-tile-compression \
--output-to-directory=/data/tiles_gen \
--maximum-zoom=7 --minimum-zoom=6 \
--named-layer=admin:/data/geojson/admin_500.geojson \
--named-layer=water:/data/geojson/water_500.geojson \
--named-layer=water-line:/data/geojson/water-line_500.geojson \
--named-layer=terrain:/data/geojson/terrain_500.geojson \
--named-layer=urban:/data/geojson/urban_500.geojson \
--named-layer=infra:/data/geojson/infra_500.geojson

# top1000
tippecanoe --allow-existing --no-tile-stats --no-feature-limit \
--drop-smallest-as-needed --no-polygon-splitting --no-tile-compression \
--output-to-directory=/data/tiles_gen \
--maximum-zoom=5 --minimum-zoom=0 \
--named-layer=admin:/data/geojson/admin_1000.geojson \
--named-layer=water:/data/geojson/water_1000.geojson \
--named-layer=water-line:/data/geojson/water-line_1000.geojson \
--named-layer=terrain:/data/geojson/terrain_1000.geojson \
--named-layer=urban:/data/geojson/urban_1000.geojson \
--named-layer=infra:/data/geojson/infra_1000.geojson

rm -rf /data/tiles/*
mv /data/tiles_gen/* /data/tiles
rm -rf /data/tiles_gen/*

# -z zoom or --maximum-zoom=zoom: Maxzoom: the highest zoom level for which tiles are generated (default 14)
# -zg or --maximum-zoom=g: Guess what is probably a reasonable maxzoom based on the spacing of features.
# -Z zoom or --minimum-zoom=zoom: Minzoom: the lowest zoom level for which tiles are generated (default 0)


