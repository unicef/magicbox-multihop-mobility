-- Calculate the permutation and aggregate the result --

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