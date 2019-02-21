##  Detection of smiles in images of faces

This repository contains files related to the Springboard Data Science Career Track Capstone Project #1.

The project comprises the development of a model that detects the presence of smiles in cropped images of faces derived from the [Labeled Faces in the Wild (LFW) dataset](https://conradsanderson.id.au/lfwcrop/)

The project report can be viewed [here](https://github.com/adriatic13/springboard/blob/master/dsct_capstone1/Marinovich_Cap1_Final_Report.pdf).

Two smile/non-smile labeled datasets are used: a small set and a large set. As the [larger set](https://github.com/hromi/SMILEsmileD/tree/master/SMILEs) required modification of the smile classifications, as described in the report, it may be easiest to start with the smaller dataset, whose lists are obtained from:

  * https://data.mendeley.com/datasets/yz4v8tb3tp/5

The code was adapted (with thanks) from various sources:

   Plotting code from:

  * https://github.com/ageron/handson-ml/blob/master/07_ensemble_learning_and_random_forests.ipynb 

   DNN model code:

  * https://machinelearningmastery.com/tutorial-first-neural-network-python-keras/

   CNN model code from:

  * https://towardsdatascience.com/image-recognition-with-keras-convolutional-neural-networks-e2af10a10114

   CNN VGG-like model code from:

  * https://keras.io/getting-started/sequential-model-guide/

The notebooks should be run in the following order (noting that directory locations should be modified):

  * [Data wrangling](https://github.com/adriatic13/springboard/blob/master/dsct_capstone2/Adrian_Marinovich___Cap2L_data_wrangling190221_.ipynb)
  * [Feature extraction](https://github.com/adriatic13/springboard/blob/master/dsct_capstone2/Adrian_Marinovich___Cap2L_feature_extraction180221.ipynb)
  * [Modeling](https://github.com/adriatic13/springboard/blob/master/dsct_capstone2/Adrian_Marinovich___Cap2L_modeling190221.ipynb)
###### (Due to issues with GitHub rendering notebooks, you might need to view these notebooks by pasting link [here](https://nbviewer.jupyter.org/))
