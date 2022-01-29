CREATE TABLE tweets (
    user_name varchar,
    user_location varchar,
    date timestamp,
    text varchar,
    hashtags varchar,
    is_retweet boolean
    user_verified boolean
);

CREATE TABLE Tweets_Chart (
    date timestamp,
    label varchar,
    counts int
);

CREATE TABLE NLP_tweets (
    user_name varchar,
    date timestamp,
    text varchar,
    label varchar
);

CREATE TABLE encoded_data (
    text text,
    label bigint, 
);

-----------------
-- OTHER OPERATIONS THAT WERE PERFORMED

ALTER TABLE tweets
DROP COLUMN IF EXISTS index;

ALTER TABLE tweets_chart 
DROP COLUMN IF EXISTS index;

ALTER TABLE NLP_tweets 
DROP COLUMN IF EXISTS index;

ALTER TABLE "encoded_data"
DROP COLUMN IF EXISTS index;

ALTER TABLE "NLP_tweets"
RENAME COLUMN label to sentiment;

-----------------
-- JOINING "NLP_tweets" & "encoded_data" to create "complete_sentiment" 

SELECT npt.date, npt.text, npt.sentiment, ed.label
INTO complete_sentiment
FROM "NLP_tweets" as npt
LEFT JOIN "encoded_data" as ed
ON npt.text = ed.text;

