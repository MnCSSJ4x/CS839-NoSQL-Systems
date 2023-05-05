/* Creating table Schema */ 
CREATE EXTERNAL TABLE  rdf(
subject STRING,
predicate STRING,
object STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '
LOCATION '/Users/monjoy/Desktop/Assignment3/Hive/table';
/* Loading Data */
LOAD DATA LOCAL INPATH '/Users/monjoy/Desktop/Assignment3/Pig/yago_full_clean.tsv' INTO TABLE rdf;

/* Problem 1 -> 1*/
/* Getting top 3 names, to see values take the inner query */ 
SELECT predicate from (SELECT predicate,COUNT(predicate) as freq FROM rdf GROUP BY predicate ORDER BY freq desc LIMIT 3) subquery;
/* Problem 1 -> 2*/
SELECT object from(
    SELECT table1.*
    FROM
    (SELECT * FROM rdf WHERE predicate='<hasGivenName>') AS table1
    JOIN
    (SELECT * FROM rdf WHERE subject IN
    (SELECT t1.subject FROM
        (SELECT subject, COUNT(predicate) AS freq FROM rdf WHERE predicate='<livesIn>' GROUP BY subject) AS t1
    WHERE t1.freq>1)
    ) 
    AS table2
    ON table1.subject = table2.subject;
    
) subquery;

/* Problem 2 */
