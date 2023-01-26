/* Problem 1 */ 
SELECT uri as url from url where url.id in (SELECT temp.article_id from (SELECT article_id,count(article_id) from keywords where 
(term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire')  GROUP BY(article_id)) as temp where temp.count=4);

/* Problem 2 */ 
SELECT uri as url from url where url.id in (SELECT temp.article_id from (SELECT article_id,count(article_id) 
from keywords where (term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire')  
GROUP BY(article_id)) as temp where temp.count>0);

/* Problem 3 */ 
SELECT uri as url from url where url.id in (SELECT temp2.article_id from (SELECT temp1.article_id from 
(SELECT article_id,count(article_id) from keywords where (term = 'reinforc')  
GROUP BY(article_id)) as temp1 where temp1.count>0) as temp2 where article_id not in 
(SELECT temp.article_id from 
(SELECT article_id,count(article_id) from keywords where (term = 'infantri'  or term = 'brigad' or term = 'fire')  
GROUP BY(article_id)) as temp where temp.count>0));

/* Problem 4 */ 
SELECT uri as url from url where url.id in (SELECT temp3.article_id from 
(SELECT temp2.article_id,sum(temp2.score) from (SELECT article_id,score from keywords where 
(article_id in (SELECT temp.article_id from (SELECT article_id,count(article_id) from keywords where 
(term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire')  
GROUP BY(article_id)) as temp where temp.count=4) and (term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire'))) as 
temp2 GROUP BY(temp2.article_id) ORDER BY sum DESC) as temp3);

/* Problem 5 */ 
SELECT uri as url from url where url.id in (SELECT temp3.article_id from 
(SELECT temp2.article_id,sum(temp2.score) from (SELECT article_id,score from keywords where 
(article_id in (SELECT temp.article_id from (SELECT article_id,count(article_id) from keywords where 
(term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire')  
GROUP BY(article_id)) as temp where temp.count>0) and (term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire'))) as 
temp2 GROUP BY(temp2.article_id) ORDER BY sum DESC) as temp3);

/* Problem 6 */ 



