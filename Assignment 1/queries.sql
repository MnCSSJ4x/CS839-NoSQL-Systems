/* Problem 1 */ 
SELECT uri as url from url where url.id in (SELECT temp.article_id from (SELECT article_id,count(article_id) from keywords where (term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire')  GROUP BY(article_id)) as temp where temp.count=4);
/* Problem 2 */ 
SELECT uri as url from url where url.id in (SELECT temp.article_id from (SELECT article_id,count(article_id) from keywords where (term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire')  GROUP BY(article_id)) as temp where temp.count>0);
/* Problem 3 */ 
SELECT uri as url from url where url.id in (SELECT temp2.article_id from (SELECT temp1.article_id from 
(SELECT article_id,count(article_id) from keywords where (term = 'reinforc')  
GROUP BY(article_id)) as temp1 where temp1.count>0) as temp2 where article_id not in 
(SELECT temp.article_id from 
(SELECT article_id,count(article_id) from keywords where (term = 'infantri'  or term = 'brigad' or term = 'fire')  
GROUP BY(article_id)) as temp where temp.count>0));
/* Problem 4 */ 
SELECT article_id,sum(score) where article_id in (SELECT temp.article_id from (SELECT article_id,count(article_id) from keywords where (term = 'infantri' or term = 'reinforc' or term = 'brigad' or term = 'fire')  GROUP BY(article_id)) as temp where temp.count=4);


