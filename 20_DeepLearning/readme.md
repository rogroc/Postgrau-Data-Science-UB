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

<a href="https://drive.google.com/file/d/1FnjOezNLT3lOW-qaNQbzLV_9jZTLK7PF/view?usp=sharing"><img src="https://github.com/DataScienceUB/Postgrau/blob/master/20_DeepLearning/images/conotebook.png?raw=true" align="left" width="200" ></a>

## Learning from data

In general, Learning from Data is a scientific discipline that is concerned with the design and development of algorithms that allow computers to infer, from data, a model that allows a compact representation of raw data and/or good generalization abilities. In the former case we are talking about non supervised learning. In the later, supervised learning. 

This is nowadays an important technology because it enables computational systems to improve their performance with experience accumulated from the observed data in real world scenarios.

Neural nets are a specific method for learning from data, a method that is based on a very simple element, the neuron unit. A neuron unit is a mathematical function of this kind:

f({\mathbf x}, \mathbf{w}, b) = \sigma(\mathbf{w}^T \cdot {\mathbf x} + b)

where {\mathbf x} represents an input element in vector form, \mathbf{w} is a vector of weights,  \sigma is a non-linear function and b a scalar value. (\mathbf{w},b) are called the parameters of the function. The output of this function is called the activation of the neuron. 

Regarding the non-linear function, historically the most common one was the Sigmoid function, but nowadays there are several alternatives that are supposed to be better suited to learning from data, such as ReLU and variants.

Simple neurons can be organized in larger structures by applying to the same data vector different sets of weights, forming what is called a layer, and by stacking layers one on top of the output of the other.  It is important to notice that a multilayer neural network can be seen as a composition of matrix products (matrices represent weights) and non-linear function activations. For the case of a 2-layer network the outcome is:

 {\mathbf y} = {\mathbf \sigma}\Big( W^1  {\mathbf \sigma}\Big( W^0  {\mathbf x} + {\mathbf b}^0 \Big) + {\mathbf b}^1 \Big)

where {\mathbf \sigma} represents a vectorial version of the sigmoid function and W^i are the weights of each layer in matrix form.  

What is interesting about this kind of structures is that it has been showed that even a neural network with a single hidden layer containing a finite number of neurons can approximate any continuous function of \mathbf{R}^n. This fact makes neural networks a sound candidate to implement learning from data methods. The question is then: how to find the optimal parameters, {\mathbf w} = (W^i,{\mathbf b}), to approximate a function that is implicitly defined by a set of samples \{({\mathbf x}_1, {\mathbf y}_1), \dots,  ({\mathbf x}_n, {\mathbf y}_n)\}?

From a technical point of view, not only neural networks but most of the algorithms that have been proposed to infer models from large data sets are based on the iterative solution of a mathematical problem that involves data and a mathematical model. If there was an analytic solution to the problem, this should be the adopted one, but this is not the case for most of the cases. The techniques that have been designed to tackle these problems are grouped under a field that is called optimization. The most important technique for solving optimization problems is gradient descend.

