-- Drop index
DROP INDEX idx_activity_filter_hash;

-- Query without index
EXPLAIN ANALYZE SELECT * FROM activity_filter WHERE location = 'location8312';


CREATE INDEX idx_activity_filter_hash
ON activity_filter USING HASH (location);

-- Query with index
EXPLAIN ANALYZE SELECT * FROM activity_filter WHERE location = 'location8312';





-- clear data
DELETE FROM activity_filter
WHERE location LIKE 'location%';
