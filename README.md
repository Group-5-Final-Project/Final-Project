# Vaccine Sentiment Analysis 💉

## PROJECT OVERVIEW

The emergence of the Coronavirus pandemic has normalized vaccines to become a part of everyday discourse, as global efforts to increase vaccination rates continue. Considered to have an integral role in managing the pandemic, governments, employers, and other organizations have either implemented or considered vaccine mandates, and this has possibly become the most contentious topic in the last couple of years.

As expected, there are varying opinions about vaccines, which range from their safety or effectiveness, to whether the mandates infringe on human rights. Anti-vaxx sentiments well predate COVID, however given how pervasive vaccine discourse has become, they seem to be on the rise. Understanding the causes and levels of vaccine hesitance is an important first step in addressing the factors that prevent people from getting vaccinated.

For this project, we took to Twitter to gather vaccine sentiments from the beginning of the pandemic to present, in an effort to address the following questions:

* What are the sentiments towards vaccines?
  * Positive, negative, or neutral
* How have these sentiments changed throughout the course of the pandemic, if at all?
  * Do pandemic milestones (e.g. waves, mandates, laws, etc.) impact opinions? 
* What word associations are found with the word vaccine?

Data extracted from Twitter will be stored in a Postgres database, analyzed using Natural Language Processing (NLP), and the findings will be visualized on a custom dashboard.

## THE TEAM

[Divyanshu Bisht](https://github.com/div1085) | [Farwa Ali](https://github.com/farwaali08) | [Sangeetha Praveen Kumar](https://github.com/praveen240881)

The team members have not been assigned specific 'circle', 'square', or 'triangle' roles. All members are working collaboratively on each task, and each member has their own branch. The team communicates primarily through Slack, but also meet at least once a week via Zoom.

## TOOLS & RESOURCES

### SOFTWARE

* Python 3.9.3
  * Libraries & packages: Tweepy, SQLAlchemy, scikit-learn, NLTK, matplotlib
* Jupyter Notebook or Google Colab
* PostgreSQL 
* pdAdmin
* HTML/CSS
* D3
* Tableau

### THE DATA

**:new: UPDATE :new:**

Due to Twitter API limitations, and in order to continue with this project, we decided to combine existing Kaggle datasets and proceed with the analysis. Links to the datasets are provided below:

[Data Set 1](https://www.kaggle.com/gpreda/all-covid19-vaccines-tweets?select=vaccination_all_tweets.csv)

[Data Set 2](https://www.kaggle.com/kaushiksuresh147/covidvaccine-tweets)

Fortunately, both datasets were formatted similarly, and combined, contain over `400,000` usable entries that span from March 2020 to January 2022. Still, the data required a bit of cleaning to remove duplicates. The details and code can be found here: [Twitter Data.ipynb](https://github.com/Group-5-Final-Project/Final-Project/blob/602bb543cc603b79eb2f4a06d4dd8a82b9bcb2ab/Twitter%20Data.ipynb)


:x::x::x::x::x:

Data will be extracted using the [Twitter API](https://developer.twitter.com/en), which pulls "Twitter Objects" containing the text of a tweet. We will be focusing on tweets that contain the word **vaccine** from the start of the pandemic (around March 2020) to present.

:x::x::x::x::x:

[Tweet Data](https://developer.twitter.com/en/docs/twitter-api/v1/data-dictionary/object-model/tweet)

![alt_text](https://user-images.githubusercontent.com/89050277/149606858-8295d3f2-ab25-45bc-bf8e-df773f423473.jpg)
 
 > The Twitter API provides Tweet data in JSON format, as seen above. The data will be parsed and transformed prior to analysis using Python. The key to this analysis is the `text` feature, particularly for the machine learning component. We will also be using other features such as the `created_at` for other components of this analysis.


### PROJECT PIPELINE

:new:

![alt_text](https://user-images.githubusercontent.com/89050277/150654177-e4eac62d-9f36-4732-a4ad-493b5069a825.jpg)

> Above is a high-level view of the project. Information on each component can be found in the corresponding sub-headings below.
> Modified from [source](https://www.splunk.com/en_us/blog/it/sentiment-analysis-of-tweets-using-apache-pulsar.html).
 

## MACHINE LEARNING MODEL

```X = []
Y = []
for idx in data.index:
  X.append(text_preprocess(data['text'][idx], tknzr))
  Y.append(data['categorical_label'][idx])```
  
### Train-Test splitting

```from sklearn.model_selection import train_test_split
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.3)
labels = ['Negative','Neutral', 'Positive']
```

**Algorithm:** `Naive-Bayes`

**Input:** Tweet data from database

**Output Labels:** `Positive`, `Neutral`, `Negative`

Above is a sample of the code that will be used for the machine learning model. 

## DATABASE

For the database portion of this project, we chose postgreSQL to store both the raw and processed datasets. The raw data from [Twitter Data.ipynb](https://github.com/Group-5-Final-Project/Final-Project/blob/602bb543cc603b79eb2f4a06d4dd8a82b9bcb2ab/Twitter%20Data.ipynb) is saved in the "Tweets" table. The processed data is then saved into NLP_tweets, and tweets_chart, to be used for visualizations and the machine learning model.

![alt_text](https://user-images.githubusercontent.com/89050277/150657291-0e4b36b8-48e9-4b76-a39c-f7217b250405.jpg)


## DASHBOARD

![alt_text](https://user-images.githubusercontent.com/89050277/149342404-364b67d3-54ff-4646-af82-28fee2670027.jpg)
