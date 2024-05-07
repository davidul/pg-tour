create rule soft_delete as on delete to vehicle_db.armored_vehicle
where vehicle_db.armored_vehicle.deleted_at is not null
do instead update vehicle_db.armored_vehicle  set deleted_at = now() where OLD.id = id;


