# Final-Project

X = []
Y = []
for idx in data.index:
  X.append(text_preprocess(data['text'][idx], tknzr))
  Y.append(data['categorical_label'][idx])
  
# Train-Test splitting
from sklearn.model_selection import train_test_split
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.3)
labels = ['Negative','Neutral', 'Positive']
