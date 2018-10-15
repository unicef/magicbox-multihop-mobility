# This solution uses a temporary table to store each individual's multi-hop trips, before performing an aggregation of all user multi-hop trips.

CREATE TABLE EVENT_LOG (
  trip_id integer,
	sim_id varchar(100),
	time_stamp varchar(100),
	site_id varchar(100)
);


INSERT INTO EVENT_LOG (trip_id, sim_id, time_stamp, site_id)
SELECT a1, a2, a3, a4
FROM   [YOUR_TABLE]


CREATE TABLE SIMPLIFIED_TRIPS (
    row_id integer,
    sim_id varchar(100),
	  site_id varchar(100)
);

DECLARE @total_trips integer
DECLARE @counter integer
DECLARE @current_site varchar(100)
DECLARE @current_sim varchar(100)
DECLARE @row_id integer

SET @total_trips = (SELECT COUNT(*) FROM EVENT_LOG)
SET @counter = 1
SET @current_site = ''
SET @current_sim = ''
SET @row_id = 1

WHILE @counter <= @total_trips
    IF ((SELECT TOP 1 site_id FROM EVENT_LOG ORDER BY sim_id, time_stamp) <> @current_site)
        BEGIN
            SET @current_site = (SELECT TOP 1 site_id FROM EVENT_LOG ORDER BY sim_id, time_stamp)
            SET @current_sim = (SELECT TOP 1 sim_id FROM EVENT_LOG ORDER BY sim_id, time_stamp)
            INSERT INTO SIMPLIFIED_TRIPS (row_id, sim_id, site_id) VALUES (@row_id, @current_sim, @current_site)
            DELETE FROM EVENT_LOG WHERE trip_id = (SELECT TOP 1 trip_id FROM EVENT_LOG ORDER BY sim_id, time_stamp)
            SET @counter = @counter + 1
            SET @row_id = @row_id + 1
        END
    ELSE
        BEGIN
            DELETE FROM EVENT_LOG WHERE trip_id = (SELECT TOP 1 trip_id FROM EVENT_LOG ORDER BY sim_id, time_stamp)
            SET @counter = @counter + 1
        END


SELECT * FROM SIMPLIFIED_TRIPS

CREATE TABLE RESULTS (
        site_1 varchar(100),
        site_2 varchar(100)
)

DECLARE @h integer
DECLARE @max_hops integer

SET @h=1
SET @max_hops = (SELECT TOP 1 COUNT(*) AS count FROM SIMPLIFIED_TRIPS GROUP BY sim_id ORDER BY count DESC)
WHILE(@h < @max_hops)
    BEGIN
        INSERT INTO RESULTS (site_1, site_2) SELECT site_id, site_id2 FROM (
            SELECT row_id, sim_id, site_id,
                    LEAD (sim_id, @h) OVER(ORDER BY sim_id, row_id) AS sim_id2,
                    LEAD (site_id, @h) OVER(ORDER BY sim_id, row_id) AS site_id2
            FROM SIMPLIFIED_TRIPS
            ) a
        WHERE a.sim_id = a.sim_id2;
        SET @h = @h + 1
    END

SELECT * FROM RESULTS
