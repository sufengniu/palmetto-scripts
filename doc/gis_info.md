# Creating Database:
1. Get OSM file.
2. Create database:
  ```
  psql -U user
  
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
