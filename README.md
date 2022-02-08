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

## THE TEAM

[Divyanshu Bisht](https://github.com/div1085) | [Farwa Ali](https://github.com/farwaali08) | [Sangeetha Praveen Kumar](https://github.com/praveen240881)


## TOOLS & RESOURCES

### SOFTWARE

![alt_text](https://user-images.githubusercontent.com/89050277/152583783-b1edaad9-3493-4fe4-babe-d024c32b8147.jpg)
  > L-R: Python 3.9.3 and relevant libraries, Jupyter Notebook, Google Colab, postgreSQL/pgAdmin, Bootstrap, Tableau, HTML, JS, CSS.
 


### PROJECT PIPELINE

![alt_text](https://user-images.githubusercontent.com/89050277/150654177-e4eac62d-9f36-4732-a4ad-493b5069a825.jpg)

> Above is a high-level view of the project. Information on each component can be found in the corresponding sub-headings below.
> Modified from [source](https://www.splunk.com/en_us/blog/it/sentiment-analysis-of-tweets-using-apache-pulsar.html).


### THE DATA

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

**Final Machine Learning Model**: [Machine Learning Model Final.ipynb](https://github.com/Group-5-Final-Project/Final-Project/blob/8633adfbf75052b94d49260305c50a9307da94c4/Machine%20Learning%20Model%20Final_With%20Plots.ipynb)

### Data Pre-processing

Prior to analysis, the tweet data was cleaned to remove any links, punctuation, emojis, or stop words. The cleaned tweets were then "Tokenized" using NLP, wherein the individual sentences were broken up into smaller units or words ("tokens") to remove unnecessary elements. The words were then returned to their base form using stemmatization, as shown in the illustration below.

Code: [Data Processing Using NLP.ipynb](https://github.com/Group-5-Final-Project/Final-Project/blob/3bde5c3d202d49d8e20387cc86883c0571978421/Data%20Processing%20Using%20NLP.ipynb)

![alt_text](https://raw.githubusercontent.com/jess-data/Twitter-2020-Sentiment-Analysis/master/twitter.jpg)


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

The processed dataframe was further split into features - data columns that were analysed, and the output, where the results of training set was used to assess the accuracy of the model.

Define features set as (X), and target array as (y).

`col = ['user_name','label','user_location']
tweets_new_df= tweets_new_nlp[col]
tweets_new_df.head()`

#### Train-Test splitting

`from sklearn.model_selection import train_test_split
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.2)
labels = ['Negative','Neutral', 'Positive']`  

<p align="center">
  <img src="https://user-images.githubusercontent.com/89050277/151807533-e30dcf11-8662-4249-ab77-f0b0daf32ce8.png" />
</p>


#### Defining the Target and Features

**Target:** is a tweet positive, negative, or neutral? (`sentiment`)

**Features:** the body of the tweet (`text`)

As the goal is to determine the sentiment of the tweet, `text` seems to be the obvious choice as the primary feature of the model. A [sample model](https://github.com/Group-5-Final-Project/Final-Project/blob/04a2eeaf3471619311dbb64b70d003edfd8efa02/ML_Model.ipynb) was created, however based on the results, it was apparent that further work is required to optimize the model. The code for the final model can be found [here](https://github.com/Group-5-Final-Project/Final-Project/blob/8633adfbf75052b94d49260305c50a9307da94c4/Machine%20Learning%20Model%20Final_With%20Plots.ipynb).

The addition of `CountVectorizer` tremendously improved the accuracy score of the model.

 
### Preparing the Model:
    
  1. The processed data will be used to train a MultinomialNB learning model.
    `from sklearn.naive_bayes import MultinomialNB`
    
  2. After training the model, the model predictions training dataset will be compiled as y_pred, and a confusion matrix will be created.
   
  3. The confusion matrix from sklearn.metrics will be used to compare the predicted vs actual results and provides useful insights for model evalaution. The accuracy score will provide a quantitative comparison between the actual and predicted and values.
   
  4. A classication report will be created using `imbalanced_classification_report` from imbalanced-learn. This will be used to evaluate the classification performed on the imbalanced dataset. As our dataset is also imbalanced, imbalanced classification report provide better insight in evaluating the model.
   
  5. The results will be visualized on a plot, where the predicted results are compared to the actual results.


**Algorithm:** ` Multinomial Naive-Bayes`: This algorithm finds the probabilities of classes assigned to texts by using the joint probabilities of words and classes. It has a fast learning rate and easy design, and works particularly well for text classification, especially with larger datasets. It does however assume that all predictors (or features) are independent, which is generally untrue, and limits its utility for many real-word scenarios, outside of text classification.  

**Input:** Tweet data from database

**Output Labels:** `Positive`, `Neutral`, `Negative`

### Accuracy Score & Confusion Matrices

Generally speaking, the [baseline sentiment accuracy rate](https://www.lexalytics.com/lexablog/sentiment-accuracy-baseline-testing) for this type of analysis is between 80-85%, and therefore, we set a target of `85%` accuracy for our model.

<p align="center">
  <img src="https://user-images.githubusercontent.com/89050277/152616702-61eb6669-1603-42a3-91fd-c8b53ecfed46.jpg"/>
</p>

The model’s actual accuracy score is `88.50`, meaning that it will accurately predict a tweet's sentiment `88.5%` of the time. As we are trying to gauge an approximate distribution of vaccine sentiments, and this exceeds the target, the accuracy score is sufficient for this type of analysis.

<p align="center">
   <img src= "https://user-images.githubusercontent.com/89050277/152700167-1d84d3bf-b437-426e-8264-2106151f1c43.jpg"/>
 </p>
 
Having a look at the classification report, it appears that although the overall precision and recall scores are sufficient, the least "precise" category appears to be `negative`, which may be related to tonality. This is indicative that this area may require further review or training, or perhaps a most robust training set. Another consideration would be to employ resampling techniques (such as SMOTE) to balance the dataset.

The confusion matrices below further highlight this point.

<p float="left">
 <img src="https://github.com/Group-5-Final-Project/Final-Project/blob/ead92a49acbadde321d179766a6e08b682b0f351/assets/img/portfolio/confusion_matrixA.png"/>
 <img src="https://github.com/Group-5-Final-Project/Final-Project/blob/ead92a49acbadde321d179766a6e08b682b0f351/assets/img/portfolio/confusion_matrixB.png"/>
 </p>
 
The matrices indicate higher accuracy in categorizing positive (93%) and neutral (88%) sentiments, however for the ‘negative’ class, the accuracy is only 77%, which again, may be due to the imbalanced dataset, as stated above. Despite the lower accuracy, overall, the model does satisfy its goal of predicting sentiments.

For future iterations, in addition to fitting the model with more features and applying resampling techniques, a [domain-specific dictionary](https://aclanthology.org/U11-1009.pdf) can be created and utilized in the training steps. Certain terms have significant meanings depending on the context and subject in which they are used, and so, including this level of detail may improve the accuracy of the model.

## RESULTS & ANALYSIS

The results of this analysis are displayed visually on our dashboard, linked below. A detailed analysis will be provided shortly.

![alt_text](https://user-images.githubusercontent.com/89050277/152702864-86d5dbc6-0050-4352-b33f-344cda7d4e7f.jpg)


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

Please refer to the [Google Slides](https://docs.google.com/presentation/d/1l5rIX7Nb_9dEN95sjcQNQWVZQ4opuhJLGZfmjViJZgA/present?slide=id.gc6f80d1ff_0_0) presentation, as well as the [deployed webpage](https://group-5-final-project.github.io/Final-Project/). We recommend an initial page-refresh for optimal viewing.


![alt_text](https://user-images.githubusercontent.com/89050277/152657897-683ecf50-37e4-4030-8164-5c8d41bd3400.jpg)


## NEXT STEPS

For future analyses, the following are recommended:

![alt_text](https://user-images.githubusercontent.com/89050277/152699976-3edd05c9-a3c8-495d-8490-b987483522e5.jpg)

1. **Location, Location, Location**: the present analysis would greatly benefit from location data in geo-coordinate format, OR if the scope of the analysis was changed from global to regional. The global response to the COVID-19 pandemic has varied from region to region, and knowing where the data (or tweets,) is coming from could provide necessary context or rationale. For example, policy changes, lockdowns, case counts, and the emergence of new variants will all impact sentiments towards vaccines. Given location data, it would be easier to link sentiments to these events. Unfortunately, our data did not include this parameter, and this will certainly be a consideration when selecting future datasets.

2. **Socials**: as a step further, it would be interesting to see how sentiments vary across different social media platforms (if at all). Generally speaking, each platform will have varying user demographics, which we anticipate will influence sentiments. Taking it another step further, a separate model could be created to predict the originating platform of a social media post based on the language and sentiment (e.g. this post was likely taken from Facebook/Meta).

3. **Emotion**: an emotional analysis of the tweets would also help provide better context to the results. As an example, differentiating negative tweets as negative-anger or negative-fear not only provide a more accurate classification, but can provide better insights into addressing these emotions as well. A tool that can be used to achieve this is the [NRC Sentiment and Emotion Lexicons](https://nrc.canada.ca/en/research-development/products-services/technical-advisory-services/sentiment-emotion-lexicons). 
