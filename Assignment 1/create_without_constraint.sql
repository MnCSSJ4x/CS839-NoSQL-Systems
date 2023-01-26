CREATE TABLE url(
    id INT NOT NULL UNIQUE ,
    uri VARCHAR(250) NOT NULL
);
CREATE TABLE keywords(
    term_id SERIAL  ,
    term VARCHAR(100) NOT NULL, 
    article_id INT NOT NULL, 

);
