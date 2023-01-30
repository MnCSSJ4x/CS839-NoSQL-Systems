CREATE DATABASE "wiki"
  WITH OWNER "postgres"
  ENCODING 'UTF8';
  
CREATE TABLE url(
    id INT NOT NULL UNIQUE ,
    uri VARCHAR(2048) NOT NULL
);
CREATE TABLE keywords(
    term_id SERIAL  ,
    term VARCHAR(100) NOT NULL, 
    article_id INT NOT NULL, 
    score NUMERIC(4,3) NOT NULL

);
