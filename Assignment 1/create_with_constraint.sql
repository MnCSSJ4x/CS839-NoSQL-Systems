CREATE DATABASE "wiki"
  WITH OWNER "postgres"
  ENCODING 'UTF8'; 
-- \c wiki 
CREATE TABLE url(
    id INT NOT NULL UNIQUE PRIMARY KEY,
    uri VARCHAR(2048) NOT NULL
);
CREATE TABLE keywords(
    term_id SERIAL PRIMARY KEY ,
    term VARCHAR(100) NOT NULL, 
    score NUMERIC(4,3) NOT NULL, 
    article_id INT NOT NULL, 
    CONSTRAINT fk_articleid FOREIGN KEY(article_id) REFERENCES url(id) 
);
