CREATE KEYSPACE IF NOT EXISTS nifi_ks
  WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

USE nifi_ks;

CREATE TABLE IF NOT EXISTS telemetry_data (
  timestamp text PRIMARY KEY,
  caudal_rio double,
  temperatura double,
  nivel_embalse text,
  volumen_embalse text
);
