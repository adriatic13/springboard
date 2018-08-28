# Import packages
# (For missing packages <--->, as needed, write in terminal: )
# pip install <---> 

import numpy
import pandas

#import requests
from keras.models import Sequential
from keras.layers import Dense
from keras.wrappers.scikit_learn import KerasClassifier
from keras.utils import np_utils
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import KFold
from sklearn.preprocessing import LabelEncoder
from sklearn.pipeline import Pipeline

# Import iris dataset
# TO DO: add column names and index
url = "http://archive.ics.uci.edu/ml/machine-learning-databases/iris/bezdekIris.data"
iris = pandas.read_csv(url, sep=',', header=None)
iris.to_csv('iris.csv')
iris.shape
#r = requests.get(url)
#text = r.text
#print(text)

# Split columns into input (X) and output (Y) variables
# See:
#   https://machinelearningmastery.com/multi-class-classification-tutorial-keras-deep-learning-library/
iris_set = iris.values
X = iris_set[:,0:4].astype(float)
Y = iris_set[:,4]

# Initializing random number generator, with fixed random seed to allow reproducibility
seed = 7
numpy.random.seed(seed)

# Dummy, or one-hot encoding of output variable
# encode class values as integers
encoder = LabelEncoder()
encoder.fit(Y)
encoded_Y = encoder.transform(Y)
# convert integers to dummy variables (i.e. one-hot encoded)
dummy_y = np_utils.to_categorical(encoded_Y)

# Defining baseline model:
#  4 inputs -> [8 hidden nodes] -> 3 outputs
#  The “softmax” activation function in the output layer,
#   to ensure the output values are in the range of 0 and 1 and 
#   may be used as predicted probabilities.
#  The the network uses the efficient Adam gradient descent 
#   optimization algorithm with a logarithmic loss function, 
#   which is called “categorical_crossentropy” in Keras.

def baseline_model():
    # create model
    model = Sequential()
    model.add(Dense(8, input_dim=4, activation='relu'))
    model.add(Dense(3, activation='softmax'))
    # Compile model
    model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])
    return model

# Create the KerasClassifier to use in scikit-learn: 
#  We pass arguments in the construction of the KerasClassifier 
#   class that will be passed on to the fit() function internally 
#   used to train the neural network. Here, we pass the number of 
#   epochs (full dataset training rounds) as 200 and batch size 
#   (number of training examples present in a single batch) as 5 
#   to use when training the model. (Iterations = number of batches
#   in one dataset. Debugging is also turned off when training 
#   by setting verbose to 0.
# See:
#  https://towardsdatascience.com/epoch-vs-iterations-vs-batch-size-4dfb9c7ce9c9

estimator = KerasClassifier(build_fn=baseline_model, epochs=200, batch_size=5, verbose=0)

# k-fold cross validation:
#  (gold standard for evaluating machine learning models)

kfold = KFold(n_splits=10, shuffle=True, random_state=seed)

# Evaluate the model (estimator, via KerasClassifier) on dataset
#  (X and dummy_y) using a 10-fold cross-validation procedure 
#  (kfold). Evaluating the model returns an object that describes 
#  the evaluation of the 10 constructed models for each of the 
#  splits of the dataset.
# See:
#  https://machinelearningmastery.com/multi-class-classification-tutorial-keras-deep-learning-library/

results = cross_val_score(estimator, X, dummy_y, cv=kfold)
print("Baseline: %.2f%% (%.2f%%)" % (results.mean()*100, results.std()*100))
