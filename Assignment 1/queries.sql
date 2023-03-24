/* Problem 1 - Assumption: take the word as it is given and dont consider substring or superstrings */ 
SELECT uri as url from url where url.id in (SELECT temp.article_id from (SELECT article_id,count(article_id) from keywords where 
(term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire')  GROUP BY(article_id)) as temp where temp.count=4);
/* Problem 1 - Assumption: stemming concept applied and words like reinforce or reinforc will also be counted */ 
SELECT uri as url from url where url.id in (SELECT temp.article_id from (SELECT article_id,count(article_id) from keywords where 
(term like '%infantri%' or term like '%reinforc%' or term like '%brigad%' or term like '%fire%')  
GROUP BY(article_id)) as temp where temp.count=4);

/* Problem 2 */ 
SELECT count(*)from (SELECT uri as url from url where url.id in (SELECT temp.article_id from (SELECT article_id,count(article_id) 
from keywords where (term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire')  
GROUP BY(article_id)) as temp where temp.count>0)) as temp4;

/* Problem 2 another query */
SELECT uri as url from url where url.id in (SELECT article_id
from keywords where (term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire'));

/* Problem 3 */ 
SELECT uri as url from url where url.id in (SELECT temp2.article_id from (SELECT temp1.article_id from 
(SELECT article_id,count(article_id) from keywords where (term = 'reinforc')  
GROUP BY(article_id)) as temp1 where temp1.count>0) as temp2 where article_id not in 
(SELECT temp.article_id from 
(SELECT article_id,count(article_id) from keywords where (term = 'infantri'  or term = 'brigad' or term = 'fire')  
GROUP BY(article_id)) as temp where temp.count>0));

/* Problem 3 - Shortened */
SELECT uri as url from url where url.id in 
(SELECT article_id from keywords where term = 'reinforc' and article_id not in 
(SELECT article_id from keywords where (term='infantri' or term='brigad' or term='fire')));

/* Problem 4 */ 
SELECT uri as url from url where url.id in (SELECT temp3.article_id from 
(SELECT temp2.article_id,sum(temp2.score) from (SELECT article_id,score from keywords where 
(article_id in (SELECT temp.article_id from (SELECT article_id,count(article_id) from keywords where 
(term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire')  
GROUP BY(article_id)) as temp where temp.count=4) and (term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire'))) as 
temp2 GROUP BY(temp2.article_id) ORDER BY sum DESC) as temp3);


(SELECT temp2.article_id,sum(temp2.score) from (SELECT article_id,score from keywords where 
(article_id in (SELECT temp.article_id from (SELECT article_id,count(article_id) from keywords where 
(term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire')  
GROUP BY(article_id)) as temp where temp.count=4) and (term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire'))) as 
temp2 GROUP BY(temp2.article_id) ORDER BY sum DESC);

/* Problem 5 */ 
SELECT uri as url from url where url.id in (SELECT temp3.article_id from 
(SELECT temp2.article_id,sum(temp2.score) from (SELECT article_id,score from keywords where 
(article_id in (SELECT temp.article_id from (SELECT article_id,count(article_id) from keywords where 
(term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire')  
GROUP BY(article_id)) as temp where temp.count>0) and (term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire'))) as 
temp2 GROUP BY(temp2.article_id) ORDER BY sum DESC) as temp3);

SELECT count(*) from (SELECT temp2.article_id,sum(temp2.score) from (SELECT article_id,score from keywords where 
(article_id in (SELECT temp.article_id from (SELECT article_id,count(article_id) from keywords where 
(term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire')  
GROUP BY(article_id)) as temp where temp.count>0) and (term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire'))) as 
temp2 GROUP BY(temp2.article_id) ORDER BY sum DESC) as temp7;

/* Problem 6 -> Assumption 1: */ 
SELECT uri as url from url where url.id in 
(SELECT temp10.article_id from (SELECT temp7.article_id, greatest(temp7.scoreone, temp7.scorefour) AS maxx from 
(SELECT temp9.article_id, temp8.scorefour, temp9.scoreone from ((SELECT temp2.article_id, sum(temp2.score) as "scorefour" from 
(SELECT article_id, score from keywords where (article_id in (SELECT temp2.article_id from (SELECT temp1.article_id from 
(SELECT article_id,count(article_id) from keywords where (term = 'reinforc') GROUP BY(article_id)) as temp1 where temp1.count>0) 
as temp2 where article_id not in 
(SELECT temp.article_id from (SELECT article_id, count(article_id) from keywords where 
(term = 'brigad' or term = 'infantri' or term = 'fire') GROUP BY(article_id)) as temp where temp.count=3)) 
and (term = 'brigad' or term = 'infantri' or term = 'fire'))) as temp2 GROUP BY(article_id)) as temp8 
FULL OUTER JOIN
(SELECT temp4.article_id, sum(temp4.score) as "scoreone" from (SELECT article_id, score from keywords where 
(article_id in (SELECT temp4.article_id from (SELECT temp5.article_id from (SELECT article_id,count(article_id) from keywords where 
(term = 'reinforc') GROUP BY(article_id)) as temp5 where temp5.count>0)
as temp4 where article_id not in 
(SELECT temp6.article_id from (SELECT article_id, count(article_id) from keywords where 
(term = 'brigad' or term = 'infantri' or term = 'fire') GROUP BY(article_id)) as temp6 where temp6.count=3)) and 
(term = 'reinforc'))) as temp4 GROUP BY(article_id)) as temp9 on temp8.article_id = temp9.article_id)) 
as temp7 ORDER BY maxx DESC) as temp10);


-- (SELECT temp7.article_id, greatest(temp7.scoreone, temp7.scorefour) AS maxx from 
-- (SELECT temp9.article_id, temp8.scorefour, temp9.scoreone from ((SELECT temp2.article_id, sum(temp2.score) as "scorefour" from 
-- (SELECT article_id, score from keywords where (article_id in (SELECT temp2.article_id from (SELECT temp1.article_id from 
-- (SELECT article_id,count(article_id) from keywords where (term = 'reinforc') GROUP BY(article_id)) as temp1 where temp1.count>0) 
-- as temp2 where article_id not in 
-- (SELECT temp.article_id from (SELECT article_id, count(article_id) from keywords where 
-- (term = 'brigad' or term = 'infantri' or term = 'fire') GROUP BY(article_id)) as temp where temp.count=3)) 
-- and (term = 'brigad' or term = 'infantri' or term = 'fire'))) as temp2 GROUP BY(article_id)) as temp8 
-- FULL OUTER JOIN
-- (SELECT temp4.article_id, sum(temp4.score) as "scoreone" from (SELECT article_id, score from keywords where 
-- (article_id in (SELECT temp4.article_id from (SELECT temp5.article_id from (SELECT article_id,count(article_id) from keywords where 
-- (term = 'reinforc') GROUP BY(article_id)) as temp5 where temp5.count>0)
-- as temp4 where article_id not in 
-- (SELECT temp6.article_id from (SELECT article_id, count(article_id) from keywords where 
-- (term = 'brigad' or term = 'infantri' or term = 'fire') GROUP BY(article_id)) as temp6 where temp6.count=3)) and 
-- (term = 'reinforc'))) as temp4 GROUP BY(article_id)))))

SELECT temp7.article_id, greatest(temp7.scoreone, temp7.scorefour) AS maxx from 
(SELECT temp9.article_id, temp8.scorefour, temp9.scoreone from ((SELECT temp2.article_id, sum(temp2.score) as "scorefour" from 
(SELECT article_id, score from keywords where (article_id in (SELECT temp2.article_id from (SELECT temp1.article_id from 
(SELECT article_id,count(article_id) from keywords where (term = 'reinforc') GROUP BY(article_id)) as temp1 where temp1.count>0) 
as temp2 where article_id not in 
(SELECT temp.article_id from (SELECT article_id, count(article_id) from keywords where 
(term = 'brigad' or term = 'infantri' or term = 'fire') GROUP BY(article_id)) as temp where temp.count=3)) 
and (term = 'brigad' or term = 'infantri' or term = 'fire'))) as temp2 GROUP BY(article_id)) as temp8 
FULL OUTER JOIN
(SELECT temp4.article_id, sum(temp4.score) as "scoreone" from (SELECT article_id, score from keywords where 
(article_id in (SELECT temp4.article_id from (SELECT temp5.article_id from (SELECT article_id,count(article_id) from keywords where 
(term = 'reinforc') GROUP BY(article_id)) as temp5 where temp5.count>0)
as temp4 where article_id not in 
(SELECT temp6.article_id from (SELECT article_id, count(article_id) from keywords where 
(term = 'brigad' or term = 'infantri' or term = 'fire') GROUP BY(article_id)) as temp6 where temp6.count=3)) and 
(term = 'reinforc'))) as temp4 GROUP BY(article_id)) as temp9 on temp8.article_id = temp9.article_id)) 
as temp7 ORDER BY maxx DESC;

/* Problem 6 -> Assumption 2: */
SELECT uri from url INNER JOIN
(SELECT *,  (temp1.sumone + temp2.sumfour) as f_score from 
(SELECT article_id as id1, sum(score) as sumone  from keywords where term = 'reinforc'  GROUP BY(id1)) as temp1 
LEFT JOIN 
(SELECT article_id as id2, count(article_id) as count, sum(score) as sumfour from keywords where 
term = 'brigad' OR term = 'fire'  OR term = 'infantri' GROUP BY (id2)) as temp2 ON temp1.id1 = temp2.id2
where temp2.count IS NULL OR temp2.count != 3
)as comparision
ON url.id = comparision.id1
ORDER BY comparision.f_score DESC, comparision.sumone DESC;



