/* 
    Problem 1: 
    Part A:
    Approach - 
    1. Put the data in schema Subject, Predicate, Object 
    2. Reduce data to only Predicate -> We tried keeping all but heap memory went out
    3. Group the records based on predicate. 
    4. Using that group for each such group we have to return the count of all such members in the original table. 
    5. Sort and Return Top 3 - Need Order by and LIMIT

    Output Received: 
    (<isCitizenOf>,2141725)
    (<hasFamilyName>,2002574)
    (<hasGivenName>,1984813)

Pig storage helps to define delimiter - This is just put as exploratory output as by default tab seperated 
values are parsed by LOAD */ 

lines = LOAD '/Users/monjoy/Desktop/Assignment3/Pig/yago_full_clean.tsv' USING PigStorage(' ')  AS (subject:chararray, predicate:chararray, object:chararray);
predicates = FOREACH lines GENERATE predicate; 
GroupedRecords = GROUP predicates BY predicate; 

count = FOREACH GroupedRecords GENERATE group AS predicate, COUNT(predicates) AS count;
order_by_data = ORDER count  BY count DESC;
out = LIMIT order_by_data 3; 
DUMP out; 

/*  Problem 1: 
    Part B :
    Approach: 
    1. Filter by Has Given predicates -> R1
    2. Filter to get livesInPredicate 
    3. Group R2 by basis of the subject (name)
    4. generate how many lives in clause is associated with one name 
    5. Filter to all name with count > 1 -> R2
    6. Join R1,R2 and extract the object of R1 
    7. Print Answer 

    Output Received 
*/

/* hasGivenName analysis */
lines = LOAD '/Users/monjoy/Desktop/Assignment3/Pig/yago_full_clean.tsv' USING PigStorage(' ')  AS (subject:chararray, predicate:chararray, object:chararray);
filter_data = FILTER lines BY predicate == '<hasGivenName>';

/* livesInPredicate analysis */
filter_data_livesIn = FILTER lines BY predicate == '<livesIn>'; 
GroupedRecords = GROUP filter_data_livesIn BY subject;
count_all = FOREACH GroupedRecords GENERATE group as name, COUNT(filter_data_livesIn) as count; 
more_than_one = FILTER count_all BY count >1;

/* Combined Analysis - Join on name */
result = JOIN filter_data BY subject, more_than_one BY name; 
final_ans = FOREACH result GENERATE filter_data::object;
DUMP final_ans; 



/* 
    Problem 2: 
    Approach -
    1. Load data into schema: 
        To view any variable use DESCRIBE and to view and instance use ILLUSTRATE. 
    2. Pass into UDF RandomVariable.java and use the output from it to create an output schema to write 
    the project_tool as mentioned in the problem. 
*/ 

/* Part A */
lines = LOAD '/Users/monjoy/Desktop/Assignment3/Pig/sample.txt' AS (studentName:chararray, rollNumber:chararray, emailID:chararray, groupNo:int);
GroupedRecords = GROUP lines BY groupNo; 
/* Part B */ 
REGISTER '/Users/monjoy/Desktop/Assignment3/Pig/Pig.jar';
out = FOREACH GroupedRecords GENERATE group as groupNo, FLATTEN(RandomValue(lines)) AS ( groupMembers: bag{tuple(studentName:chararray,rollNumber:chararray,emailID:chararray,groupNo:int)}, project_tool:chararray);
/* To view the output*/
DUMP out;
/* In schema form */ 
ILLUSTRATE out; 



