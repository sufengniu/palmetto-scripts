# Creating Database:
1. Get OSM file.
2. Create database:
  ```
  psql
  
  CREATE DATABASE dbname;
  \c dbname
  CREATE EXTENSION postgis;
  CREATE EXTENSION pgrouting;
  ```
3. Get mapconfig for cars:
  ```
  wget https://raw.githubusercontent.com/pgRouting/osm2pgrouting/master/mapconfig_for_cars.xml
  ```
4. Import OSM data:
  ```
  osm2pgrouting -f map.osm -c mapconfig_for_cars.xml -d dbname
  ```

# Georeference with Affine Correspondence:
1. QGIS georeference Image to EPSG:3857 using Google Maps Openlayers output GeoTIFF
2. QGIS georeference Image to EPSG:4326 with previous GeoTIFF output GCP
3. In python:
```python
import numpy as np
data = numpy.loadtxt('r_01c_20150923-164500.jpg.points', skiprows=1, delimiter=',')
x = data[:,2:4]
y = data[:,0:2]
X = np.hstack([x, np.ones((x.shape[0], 1))])
Y = np.hstack([y, np.ones((y.shape[0], 1))])
A, res, rank, s = np.linalg.lstsq(X, Y)
A[np.abs(A) < 1e-10]=0
```
