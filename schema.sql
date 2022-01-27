CREATE TABLE tweets (
    user_name varchar,
    user_location varchar,
    date dt,
    text varchar,
    hashtags varchar,
    is_retweet boolean
    user_verified boolean
);

CREATE TABLE Tweets_Chart (
    date dt,
    label varchar,
    counts int
);

CREATE TABLE NLP_tweets (
    user_name varchar,
    date dt,
    text varchar,
    label varchar
);

********
OPTIONAL

ALTER TABLE tweets
DROP COLUMN IF EXISTS index;

ALTER TABLE tweets_chart 
DROP COLUMN IF EXISTS index;

ALTER TABLE NLP_tweets 
DROP COLUMN IF EXISTS index;

