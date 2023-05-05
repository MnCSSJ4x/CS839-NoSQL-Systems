/* Problem 1.1 */ 
SELECT predicate, count(*) as frequency from
(SELECT predicate from yagodataset) as temp group by temp.predicate
order by frequency DESC
LIMIT 3;
/* Problem 1.2 */ 
select name.object from (select object from yagodataset where predicate="<hasGivenName>") as name JOIN 
(select subject, count(*) as freq from yagodataset where predicate="<livesIn>" group by subject having freq>1) as temp ON(temp.subject == name.object);

/* PART 2 problem 1 - With Partitioning, Without Bucketing */ 

CREATE EXTERNAL TABLE  yagodataset(
subject STRING,
predicate STRING,
object STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '
LOCATION '/Users/monjoy/Desktop/Assignment3/Hive/table';


CREATE TABLE yago_part_noBuck(
    subject STRING,
    object STRING
)
PARTITIONED BY (predicate STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '
STORED AS TEXTFILE
LOCATION '/Users/monjoy/Desktop/Assignment3/Hive/table';

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<actedIn>")
SELECT subject, object 
FROM yagodataset
WHERE predicate = "<actedIn>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<hasAcademicAdvisor>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<hasAcademicAdvisor>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<hasChild>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<hasChild>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<hasFamilyName>")
SELECT subject,object
FROM yagodataset
WHERE predicate = "<hasFamilyName>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<hasWebsite>")
SELECT subject,object
FROM yagodataset
WHERE predicate = "<hasWebsite>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<hasWonPrize>")
SELECT subject,object
FROM yagodataset
WHERE predicate = "<hasWonPrize>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<isInterestedIn>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<isInterestedIn>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<isKnownFor>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<isKnownFor>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<directed>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<directed>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<edited>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<edited>";


INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<graduatedFrom>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<graduatedFrom>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<hasGender>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<hasGender>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<hasMusicalRole>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<hasMusicalRole>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<isCitizenOf>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<isCitizenOf>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<isMarriedTo>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<isMarriedTo>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<isPoliticianOf>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<isPoliticianOf>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<playsFor>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<playsFor>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<worksAt>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<worksAt>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<wroteMusicFor>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<wroteMusicFor>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<created>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<created>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<diedIn>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<diedIn>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<hasGivenName>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<hasGivenName>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<influences>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<influences>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<isAffiliatedTo>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<isAffiliatedTo>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<isLeaderOf>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<isLeaderOf>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<owns>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<owns>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<participatedIn>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<participatedIn>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<wasBornIn>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<wasBornIn>";

INSERT INTO TABLE yago_part_noBuck PARTITION (predicate="<livesIn>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<livesIn>";

/* PART 2 Problem 2 - With Bucketing, With Clustering*/ 
CREATE TABLE yago_buck_part(
    subject STRING,
    object STRING
)
PARTITIONED BY (predicate STRING)
CLUSTERED BY (object) INTO 5 buckets
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '
STORED AS TEXTFILE
LOCATION '/Users/monjoy/Desktop/Assignment3/Hive/table';

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<actedIn>")
SELECT subject, object 
FROM yagodataset
WHERE predicate = "<actedIn>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<hasAcademicAdvisor>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<hasAcademicAdvisor>"DISTRIBUTE BY object
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<hasChild>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<hasChild>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<hasFamilyName>")
SELECT subject,object
FROM yagodataset
WHERE predicate = "<hasFamilyName>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<hasWebsite>")
SELECT subject,object
FROM yagodataset
WHERE predicate = "<hasWebsite>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<hasWonPrize>")
SELECT subject,object
FROM yagodataset
WHERE predicate = "<hasWonPrize>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<isInterestedIn>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<isInterestedIn>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<isKnownFor>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<isKnownFor>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<directed>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<directed>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<edited>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<edited>"
DISTRIBUTE BY object;


INSERT INTO TABLE yago_buck_part PARTITION (predicate="<graduatedFrom>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<graduatedFrom>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<hasGender>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<hasGender>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<hasMusicalRole>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<hasMusicalRole>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<isCitizenOf>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<isCitizenOf>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<isMarriedTo>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<isMarriedTo>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<isPoliticianOf>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<isPoliticianOf>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<playsFor>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<playsFor>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<worksAt>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<worksAt>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<wroteMusicFor>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<wroteMusicFor>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<created>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<created>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<diedIn>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<diedIn>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<hasGivenName>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<hasGivenName>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<influences>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<influences>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<isAffiliatedTo>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<isAffiliatedTo>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<isLeaderOf>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<isLeaderOf>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<owns>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<owns>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<participatedIn>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<participatedIn>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<wasBornIn>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<wasBornIn>"
DISTRIBUTE BY object;

INSERT INTO TABLE yago_buck_part PARTITION (predicate="<livesIn>")
SELECT subject, object
FROM yagodataset
WHERE predicate = "<livesIn>"
DISTRIBUTE BY object;

select name.subject, name.object, lives.object from (select subject, object from yago_buck_part where predicate ="<hasGivenName>") as name JOIN 
(select subject, object from yago_buck_part where predicate="<livesIn>") as lives ON(lives.subject = name.subject);


/* PART 2 problem 3 - Without Partitioning Without Bucketing */
select name.subject, name.object, lives.object from (select subject, object from yagodataset where predicate ="<hasGivenName>") as name JOIN 
(select subject, object from yagodataset where predicate="<livesIn>") as lives ON(lives.subject = name.subject);