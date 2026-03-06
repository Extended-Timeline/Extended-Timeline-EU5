#!/bin/bash

mkdir tmp

qgis_process run gdal:polygonize --distance_units=meters --area_units=m2 --ellipsoid=EPSG:7030 --INPUT=locations.png --BAND=1 --FIELD=red --EIGHT_CONNECTEDNESS=false --EXTRA= --OUTPUT=tmp/ET5_red.gpkg

qgis_process run gdal:polygonize --distance_units=meters --area_units=m2 --ellipsoid=EPSG:7030 --INPUT=locations.png --BAND=2 --FIELD=green --EIGHT_CONNECTEDNESS=false --EXTRA= --OUTPUT=tmp/ET5_green.gpkg

qgis_process run gdal:polygonize --distance_units=meters --area_units=m2 --ellipsoid=EPSG:7030 --INPUT=locations.png --BAND=3 --FIELD=blue --EIGHT_CONNECTEDNESS=false --EXTRA= --OUTPUT=tmp/ET5_blue.gpkg

qgis_process run native:intersection --distance_units=meters --area_units=m2 --ellipsoid=EPSG:7030 --INPUT='tmp/ET5_red.gpkg|layername=ET5_red' --OVERLAY='tmp/ET5_green.gpkg|layername=ET5_green' --OVERLAY_FIELDS_PREFIX= --OUTPUT=tmp/ET5_rg.gpkg

qgis_process run native:intersection --distance_units=meters --area_units=m2 --ellipsoid=EPSG:7030 --INPUT='tmp/ET5_rg.gpkg|layername=ET5_rg' --OVERLAY='tmp/ET5_blue.gpkg|layername=ET5_blue' --OVERLAY_FIELDS_PREFIX= --OUTPUT=tmp/ET5_rgb.gpkg

qgis_process run native:collect --distance_units=meters --area_units=m2 --ellipsoid=EPSG:7030 --INPUT='tmp/ET5_rgb.gpkg|layername=ET5_rgb' --FIELD=red --FIELD=green --FIELD=blue --OUTPUT=ET5_vectorized.gpkg

rm -r tmp
