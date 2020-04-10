# This solution uses a single query.

# Steps
1. Connect to PostgreSQL

2. Create a sample database table using the SQL queries above or create something like it. And insert the sample data.


```sql
-- CREATE Database Table to store the information --
CREATE TABLE mobility(pk serial primary key, sim_id text, created timestamp, event text, site_id text);

-- INSERT the Sample Data Sets into the mobility table --
INSERT INTO mobility(sim_id, created, event, site_id) values('0001', timestamp '2018-10-11 00:00', 'sms', 'A');
INSERT INTO  mobility(sim_id, created, event, site_id) values('0001', timestamp '2018-10-11 00:00', 'sms', 'A');
INSERT INTO  mobility(sim_id, created, event, site_id) values('0001', timestamp '2018-10-11 01:00', 'sms', 'A');
INSERT INTO  mobility(sim_id, created, event, site_id) values('0001', timestamp '2018-10-11 02:00', 'sms', 'A');
INSERT INTO  mobility(sim_id, created, event, site_id) values('0001', timestamp '2018-10-11 03:00', 'sms', 'A');
INSERT INTO  mobility(sim_id, created, event, site_id) values('0001', timestamp '2018-10-11 04:00', 'sms', 'B');
INSERT INTO  mobility(sim_id, created, event, site_id) values('0001', timestamp '2018-10-11 05:00', 'sms', 'B');
INSERT INTO  mobility(sim_id, created, event, site_id) values('0001', timestamp '2018-10-11 06:00', 'sms', 'B');
INSERT INTO  mobility(sim_id, created, event, site_id) values('0001', timestamp '2018-10-11 07:00', 'sms', 'C');
insert into mobility(sim_id, created, event, site_id) values('0001', timestamp '2018-10-11 08:00', 'sms', 'A');
INSERT INTO  mobility(sim_id, created, event, site_id) values('0002', timestamp '2018-10-11 00:00', 'sms', 'C');
INSERT INTO  mobility(sim_id, created, event, site_id) values('0002', timestamp '2018-10-11 01:00', 'sms', 'A');
INSERT INTO  mobility(sim_id, created, event, site_id) values('0002', timestamp '2018-10-11 02:00', 'sms', 'B');
```
You can also download from sampleData.sql


3. Run the SQL script and see the output

```sql
SELECT site1, site2, count(*) num FROM (
	SELECT sim_id, site1, site2 FROM (
		SELECT m3.sim_id, m4.site_id site1, m5.site_id site2, m3.created1, m3.created2 FROM (
				SELECT m1.sim_id, m1.created created1, m2.created created2 FROM mobility m1
				INNER JOIN mobility m2 on m1.sim_id = m2.sim_id AND m1.created < m2.created
					GROUP BY m1.sim_id, m1.created, m2.created ORDER BY m1.sim_id, m1.created
			) m3
			INNER JOIN mobility m4 ON m3.sim_id = m4.sim_id AND m3.created1 = m4.created
			INNER JOIN mobility m5 ON m3.sim_id = m5.sim_id AND m3.created2 = m5.created
			WHERE m4.site_id != m5.site_id
			ORDER BY m3.sim_id, m3.created1, m3.created2
		) m6
		GROUP BY m6.sim_id, m6.site1, m6.site2, m6.site1, m6.site2 HAVING m6.site1 != m6.site2
	) m7 GROUP BY m7.site1, m7.site2
;

```

![Result for sample](./media/result.png)


You can also see from calculateMobileHop.sql


That is all!

# Contributors

Christopher Tate: https://github.com/computate

David Kaylor: https://github.com/d-kaylor

Bryant Son: https://github.com/bryantson
