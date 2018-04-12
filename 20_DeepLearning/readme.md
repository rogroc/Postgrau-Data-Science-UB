# An introduction to Deep Learning

Neural Networks is a biologically inspired programming paradigm which enables a computer to learn from observational data. The origins of neural networks can be traced, at least, until 1949, when D.Hebb proposed a simple learning principle for neurons: 'fire together, wire together' . Later, in 1957, F.Rosenblatt invented the first learning machine: the perceptron. These simple models were further developed during more than 30 years until 1988, when the backpropagation algorithm  was proposed by Rumelhart et al. This algorithm was the first computational approach for training modern multilayer neural networks.   

In spite of the fact that the discovery of the backpropagation algorithm started a rich research field leading to interesting models such as convolutional neural networks or recurrent neural networks, its severe practical limitations at that time provoked after a few years what is known as the neural net winter, a period of reduced funding and interest in the field. The neural net winter ended in 2012, when a neural network called AlexNet competed in the ImageNet Large Scale Visual Recognition Challenge. The network achieved a top-5 error of 15.3%, more than 10.8 percentage points ahead of the runner up. These results, that where unexpectedly good, led to the current deep learning boom. 

Deep Learning is a powerful set of techniques (and tricks) for learning in neural networks with a high number of layers. Its notoriety builds upon the fact that it currently provides the best solutions to many problems in image recognition, speech recognition, and natural language processing, but at the same time some critics describe deep learning as a black box where data goes in and predictions come out without any kind of transparency. 

The black box criticism can be approached from many sides, such as discussing model explainability, predictability or transparency, but in this paper we will try to open the black box by explaining some of the inner workings of deep models. The success of deep learning does not stand on a brilliant formula neither in a set of heuristic rules implemented in code, but in a carefully assembled software machinery that uses in a very smart way several strategies from different fields, from the chain rule of Calculus to dynamic graph computation or efficient matrix multiplication. 

In a few words, this class tries to shed light on this cryptic but precise sentence: deep learning can be defined as a methodology to train large and highly complex models with deeply cascaded non-linearities by using automatic differentiation and several computational tricks. I hope that we will be able to fully appreciate what G.Hinton, one of the fathers of deep learning, said in a recent speech: 'All we have really discovered so far is that discriminative training using stochastic gradient descend works far better than any reasonable person would have expected'.  

## A note about our running environment

In order to run the notebooks, we will use Google Colab, Google’s free cloud service for AI developers. With Colab, you can develop deep learning applications on the GPU for free. You can use GPU as a backend for free for 12 hours at a time!

> Google colab FAQ: https://research.google.com/colaboratory/faq.html

For getting started:

+ You need to [signup](https://colab.research.google.com/) and apply for access before you start using google colab.
+ Once you get the access, you can upload notebooks using ``File->Upload Notebook``. 
+ To enable GPU backend for your notebook. ``Runtime->Change runtime type->Hardware Accelerator->GPU``.

## Contents
Learning from Data & Optimization: 
+ [Slides](https://github.com/DataScienceUB/Postgrau/blob/master/20_DeepLearning/DeepLearning%20Postgrau.pdf)
+ Code: <a href="https://drive.google.com/file/d/1FnjOezNLT3lOW-qaNQbzLV_9jZTLK7PF/view?usp=sharing"><img src="https://github.com/DataScienceUB/Postgrau/blob/master/20_DeepLearning/images/conotebook.png?raw=true" align="center" width="200" ></a>
Neural Networks: 
+ Code: <a href="https://drive.google.com/file/d/1QAFVyzqtrrFu8rsPy7s3ii7KHFloQVrV/view?usp=sharing"><img src="https://github.com/DataScienceUB/Postgrau/blob/master/20_DeepLearning/images/conotebook.png?raw=true" align="center" width="200" ></a>
