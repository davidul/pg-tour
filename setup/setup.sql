CREATE SCHEMA vehicle_db;

CREATE SEQUENCE vehicle_db.armored_vehicle_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE vehicle_db.armored_vehicle
(
    id              INT PRIMARY KEY,
    deleted_at      TIMESTAMP,
    name            VARCHAR(255),
    description     VARCHAR(255),
    deployment_date DATE,
    production_date DATE
)