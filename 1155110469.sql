/*
Student ID: 1155110469
Name: Lui Kwan Kin
*/
/* Query 1 */
Spool result1.lst
SELECT LID, LEAGUE_NAME, REGION_NAME, YEAR
FROM LEAGUES l, REGIONS r
WHERE l.rid = r.rid AND
(l.SEASON = 'Spring' OR l.SEASON = 'Summer')
ORDER BY LID ASC;
Spool off

/* Query 2 */
Spool result2.lst
SELECT TID, TEAM_NAME, AVERAGE_AGE
FROM TEAMS t
INNER JOIN LEAGUES l
ON t.TID = l.CHAMPION_TID AND
l.SEASON = 'Autumn' AND
l.YEAR >= 2015
GROUP BY TID, TEAM_NAME, AVERAGE_AGE
HAVING COUNT(*) > 1;
Spool off

/* Query 3 */
Spool result3.lst
SELECT Tb.TID, Tb.SEASON, MAX(W_NUM) AS W_NUM
FROM(SELECT TID, SEASON, COUNT(*) AS W_NUM
     FROM LEAGUES l, TEAMS t
     WHERE t.TID = l.CHAMPION_TID
     GROUP by t.TID, l.SEASON
     ORDER BY SEASON
     ) Tb
GROUP BY SEASON
Spool off

/* Query 4 */
Spool result4.lst
SELECT sponsors.SID, sponsor_name, COUNT(*) AS L_NUM
FROM SPONSORS sponsors, LEAGUES leagues, SUPPORT support
WHERE leagues.LID = support.LID
AND sponsors.SID = support.SID
GROUP BY sponsors.sid
ORDER by sponsors.sid
LIMIT 5
Spool off

/* Query 5 */
Spool result5.lst
Select DISTINCT l.LID, l.LEAGUE_NAME
FROM LEAGUES l, SUPPORT sup, SPONSORS spon, TEAMS t
WHERE (l.season = 'Summer'
OR l.season = 'Winter')
AND l.lid = sup.lid
AND spon.market_value > 50
AND l.CHAMPION_TID = t.TID
AND t.average_age < 30
Spool off

/* Query 6 */
Spool result6.lst
SELECT tb.sid, SUM(sponsorship)/(SQRT(tb.market_value)*LOG(2,SQRT(tb.FOOTBALL_RANKING)+1)) AS HOT
FROM(select su.SID, su.lid, l.rid, su.SPONSORSHIP, sp.MARKET_VALUE, r.FOOTBALL_RANKING
	from SUPPORT su, SPONSORS sp, REGIONS r, LEAGUES l
	where sp.sid = su.SID
	AND l.lid = su.LID
	AND r.RID = l.rid
     AND sp.market_value > 40
	AND r.FOOTBALL_RANKING < 10) tb
GROUP BY tb.sid, tb.rid,tb.sponsorship, tb.market_value, tb.FOOTBALL_RANKING
ORDER BY sid DESC
Spool off

/* Query 7 */
Spool result7.lst
SELECT tb.sid, SUM(sponsorship)/(SQRT(tb.market_value)*LOG(2,SQRT(tb.FOOTBALL_RANKING)+1)) AS HOT
FROM(select su.SID, su.lid, l.rid, su.SPONSORSHIP, sp.MARKET_VALUE, r.FOOTBALL_RANKING
	from SUPPORT su, SPONSORS sp, REGIONS r, LEAGUES l
	where sp.sid = su.SID
	AND l.lid = su.LID
	AND r.RID = l.rid) tb
GROUP BY tb.sid, tb.rid,tb.sponsorship, tb.market_value, tb.FOOTBALL_RANKING
ORDER BY tb.sid DESC
Spool off

/* Query 8 */
Spool result8.lst
SELECT DISTINCT sp.sid, sp.sponsor_name
FROM(SELECT l1.lid
	from(SELECT l.champion_tid, COUNT(*) COUNT
		FROM LEAGUES l, TEAMS t
		where t.TID = l.champion_tid
		GROUP BY l.champion_tid
		ORDER BY count DESC
		LIMIT 1) best_t,LEAGUES l1
		WHERE l1.champion_tid = best_t.champion_tid) sp_l, SPONSORS sp, SUPPORT su
WHERE su.LID = sp_l.lid
AND su.SID = sp.SID
ORDER BY sp.sid ASC
Spool off