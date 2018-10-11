
-- CREATE Database Table to store the information --
CREATE TEABLE mobility(pk serial primary key, sim_id text, created timestamp, event text, site_id text);

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