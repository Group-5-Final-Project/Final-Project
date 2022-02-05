# Final-Project
# Vaccine Sentiment Analysis 💉

## PROJECT OVERVIEW

The emergence of the Coronavirus pandemic has normalized vaccines to become a part of everyday discourse, as global efforts to increase vaccination rates continue. Considered to have an integral role in managing the pandemic, governments, employers, and other organizations have either implemented or considered vaccine mandates, and this has possibly become the most contentious topic in the last couple of years.

As expected, there are varying opinions about vaccines, which range from their safety or effectiveness, to whether the mandates infringe on human rights. Anti-vaxx sentiments well-predate COVID, however given how pervasive vaccine discourse has become, they seem to be on the rise. Understanding the causes and levels of vaccine hesitance is an important first step in addressing the factors that prevent people from getting vaccinated.

For this project, we took to Twitter to gather vaccine sentiments from the beginning of the pandemic to present, in an effort to address the following questions:

* What are the sentiments towards vaccines?
  * Positive, negative, or neutral
* How have these sentiments changed throughout the course of the pandemic, if at all?
  * Do pandemic milestones (e.g. waves, mandates, laws, etc.) impact opinions? 
* What word associations are found with the word vaccine?
* Are we really as divided on vaccines as it seems?

Data extracted from Twitter will be stored in a Postgres database, analyzed using Natural Language Processing (NLP), and the findings will be visualized on a custom dashboard.

## Problem Statement
The project is to question what is the Public's perception and acceptance of the Vaccine programs. If there are any doubts exists, what are the reasons to being doubtful. To answer this question we used Supervised learning to classify the sentiments of the tweets and to understand the reason behind being doubtful.

## THE TEAM

[Divyanshu Bisht](https://github.com/div1085) | [Farwa Ali](https://github.com/farwaali08) | [Sangeetha Praveen Kumar](https://github.com/praveen240881)

The team members have not been assigned specific 'circle', 'square', or 'triangle' roles. All members are working collaboratively on each task, and each member has their own branch. The team communicates primarily through Slack, but also meet at least once a week via Zoom.

## TOOLS & RESOURCES

### SOFTWARE

* Python 3.9.3
  * Libraries & packages: Tweepy, SQLAlchemy, NLTK
* Jupyter Notebook or Google Colab
* PostgreSQL 
* pdAdmin

<sup>*</sup>*Dashboard software TBD*
 

### PROJECT PIPELINE

:new:

![alt_text](https://user-images.githubusercontent.com/89050277/150654177-e4eac62d-9f36-4732-a4ad-493b5069a825.jpg)

> Above is a high-level view of the project. Information on each component can be found in the corresponding sub-headings below.
> Modified from [source](https://www.splunk.com/en_us/blog/it/sentiment-analysis-of-tweets-using-apache-pulsar.html).


### THE DATA

:new: **UPDATE** 

Due to Twitter API limitations, and in order to continue with this project, we decided to combine existing Kaggle datasets and proceed with the analysis. Links to the datasets are provided below:

[Data Set 1](https://www.kaggle.com/gpreda/all-covid19-vaccines-tweets?select=vaccination_all_tweets.csv) | [Data Set 2](https://www.kaggle.com/kaushiksuresh147/covidvaccine-tweets)

Fortunately, both datasets were formatted similarly, and combined, contain over `400,000` usable entries that span from March 2020 to January 2022. Still, the data required a bit of cleaning to remove duplicates and redundancies. The tweets from these datasets are taken from the start of the pandemic (around March 2020) to present, and all contain the word `vaccine`. Below is a summary of how the data was processed for analysis (in Jupyter Notebook or Google Colab, using Python):

1. Both CSVs were imported as dataframes (DFs)
2. Unnecessary columns were dropped, so both DFs had identical structures  
3. Validated that there were no "null" values in the `text`column
4. DFs were concatenated to create a single DF
5. Duplicate tweets were dropped
6. Blank rows in the `user_location` column were dropped
7. The `date` column was converted to datetime
8. The new DF was converted to a CSV file AND exported/stored in a postgres database

The details and code can be found here: [Twitter Data.ipynb](https://github.com/Group-5-Final-Project/Final-Project/blob/64dac68ad1fa2f064f81b6050a1aceaaf959845e/Twitter%20Data.ipynb)

Below is an example of the data made available by the Twitter API:

![alt_text](https://user-images.githubusercontent.com/89050277/149606858-8295d3f2-ab25-45bc-bf8e-df773f423473.jpg)
 
 > The Twitter API provides Tweet data in JSON format, as seen above. The data was parsed and transformed prior to analysis using Python. The key to this analysis is the `text` feature, particularly for the machine learning component. We will also be using other features such as the `created_at` for other components of this analysis.
 

## MACHINE LEARNING MODEL

### Data Pre-processing

Prior to analysis, the tweet data was cleaned to remove any links, punctuation, emojis, or stop words. The cleaned tweets were then "Tokenized" using NLP, wherein the individual sentences were broken up into smaller units or words ("tokens") to remove unnecessary elements. The words were then returned to their base form using lemmatization



### CountVectorizer

`CountVectorizer` is a tool provided by the scikit-learn library in Python. It is used to transform a given text into a vector on the basis of the frequency (count) of each word that occurs in the entire text. The value of each cell is nothing but the count of the word in that particular text sample. Essentially, it builds a vocabulary of known words, and allows new documents to be encoded using that vocabulary. The encoded vectors can then be used directly with a machine learning algorithm.


### Sentiment Analysis

`SentimentIntensityAnalyzer` from NLTK was used to complete the sentiment analysis. The data was assigned a polarity values of `-1.0`, `0.0`, or `1.0`, and based on this ranking, then given a a label of `Negative`, `Neutral`, or `Positive`. 

`Negative` < 0.0

`Neutral` = 1.0

`Positive` > 0.0

### Label Encoding

`LabelEncoder()` was used to convert sentiment labels into a numeric, machine-readable form. 


### Splitting the Data into Training and Testing: 

The processed dataframe will be further split into features - data columns that will be analysed, and the output, where the results of training set will be used to assess the accuracy of the model.

Define features set as (X), and target array as (y).

`col = ['user_name','label','user_location']
tweets_new_df= tweets_new_nlp[col]
tweets_new_df.head()`

#### Train-Test splitting

`from sklearn.model_selection import train_test_split
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.2)
labels = ['Negative','Neutral', 'Positive']`  


#### Defining the Target and Features

**Target:** is a tweet positive, negative, or neutral? (`sentiment`)

**Features:** the body of the tweet (`text`)

As the goal is to determine the sentiment of the tweet, `text` seems to be the obvious choice as the primary feature of the model. A [sample model](https://github.com/Group-5-Final-Project/Final-Project/blob/04a2eeaf3471619311dbb64b70d003edfd8efa02/ML_Model.ipynb) was created, however based on the results, it was apparent that further work is required to optimize the model. A rough draft of the code can be found [here](https://github.com/Group-5-Final-Project/Final-Project/blob/8467b47228c242c32ab899568c597ca26c805ff3/Supervised%20Machine%20Learning%20Model.ipynb).

 
### Preparing the Model:
    
  1. The processed data will be used to train a MultinomialNB learning model.
    `from sklearn.naive_bayes import MultinomialNB`
    
  2. After training the model, the model predictions training dataset will be compiled as y_pred, and a confusion matrix will be created.
   
  3. The confusion matrix from sklearn.metrics will be used to compare the predicted vs actual results and provides useful insights for model evalaution. The accuracy score will provide a quantitative comparison between the actual and predicted and values.
   
  4. A classication report will be created using `imbalanced_classification_report` from imbalanced-learn. This will be used to evaluate the classification performed on the imbalanced dataset. As our dataset is also imbalanced, imbalanced classification report provide better insight in evaluating the model.
   
  5. The results will be visualized on a plot, where the predicted results are compared to the actual results.


**Algorithm:** ` Multinomial Naive-Bayes` This algorithm has a fast learning rate and easy design, and works particularly well for text classification, especially with larger datasets. It does however assume that all predictors (or features) are independent, which is generally untrue, and limits its utility for many real-word scenarios, outside of text classification.

**Input:** Tweet data from database

**Output Labels:** `Positive`, `Neutral`, `Negative`

## Current Accuracy Score

By applying the machine learning model  that focusses on the perspective rather than the social perspective by analyzing the setting over unigram feature set along with dataset evaluation of multiple machine learning modesl we have achieved an accurracy score of **80.05%** in detecting the actual sentiments behind a tweet related to the Vaccinations.

## Explanation of model choice, including limitations and benefits

1. Naive Bayes classifier is a collection of many algorithms where all the algorithms share one common principle, and that is each feature being classified is not related to any other feature. The algorithm is based on the Bayes theorem and predicts the tag of a text such as a piece of email or newspaper article. It calculates the probability of each tag for a given sample and then gives the tag with the highest probability as output. The multinomial Naive Bayes classifier is suitable for classification with discrete features (e.g., word counts for text classification).Multinomial Naive Bayes algorithm is a probabilistic learning method that is mostly used in Natural Language Processing (NLP).

2. Multinomial Naive Bayes classification algorithm tends to be a baseline solution for sentiment analysis task. The basic idea of Naive Bayes technique is to find the probabilities of classes assigned to texts by using the joint probabilities of words and classes.

3. Naive Bayes algorithm is only used for textual data classification and cannot be used to predict numeric values. The result of naive bayes model provide statistical sense by predicting how often that certain words with the sentimental labels appear, which does not necessarily indicate the factual attitudes/sentiments towards covid vaccine, and it does not work with regression because it is not numerical data. One of the benefits of Naive Bayes is that if its assumption of the independence of features holds true, it can perform better than other models and requires much less training data.


## DATABASE

For the database portion of this project, we chose postgreSQL to store both the raw and processed datasets. The raw data from [Twitter Data.ipynb](https://github.com/Group-5-Final-Project/Final-Project/blob/64dac68ad1fa2f064f81b6050a1aceaaf959845e/Twitter%20Data.ipynb) is saved in the `Tweets` table. The processed data is then saved into `NLP_tweets`, and `tweets_chart`, to be used for visualizations and the machine learning model.

During the machine learning stage, a new table, `encoded_data` was created to assign numerical values to each sentiment. This table was joined with `NLP_tweets` to create a new table, `complete_sentiment`. Please refer to [schema.sql](https://github.com/Group-5-Final-Project/Final-Project/blob/c5808e3c5d6ae66e9610cad2e91dee60ae825a2e/schema.sql) for more information, and click [here](https://github.com/Group-5-Final-Project/Final-Project/blob/154ebc444cb5272832782b19d940a4cb27d27541/Miscellaneous/complete_sentiment.jpg) for a look at the `complete_sentiment` table.

![alt_text](https://user-images.githubusercontent.com/89050277/151637863-b868b6c8-639c-4222-8a5e-9340d50f9724.jpg)



| **Data**      |**Description**|
| ------------- | ------------- |
| **user_name**     | The username of the Twitter account where the tweet originated |
| **user_location** | The location of the user|
| **date**          | The date the tweet was created  |
| **text**          | The body or text of the tweet |
| **hashtags**      | Any hashtags included with the tweet  |
| **is_retweet**    | If the tweet is a retweet  |
| **label**         | The numerical value assigned to each sentiment  |
| **sentiment**     | If the tweet is positive, neutral, or negative, as classified by the model  |
| **counts**        | The count of positive, negative, and neutral tweets  |
| **user_verified** | If the user has a verified account  |


## DASHBOARD

A link for the presentation can be found [here](https://docs.google.com/presentation/d/1l5rIX7Nb_9dEN95sjcQNQWVZQ4opuhJLGZfmjViJZgA/present?slide=id.gc6f80d1ff_0_0).

Below is a layout of the dashboard, including a summary of the technologies that will be used. The webpage will be deployed on a local machine or on Github pages. the dashboard will include figures, interactive graphs, and a tweet map, along with information about the machine learning model.

![alt_text](https://user-images.githubusercontent.com/89050277/151417481-011b92dd-9aed-43ce-9428-57374581c151.jpg)

