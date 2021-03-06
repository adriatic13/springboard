##  Detection of smiles in face images

This repository contains files related to the Springboard Data Science Career Track Capstone Project #1.

The project comprises the development of models that detect the presence of smiles in cropped images of faces derived from the [Labeled Faces in the Wild (LFW) dataset](https://conradsanderson.id.au/lfwcrop/)

The project report can be viewed [here](https://github.com/adriatic13/springboard/blob/master/dsct_capstone1/Marinovich_Cap1_Final_Report.pdf).

Two smile/non-smile labeled datasets are used: a small set and a large set. As the [larger set](https://github.com/hromi/SMILEsmileD/tree/master/SMILEs) required modification of the smile classifications, as described in the report, it may be easiest to start with the smaller dataset, whose lists are obtained from:

  * https://data.mendeley.com/datasets/yz4v8tb3tp/5

The code was adapted (with thanks) from various sources:

Random forest and plotting:

  * https://github.com/ageron/handson-ml/blob/master/07_ensemble_learning_and_random_forests.ipynb 

DNN modeling:

  * https://machinelearningmastery.com/tutorial-first-neural-network-python-keras/

CNN modeling:

  * https://towardsdatascience.com/image-recognition-with-keras-convolutional-neural-networks-e2af10a10114

CNN VGG-like modeling:

  * https://keras.io/getting-started/sequential-model-guide/

The notebooks should be run in the following order (noting that directory locations should be modified):

  * [Data wrangling](https://github.com/adriatic13/springboard/blob/master/dsct_capstone1/Adrian_Marinovich_Cap1_smiles_data_wrangling.ipynb)
  * [Initial modeling](https://github.com/adriatic13/springboard/blob/master/dsct_capstone1/Adrian_Marinovich_Cap1_smiles_eda.ipynb)
  * [In-depth modeling](https://github.com/adriatic13/springboard/blob/master/dsct_capstone1/Adrian_Marinovich_Cap1_smiles_indepth.ipynb)
###### (Due to issues with GitHub rendering Jupyter notebooks, you might need to view notebooks by pasting their link [here](https://nbviewer.jupyter.org/))

