# -- CREATE MVT 

# -- Select data that intersects with tile area in PostGIS
# -- Scale coordinates to vector tile's coordinates
# -- Clip data to tile area
# -- Encode Vector Tile File
# -- Serve Vector Tile

# BGT
tippecanoe --force --no-tile-stats --no-feature-limit \
--no-tile-size-limit --no-line-simplification --no-polygon-splitting  --no-tiny-polygon-reduction \
--output-to-directory=/data/tiles_gen/bgt \
--maximum-zoom=17 --minimum-zoom=16 \
--named-layer=admin:/data/geojson/admin_10.geojson \
--named-layer=water:/data/geojson/water_bgt.geojson \
--named-layer=water-line:/data/geojson/water-line_bgt.geojson \
--named-layer=terrain:/data/geojson/terrain_bgt.geojson \
--named-layer=urban:/data/geojson/urban_bgt.geojson \
--named-layer=infra:/data/geojson/infra_bgt.geojson

rm -rf /data/tiles/16
rm -rf /data/tiles/17
cp -r /data/tiles_gen/bgt/16 /data/tiles
cp -r /data/tiles_gen/bgt/17 /data/tiles

#top10
tippecanoe --force --no-tile-stats --no-feature-limit \
--coalesce-smallest-as-needed --no-tiny-polygon-reduction --no-line-simplification --no-polygon-splitting \
--output-to-directory=/data/tiles_gen/top10nl \
--maximum-zoom=15 --minimum-zoom=14 \
--named-layer=admin:/data/geojson/admin_10.geojson \
--named-layer=water:/data/geojson/water_10.geojson \
--named-layer=water-line:/data/geojson/water-line_10.geojson \
--named-layer=terrain:/data/geojson/terrain_10.geojson \
--named-layer=urban:/data/geojson/urban_10.geojson \
--named-layer=infra:/data/geojson/infra_10.geojson

rm -rf /data/tiles/14
rm -rf /data/tiles/15
cp -r /data/tiles_gen/top10nl/14 /data/tiles
cp -r /data/tiles_gen/top10nl/15 /data/tiles

#top50
tippecanoe --force --no-tile-stats --no-feature-limit \
--coalesce-smallest-as-needed --no-tiny-polygon-reduction --no-line-simplification --no-polygon-splitting  \
--output-to-directory=/data/tiles_gen/top50nl \
--maximum-zoom=13 --minimum-zoom=12 \
--named-layer=admin:/data/geojson/admin_50.geojson \
--named-layer=water:/data/geojson/water_50.geojson \
--named-layer=water-line:/data/geojson/water-line_50.geojson \
--named-layer=terrain:/data/geojson/terrain_50.geojson \
--named-layer=urban:/data/geojson/urban_50.geojson \
--named-layer=infra:/data/geojson/infra_50.geojson

rm -rf /data/tiles/12
rm -rf /data/tiles/13
cp -r /data/tiles_gen/top50nl/12 /data/tiles
cp -r /data/tiles_gen/top50nl/13 /data/tiles

#top100
tippecanoe --force --no-tile-stats --no-feature-limit \
--coalesce-smallest-as-needed --no-tiny-polygon-reduction --no-line-simplification --no-polygon-splitting \
--output-to-directory=/data/tiles_gen/top100nl \
--maximum-zoom=11 --minimum-zoom=10 \
--named-layer=admin:/data/geojson/admin_100.geojson \
--named-layer=water:/data/geojson/water_100.geojson \
--named-layer=water-line:/data/geojson/water-line_100.geojson \
--named-layer=terrain:/data/geojson/terrain_100.geojson \
--named-layer=urban:/data/geojson/urban_100.geojson \
--named-layer=infra:/data/geojson/infra_100.geojson

rm -rf /data/tiles/10
rm -rf /data/tiles/11
cp -r /data/tiles_gen/top100nl/10 /data/tiles
cp -r /data/tiles_gen/top100nl/11 /data/tiles

#top250
tippecanoe --force --no-tile-stats --no-feature-limit \
--coalesce-smallest-as-needed --no-tiny-polygon-reduction --no-line-simplification --simplify-only-low-zooms --no-polygon-splitting \
--output-to-directory=/data/tiles_gen/top250nl \
--maximum-zoom=9 --minimum-zoom=8 \
--named-layer=admin:/data/geojson/admin_250.geojson \
--named-layer=water:/data/geojson/water_250.geojson \
--named-layer=water-line:/data/geojson/water-line_250.geojson \
--named-layer=terrain:/data/geojson/terrain_250.geojson \
--named-layer=urban:/data/geojson/urban_250.geojson \
--named-layer=infra:/data/geojson/infra_250.geojson

rm -rf /data/tiles/8
rm -rf /data/tiles/9
cp -r /data/tiles_gen/top250nl/8 /data/tiles
cp -r /data/tiles_gen/top250nl/9 /data/tiles

#top500
tippecanoe --force --no-tile-stats --no-feature-limit \
--no-tile-stats --allow-existing --force --coalesce-smallest-as-needed --simplification=5 --drop-smallest-as-needed  --no-polygon-splitting --simplify-only-low-zooms --no-tiny-polygon-reduction  \
--output-to-directory=/data/tiles_gen/top500nl \
--maximum-zoom=7 --minimum-zoom=6 \
--named-layer=admin:/data/geojson/admin_500.geojson \
--named-layer=water:/data/geojson/water_500.geojson \
--named-layer=water-line:/data/geojson/water-line_500.geojson \
--named-layer=terrain:/data/geojson/terrain_500.geojson \
--named-layer=urban:/data/geojson/urban_500.geojson \
--named-layer=infra:/data/geojson/infra_500.geojson

rm -rf /data/tiles/6
rm -rf /data/tiles/7
cp -r /data/tiles_gen/top500nl/6 /data/tiles
cp -r /data/tiles_gen/top500nl/7 /data/tiles

# top1000
tippecanoe --force --no-tile-stats --no-feature-limit \
--coalesce-smallest-as-needed --simplification=5 --drop-smallest-as-needed  --simplify-only-low-zooms --no-polygon-splitting \
--output-to-directory=/data/tiles_gen/top1000nl \
--maximum-zoom=5 --minimum-zoom=0 \
--named-layer=admin:/data/geojson/admin_1000.geojson \
--named-layer=water:/data/geojson/water_1000.geojson \
--named-layer=water-line:/data/geojson/water-line_1000.geojson \
--named-layer=terrain:/data/geojson/terrain_1000.geojson \
--named-layer=urban:/data/geojson/urban_1000.geojson \
--named-layer=infra:/data/geojson/infra_1000.geojson

rm -rf /data/tiles/0
rm -rf /data/tiles/1
rm -rf /data/tiles/2
rm -rf /data/tiles/3
rm -rf /data/tiles/4
rm -rf /data/tiles/5
cp -r /data/tiles_gen/top1000nl/0 /data/tiles
cp -r /data/tiles_gen/top1000nl/1 /data/tiles
cp -r /data/tiles_gen/top1000nl/2 /data/tiles
cp -r /data/tiles_gen/top1000nl/3 /data/tiles
cp -r /data/tiles_gen/top1000nl/4 /data/tiles
cp -r /data/tiles_gen/top1000nl/5 /data/tiles


# -z zoom or --maximum-zoom=zoom: Maxzoom: the highest zoom level for which tiles are generated (default 14)
# -zg or --maximum-zoom=g: Guess what is probably a reasonable maxzoom based on the spacing of features.
# -Z zoom or --minimum-zoom=zoom: Minzoom: the lowest zoom level for which tiles are generated (default 0)


