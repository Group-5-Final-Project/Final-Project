
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
-- 1 create tweets table
CREATE TABLE tweets (
    user_name varchar,
    date date,
    text varchar,
    hashtags varchar,
    is_retweet boolean,
    user_verified boolean
);
-- 2 create tweets_chart table
CREATE TABLE Tweets_Chart (
    date date,
    label varchar,
    counts int
);
-- 3
CREATE TABLE NLP_tweets (
    user_name varchar,
    date date,
    text varchar,
    label varchar
);

ALTER TABLE tweets
DROP COLUMN IF EXISTS index;

ALTER TABLE tweets_chart 
DROP COLUMN IF EXISTS index;

ALTER TABLE NLP_tweets 
DROP COLUMN IF EXISTS index;