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

## How to learn from data?

In general, *Learning from Data* is a scientific discipline that is concerned with the design and development of algorithms that allow computers to infer, from data, a model that allows a compact representation of raw data and/or good generalization abilities. In the former case we are talking about non supervised learning. In the later, supervised learning. 

This is nowadays an important technology because it enables computational systems to improve their performance with experience accumulated from the observed data in real world scenarios.

Neural nets are a specific method for learning from data, a method that is based on a very simple element, the *neuron unit*. A neuron unit is a mathematical function of this kind:

$f({\mathbf x}, \mathbf{w}, b) = \sigma(\mathbf{w}^T \cdot {\mathbf x} + b)$


where ${\mathbf x}$ represents an input element in vector form, $\mathbf{w}$ is a vector of weights,  $\sigma$ is a non-linear function and $b$ a scalar value. $(\mathbf{w},b)$ are called the parameters of the function. The output of this function is called the *activation* of the neuron. 

Regarding the non-linear function, historically the most common one was the Sigmoid function, but nowadays there are several alternatives that are supposed to be better suited to learning from data, such as ReLU and variants.

Simple neurons can be organized in larger structures by applying to the same data vector different sets of weights, forming what is called a *layer*, and by stacking layers one on top of the output of the other.  It is important to notice that a multilayer neural network can be seen as a composition of matrix products (matrices represent weights) and non-linear function activations. For the case of a 2-layer network the outcome is:

$ {\mathbf y} = {\mathbf \sigma}\Big( W^1  {\mathbf \sigma}\Big( W^0  {\mathbf x} + {\mathbf b}^0 \Big) + {\mathbf b}^1 \Big)$

where ${\mathbf \sigma}$ represents a vectorial version of the sigmoid function and $W^i$ are the weights of each layer in matrix form.  

What is interesting about this kind of structures is that it has been showed that even a neural network with a single hidden layer containing a finite number of neurons can approximate any continuous function of $\mathbf{R}^n$. This fact makes neural networks a sound candidate to implement learning from data methods. The question is then: how to find the optimal parameters, ${\mathbf w} = (W^i,{\mathbf b})$, to approximate a function that is implicitly defined by a set of samples $\{({\mathbf x}_1, {\mathbf y}_1), \dots,  ({\mathbf x}_n, {\mathbf y}_n)\}$?

From a technical point of view, not only neural networks but most of the algorithms that have been proposed to infer models from large data sets are based on the iterative solution of a mathematical problem that involves data and a mathematical model. If there was an analytic solution to the problem, this should be the adopted one, but this is not the case for most of the cases. The techniques that have been designed to tackle these problems are grouped under a field that is called optimization. The most important technique for solving optimization problems is *gradient descend*.

## Learning from data

Let's consider the supervised learning problem from an optimization point of view. When learning a model from data the most common scenario is composed of the following elements:

+ A dataset $(\mathbf{x},y)$ of $n$ examples. For example, $(\mathbf{x},y)$ can represent:

  + $\mathbf{x}$: the behavior of a game player; $y$: monthly payments.
  + $\mathbf{x}$: sensor data about your car engine; $y$: probability of engine error.
  + $\mathbf{x}$: financial data of a bank customer; $y$: customer rating.

  If $y$ is a real value, the problem we are trying to solve is called a *regression* problem. If $y$ is binary or categorical, it is called a *classification* problem.

+ A target function $f_{(\mathbf{x},y)}(\mathbf{w})$, that we want to minimize, representing the discrepancy between our data and the model we want to fit.

+ A model $M$ that is represented by a set of parameters $\mathbf{w}$.

+ The gradient of the target function, $\nabla {f_{(\mathbf{x},y)}(\mathbf{w})}$ with respect to model parameters.

In the case of regression $f_{(\mathbf{x},y)}(\mathbf{w})$ represents the errors from a data representation model $M$. Fitting a model can be defined as finding the optimal parameters $\mathbf{w}$ that minimize the following expression:

$f_{(\mathbf{x},y)}(\mathbf{w}) = \frac{1}{n} \sum_{i} (y_i - M(\mathbf{x}_i,\mathbf{w}))^2$

Alternative regression and classification problems can be defined by considering different formulations to measure the errors from a data representation model. These formulations are known as the *Loss Function* of the problem. 

##Gradient descend

Let's suppose that we have a function $f(w): \mathbf{R} \rightarrow \mathbf{R}$ and that our objective is to find the argument  $w$ that minimizes this function (for maximization, consider $-f(w)$). To this end, the critical concept is the *derivative*.

The derivative of $f$ of a variable $w$, $f'(w)$ or $\frac{\mathrm{d}f}{\mathrm{d}w}$,  is a measure of the rate at which the value of the function changes with respect to the change of the variable. It is defined as the following limit:


$$ f'(w) = \lim_{h \rightarrow 0} \frac{f(w + h) - f(w)}{h} $$

The derivative specifies how to scale a small change in the input in order to obtain the corresponding change in the output. Knowing the value of $f(w)$ at a point $w$, this allows to predict the value of the function in a neighboring point:

$$ f(w + h) \approx f(w) + h f'(w)$$

Then, by following these steps we can decrease the value of the function:

+ Start from a random $w^0$ value.
+ Compute the derivative $f'(w) = \lim_{h \rightarrow 0} \frac{f(w + h) - f(w)}{h}$.
+ Walk small steps in the opposite direction of the derivative, $w^{i+1} = w^i - h f'(w^i)$, because we know that $f(w - h f'(w))$ is less than $f(w)$ for  small enough $h$, until $ f'(w) \approx 0$.

The search for the minima ends when the derivative is zero because we have no more information about which direction to move. $w$ is called a critical or stationary point of $f(w)$ if $f'(w)=0$. 

All extrema points (maxima/minima) are critical points because $f(w)$ is lower/higher than at all neighboring points. But these are not the only critical points: there is a third class of critical points called *saddle points*. Saddle points are points that have partial derivatives equal to zero but at which the function has neither a maximum nor a minimum value.

If $f$ is a *convex function*, when the derivative is zero this should be the extremum of our function. In other cases it could be a local minimum/maximum or a saddle point.

The recipe we have proposed to find the minima of a function is based on the numerical computation of derivatives. There are two problems with the computation of derivatives by using numerical methods:

* It is approximate: it depends on a parameter $h$ that cannot be tuned in advance to get a given precision.
* It is very slow to evaluate: there are two function evaluations at each step: $f(w + h) , f(w)$. If we need to evaluate complex functions, involving millions of parameters, a lot of times, this problem becomes a real obstacle.

The classical solution to this problem is the use the of the analytic derivative $f'(w)$, which involves only one function evaluation, but this solution is only feasible to those problems where $f'(w)$ can be analytically derived. 

## From derivatives to gradient

Let's now consider a $n$-dimensional function $f(\mathbf{w}): \mathbf{R}^n \rightarrow \mathbf{R}$. For example: 

$$f(\mathbf{w}) = \sum_{i=1}^n w_i^2$$

As in the previous section, our objective is to find the argument  $\mathbf{w}$ that minimizes this function.

The *gradient* of $f$ is the vector whose components are the $n$ partial derivatives of $f$. 

$$\nabla {f} = \Big(\frac{\partial f}{\partial w_1}, \dots, \frac{\partial f}{\partial w_n} \Big)$$

It is thus a vector-valued function. The gradient is an interesting function because it plays the same role as the derivative in the case of scalar functions: it can be shown that it points in the direction of the greatest rate of increase of the function. Then, we can follow this steps to minimize the function:

+ Start from a random $\mathbf{w}$ vector.
+ Compute the gradient vector $\nabla {f}$.
+ Walk small steps in the opposite direction of the gradient vector.

It is important to be aware that this gradient computation is very expensive when using numerical derivatives: if $\mathbf{w}$ has dimension $n$, we have to evaluate $f$ at $2*n$ points.

### Stochastic Gradient Descend

Taking for granted that we will apply an iterative method to minimize a loss function  at every step, we must consider the cost of this strategy. The inspection of Equation (\ref{loss}) shows that we must  
evaluate the discrepancy between the prediction of our model and a data element for the whole dataset $(\mathbf{x}_i,y_i)$ at every optimization step.  If the dataset is large, this strategy is too costly. In this case we will use a strategy called *Stochastic Gradient Descend* (SGD).

Stochastic Gradient Descend  is based on the fact that the cost function is additive: it is computed by adding single discrepancy terms between data samples and model predictions. Then, it can be shown  that we can compute an estimate, maybe noisy, of the gradient (and move towards the minimum) by using only one data sample (or a small data sample). Then, we can probably find a minimum of $f(\mathbf{w})$ by iterating this noisy gradient estimation over the dataset. A full iteration of over the dataset is called an *epoch*. To ensure convergence properties, during each epoch, data must be used in a random order.

If we apply this method we have some theoretical guarantees to find a good minimum:

+ SGD essentially uses the inaccurate gradient per iteration. What is the cost by using approximate gradient? The answer is that the convergence rate is slower than the gradient descent algorithm.
+ The convergence of SGD has been analyzed using the theories of convex minimization and of stochastic approximation: it converges almost surely to a global minimum when the objective function is convex or pseudoconvex, and otherwise converges almost surely to a local minimum.

During the last years there have been proposed several improved stochastic gradient descend algorithms, such as Momentum-SGD, Adagrad or Adam, but a discussion about these methods is out of the scope of this tutorial. 

### Training strategies

In Python-like code, a standard Gradient Descend method that considers the whole dataset at each iteration looks like this:

```python
nb_epochs = 100
for i in range(nb_epochs):
    grad = evaluate_gradient(target_f, data, w)
    w = w - learning_rate * grad
```

For a pre-defined number of epochs, we first compute the gradient vector of the target function for the whole dataset w.r.t. our parameter vector and update the parameters of the function. 

In contrast, Stochastic Gradient Descent performs a parameter update for each training example and label:

```python
nb_epochs = 100
for i in range(nb_epochs):
    np.random.shuffle(data)
    for sample in data:
        grad = evaluate_gradient(target_f, sample, w)
        w = w - learning_rate * grad
```

Finally, we can consider an hybrid technique, *Mini-batch Gradient Descent*, that takes the best of both worlds and performs an update for every small subset of $m$ training examples:

```python
nb_epochs = 100
for i in range(nb_epochs):
  np.random.shuffle(data)
  for batch in get_batches(data, batch_size=50):
    grad = evaluate_gradient(target_f, batch, w)
    w = w - learning_rate * grad
```

Minibatch SGD has the advantage that it works with a slightly less noisy estimate of the gradient. However, as the minibatch size increases, the number of updates done per computation decreases (eventually it becomes very inefficient, like batch gradient descent). 

There is an optimal trade-off (in terms of computational efficiency) that may vary depending on the data distribution and the particulars of the class of function considered, as well as how computations are implemented.

### Loss functions

To learn from data we must face the definition of the function that evaluates the fitting of our model to data, the *loss functions*. Loss functions specifically represent the price paid for inaccuracy of predictions in classification/regression problems: $L(y, M(\mathbf{x}, \mathbf{w})) = \frac{1}{n} \sum_i \ell(y_i, M(\mathbf{x}_i, \mathbf{w}))$. 

In regression problems, the most common loss function is the *square loss* function:

$$ L(y, M(\mathbf{x}, \mathbf{w})) = \frac{1}{n} \sum_i (y_i - M(\mathbf{x}_i, \mathbf{w}))^2  $$

In classification this function could be the *zero-one loss*, that is, $ \ell(y_i, M(\mathbf{x}_i, \mathbf{w}))$ is zero when $y_i = M(\mathbf{x}_i, \mathbf{w})$ and one otherwise. This function is discontinuous with flat regions and is thus impossible to optimize using gradient-based methods. For this reason it is usual to consider a proxy to the zero-one loss called a *surrogate loss function*. For computational reasons this is usually a convex function. In the following we review some of the most common surrogate loss functions. 

For classification problems the *hinge loss* provides a relatively tight, convex upper bound on the * zero-one loss*:

$$ L(y, M(\mathbf{x}, \mathbf{w})) = \frac{1}{n} \sum_i \mbox{max}(0, 1 - y_i M(\mathbf{x}_i, \mathbf{w}))  $$


Another popular alternative is the *logistic loss* (also known as *logistic regression*) function: 

$$ L(y, M(\mathbf{x}, \mathbf{w})) = \frac{1}{n} log(1 + exp(-y_i M(\mathbf{x}_i, \mathbf{w}))) $$

This function displays a similar convergence rate to the hinge loss function, and since it is continuous, simple gradient descent methods can be utilized. 

*Cross-entropy* is a loss function that is very used for training *multiclass problems*. In this case, our labels have this form $\mathbf{y}_i =(1.0,0.0,0.0)$. If our model predicts a different distribution, say  $ M(\mathbf{x}_i, \mathbf{w})=(0.4,0.1,0.5)$, then we'd like to nudge the parameters so that $M(\mathbf{x}_i, \mathbf{w})$ gets closer to $\mathbf{y}_i$. C.Shannon showed that if you want to send a series of messages composed of symbols from an alphabet with distribution $y$  ($y_j$ is the probability of the  $j$-th symbol), then to use the smallest number of bits on average, you should assign  $\log(\frac{1}{y_j})$  bits to the  $j$-th symbol. The optimal number of bits is known as *entropy*:

$$ H(\mathbf{y}) = \sum_j y_j \log\frac{1}{y_j} = - \sum_j y_j \log y_j$$

*Cross-entropy* is the number of bits we'll need if we encode symbols by using a wrong distribution $\hat y$:

$$ H(y, \hat y) =   - \sum_j y_j \log \hat y_j $$ 

In our case, the real distribution is $\mathbf{y}$ and the 'wrong' one is $M(\mathbf{x}, \mathbf{w})$. So, minimizing *cross-entropy* with respect our model parameters will result in the model that best approximates our labels if considered as a probabilistic distribution. 

Cross entropy is used in combination with the *Softmax* classifier. In order to classify $\mathbf{x}_i$ we could take the index corresponding to the max value of $M(\mathbf{x}_i, \mathbf{w})$, but Softmax gives a slightly more intuitive output (normalized class probabilities) and also has a probabilistic interpretation:

$$ P(\mathbf{y}_i = j \mid M(\mathbf{x}_i, \mathbf{w})) =   \frac{e^{M_j(\mathbf{x}_i, \mathbf{w})}}{\sum_k e^{M_k(\mathbf{x}_i, \mathbf{w})} }  $$

where $M_k$ is the $k$-th component of the classifier output. 

## Automatic Differentiation

Let's come back to the problem of the derivative computation and the cost it represents for Stochastic Gradient Descend methods. We have seen that in order to optimize our models we need to compute the derivative of the loss function with respect to all model parameters for a series of epochs that involve thousands or millions of data points. 

In general, the computation of derivatives in computer models is addressed by four main methods: 

+ manually working out derivatives and coding the result;
+ using numerical differentiation, also known as finite difference approximations;
+ using symbolic differentiation (using expression manipulation in software);
+ and automatic differentiation (AD).

When training large and deep neural networks, AD is the only practical alternative. 
AD works by systematically applying the chain rule of differential calculus at the elementary operator level.

Let $ y = f(g(w)) $ our target function. In its basic form, the chain rule states:

$\frac{\partial f}{\partial w} = \frac{\partial f}{\partial g} \frac{\partial g}{\partial w}$

or, if there is more than one variable $g_i$ in-between $y$ and $w$ (f.e. if $f$ is a two dimensional function such as $f(g_1(w), g_2(w))$), then:

$$ \frac{\partial f}{\partial w} = \sum_i \frac{\partial f}{\partial g_i} \frac{\partial g_i}{\partial w} $$

For example, let's consider the derivative of one-dimensional 1-layer neural network:

$f_x(w,b) = \frac{1}{1 + e^{- (w \cdot  x + b)}}$

Now, let's write how to evaluate $f(w)$ via a sequence of primitive operations:

```python
x = ?
f1 = w * x
f2 = f1 + b
f3 = -f2
f4 = 2.718281828459 ** f3
f5 = 1.0 + f4
f = 1.0/f5
```

The question mark indicates that $x$ is a value that must be provided. This *program* can compute the value of $f$ and also populate program variables. 

We can evaluate $\frac{\partial f}{\partial w}$ at some $x$ by using Eq.(\ref{chain1}). This is called *forward-mode differentiation*. In our case:

```python
def dfdx_forward(x, w, b):
    f1 = w * x
    df1 = x                            # = d(f1)/d(w)
    f2 = f1 + b
    df2 = df1 * 1.0                    # = df1 * d(f2)/d(f1) 
    f3 = -f2
    df3 = df2 * -1.0                   # = df2 * d(f3)/d(f2)
    f4 = 2.718281828459 ** f3
    df4 = df3 * 2.718281828459 ** f3   # = df3 * d(f4)/d(f3)
    f5 = 1.0 + f4
    df5 = df4 * 1.0                    # = df4 * d(f5)/d(f4)
    df6 = df5 * -1.0 / f5 ** 2.0       # = df5 * d(f6)/d(f5)
    return df6
```

It is interesting to note that this *program* can be readily executed if we have access to subroutines implementing the derivatives of primitive functions (such as $\exp{(x)}$ or $1/x$) and all intermediate variables are computed in the right order. It is also interesting to note that AD allows the accurate evaluation of derivatives at machine precision, with only a small constant factor of overhead.

Forward differentiation is efficient for functions $f : \mathbf{R}^n \rightarrow \mathbf{R}^m$ with $n << m$ (only $O(n)$ sweeps are necessary). For cases $n >> m$ a different technique is needed. To this end, we will rewrite Eq.(\ref{chain1}) as:

$\frac{\partial f}{\partial x} = \frac{\partial g}{\partial x} \frac{\partial f}{\partial g}$

to propagate derivatives backward from a given output. This is called *reverse-mode differentiation*. Reverse pass starts at the end (i.e. $\frac{\partial f}{\partial f} = 1$) and propagates backward to all dependencies.

```python
def dfdx_backward(x, w, b):
    f1 = w * x
    f2 = f1 + b
    f3 = -f2
    f4 = 2.718281828459 ** f3
    f5 = 1.0 + f4
    f6 = 1.0/f5
    
    df6 = 1.0                          # = d(f)/d(f)
    df5 = 1.0 * -1.0 / (f5 ** 2)       # = df6 * d(f6)/d(f5) 
    df4 = df5 * 1.0                    # = df5 * d(f5)/d(f4)
    df3 = df4 * log(2.718281828459) 
          * 2.718281828459 ** f3       # = df4 * d(f4)/d(f3)
    df2 = df3 * -1.0                   # = df3 * d(f3)/d(f2)
    df1 = df2 * 1.0                    # = df2 * d(f2)/d(f1)
    df  = df1 * x                      # = df1 * d(f1)/d(w) 
    return df
```

In practice, reverse-mode differentiation is a two-stage process. In the first stage the original function code is run forward, populating $f_i$ variables. In the second stage, derivatives are calculated by propagating in reverse, from the outputs to the inputs.

The most important property of reverse-mode differentiation is that it is cheaper than forward-mode differentiation for functions with a high number of input variables. In our case, $f : \mathbf{R}^n \rightarrow \mathbf{R}$, only one application of the reverse mode is sufficient to compute the full gradient of the function $\nabla f = \big( \frac{\partial f}{\partial w_1}, \dots ,\frac{\partial f}{\partial w_n} \big)$. This is the case of deep learning, where the number of parameters to optimize is very high. 

As we have seen, AD relies on the fact that all numerical computations are ultimately compositions of a finite set of elementary operations for which derivatives are known. For this reason, given a library of derivatives of all elementary functions in a deep neural network, we are able of computing the derivatives of the network with respect to all parameters at machine precision and applying stochastic gradient methods to its training. Without this automation process the design and debugging of optimization processes for complex neural networks with millions of parameters would be impossible. 

## Architectures

Up to now we have used classical neural network layers: those that can be represented by a simple weight matrix multiplication plus the application of a non linear activation function. But automatic differentiation paves the way to consider different kinds of layers without pain.

### Convolutional Neural Networks

Convolutional Neural Networks have been some of the most influential innovations in the field of computer vision in the last years. When considering the analysis of an image with a computer we must define a computational representation of an image. To this end, images are represented as $n \times m \times 3$ array of numbers, called *pixels*.  The 3 refers to RGB values and $n, m$ refers to the height and width of the image in pixels. Each number in this array is given a value from 0 to 255 which describes the pixel intensity at that point. 
These numbers are the only inputs available to the computer.  

What is to classify an image? The idea is that you give the computer this array of numbers and it must output numbers that describe the probability of the image being a certain class.

Of course, this kind of image representation is suited to be classified by a classical neural network composed of dense layers, but this approach has several limitations.

The first one is that large images with a high number of pixels will need from extremely large networks to be analyzed. If an image has $256 \times 256 = 65,536$ pixels, the first layer of a classical neural network needs to have $65,536 \times 65,536 = 4,294,967,296$ different weights to consider all pixel interactions. Even in the case that this number of weights could be stored in the available memory, learning these weights would be very time consuming. But there is a better alternative.

Natural images are not a random combination of values in a $256 \times 256$ array, but present strong correlations at different levels. At the most basic, it is evident that the value of a pixel is not independent of the values of its neighboring pixels. Moreover, natural images present another interesting property: location invariance. That means that visual structures, such as a ``cat`` or a ``dog``, can be present on any place of the image at any scale. Image location is not important, what is important for attaching a meaning to an image are the relative positions of geometric and photometric structures. 

All this considerations leaded, partially inspired by biological models, to the proposal of a very special kind of layers: those based on *convolutions*. A convolution is a mathematical operation that combines two input images to form a third one. One of the input images is the image we want to process. The other one, that is smaller, is called the kernel. Let's suppose that our kernel is this one:

$$ Kernel = \left( \begin{array}{rrr} 0 & -1 & 0 \\ -1 & 5 & -1 \\  0 & -1 & 0 \end{array} \right)$$

The output of image convolution is calculated as follows:

+ Flip the kernel both horizontally and vertically. As our selected kernel is symmetric, the flipped kernel is equal to the original.
+ Put the first element of the kernel at every element of the image matrix. Multiply each element of the kernel with its corresponding element of the image matrix (the one which is overlapped with it). 
+ Sum up all product outputs and put the result at the same position in the output matrix as the center of kernel in image matrix.

Mathematically, given a convolution kernel $K$ represented by a $(M \times N)$ array, the convolution of an image $I$ with $K$ is:
$$
output(x,y) = (I \otimes K)(x,y) = \sum_{m=0}^{M-1} \sum_{n=1}^{N-1} K(m,n) I(x-n, y-m)
$$

The output of image convolution is another image that might represent some kind of information that was present in the image in a very subtle way. For example, the kernel we have used is called an *edge detector* because it highlights the edges of visual structures and attenuates smooth regions. 

In convolutional neural networks the values of the kernel matrix are free parameters that must be learned to perform the optimal information extraction in order to classify the image. 

Convolutions are linear operators and because of this the application of successive convolutions can always be represented by a single convolution. But if we apply a non linear activation function after each convolution the application of successive convolution operators makes sense and results in a powerful image feature structure. 

In fact, after a convolutional layer there are two kinds of non linear functions that are usually applied: non-linear activation functions such as sigmoids or ReLU and *pooling*. Pooling layers are used with the purpose to progressively reduce the spatial size of the image to achieve scale invariance.The most common layer is the *maxpool* layer. Basically a maxpool of $2 \times 2$ causes a filter of 2 by 2 to traverse over the entire input array and pick the largest element from the window to be included in the next representation map. Pooling can also be implemented by using other criteria, such as averaging instead of taking the max element. 

A convolutional neural network is a neural network that is build by using several convolutional layers, each one formed by the concatenation of three different operators: convolutions, non-linear activation and pooling. This kind of networks are able of extracting powerful image descriptors when applied in sequence. The power of the method has been credited to the fact that these descriptors can be seen as hierarchical features that are suited to optimally represent visual structures in natural images. The last layers of a convolutional neural network are classical dense layers, which are connected to a classification or regression loss function.

Finally, it is interesting to point out that convolutional layers are much lighter, in terms of number of weights, than fully connected layers, but more computationally demanding (The number of weights we must learn for a $(M \times N)$ convolution kernel is only $(M \times N)$, which is independent of the size of the image). In some sense, convolutional layers trade weights for computation when extracting information. 

### Recurrent Neural Networks

Classical neural networks, including convolutional ones, suffer from two severe limitations:

+ They only accept a fixed-sized vector as input and produce a fixed-sized vector as output.
+ They do not consider the sequential nature of some data (language, video frames, time series, etc.) 

Recurrent neural networks (RNN) overcome these limitations by allowing to operate over sequences of vectors (in the input, in the output, or both). RNNs are called recurrent because they perform the same task for every element of the sequence, with the output depending on the previous computations. The basic formulas of a simple RNN are:

$$ s_t = f_1 (Ux_t + W s_{t-1}) $$
$$ y_t = f_2 (V s_t) $$

These equations basically say that the current network state, commonly known as hidden state, $s_t$ is a function $f_1$ of the previous hidden state $s_{t-1}$ and the current input $x_t$. $U, V, W$ matrices are the parameters of the function. 

Given an input sequence, we apply RNN formulas in a recurrent way until we process all input elements. The RNN shares the parameters  $U,V,W$ across all recurrent steps. We can think of the hidden state  as a memory of the network that captures information about the previous steps.

The computational layer implementing this very basic recurrent structure is this:

```python
def rnn_layer(x, s):
    h = np.tanh(np.dot(W, s) + np.dot(U, x))
    y = np.dot(V, s)
    return y
```

where ``np.tanh`` represents the non-linear $\mbox{tanh}$ function and ``np.dot`` represents matrix multiplication. 

The novelty of this type of network is that we we have encoded in the very architecture of the network a sequence modeling scheme that has been in used in the past to predict time series as well as to model language. In contrast to the precedent architectures we have introduced, now the hidden layers are indexed by both 'spatial' and 'temporal' index. 

These layers can also be stacked one on top of the other for building deep RNNs:

```python
y1 = rnn_layer(x)
y2 = rnn_layer(y1)
```

Training a RNN is similar to training a traditional neural network, but with some modifications. The main reason is that parameters are shared by all time steps: in order to compute the gradient at  $t=4$ , we need to propagate 3 steps and sum up the gradients. This is called Backpropagation through time (BPTT).

The inputs of a recurrent network are always vectors, but we can process sequences of symbols/words by representing these symbols by numerical vectors.

Let's suppose we want to classify a phrase or a series of words. Let $x^1, ...,x^{C}$ the word vectors corresponding to a corpus with $C$ symbols (The computation of useful vectors for words is out of the scope of this tutorial, but the most common method is *word embedding*, an unsupervised method that is based on shallow neural networks). Then, the relationship to compute the hidden layer output features at each time-step $t$ is $h_t = \sigma(W s_{t-1} + U x_{t})$, where:

+ $x_{t} \in \mathbf{R}^{d}$ is input word vector at time $t$.
+ $U \in \mathbf{R}^{D_h \times d}$ is the weights matrix of the input word vector, $x_t$.
+ $W \in \mathbf{R}^{D_h \times D_h}$ is the weights matrix of the output of the previous time-step, $t-1$.
+ $s_{t-1}  \in \mathbf{R}^{D_h}$ is the output of the non-linear function at the previous time-step, $t-1$. 
+ $\sigma ()$ is the non-linearity function (normally, ``tanh``).

The output of this network is $\hat{y}_t = softmax (V h_t)$, that represents the output probability distribution over the vocabulary at each time-step $t$.  

Essentially, $\hat{y}_t$ is the next predicted word given the document context score so far (i.e. $h_{t-1}$) and the last observed word vector $x^{(t)}$. 

The loss function used in RNNs is often the cross entropy error:

$$
	L^{(t)}(W) = - \sum_{j=1}^{|V|} y_{t,j} \times log (\hat{y}_{t,j})
$$

The cross entropy error over a corpus of size $C$ is:

$$
	L = \frac{1}{C} \sum_{c=1}^{C} L^{(c)}(W) = - \frac{1}{C} \sum_{c=1}^{C} \sum_{j=1}^{|V|} y_{c,j} \times log (\hat{y}_{c,j})
$$
These simple RNN architectures have been shown to be too prone to forget information when sequences are long and they are also very unstable when trained. For this reason several alternative architectures have been proposed. These alternatives are based on the presence of *gated units*. Gates are a way to optionally let information through. They are composed out of a sigmoid neural net layer and a pointwise multiplication operation. The two most important alternative RNN are Long Short Term Memories (LSTM) and Gated Recurrent Units (GRU) networks. 

Let us see how a LSTM uses $h_{t-1}, C_{t-1}$ and $x_{t}$ to generate the next hidden states $C_t, h_{t}$:

$$ f_t = \sigma(W_f \cdot [h_{t-1}, x_t]) \mbox{ (Forget gate)} $$
$$ i_t = \sigma(W_i \cdot [h_{t-1}, x_t]) \mbox{ (Input gate)} $$
$$ \tilde C_t = \tanh(W_C \cdot [h_{t-1}, x_t]) $$
$$ C_t = f_t * C_{t-1} + i_t * \tilde C_t \mbox{ (Update gate)} $$
$$ o_t = \sigma(W_o \cdot [h_{t-1}, x_t]) $$
$$ h_t = o_t * \tanh(C_t) \mbox{ (Output gate)} $$

GRU are a simpler architecture that has been shown to perform at almost the same level as LSTM but using less parameters:

$$ z_{t} = \sigma(W_z \cdot [x_{t}, h_{t-1}]) \mbox{ (Update gate)}$$
$$ r_{t} = \sigma(W_r \cdot [x_{t}, h_{t-1}]) \mbox{ (Reset gate)}$$
$$ \tilde{h}_{t} = \tanh(r_{t} \cdot  [x_{t}, r_t \circ h_{t-1}]   ) \mbox{ (New memory)}$$
$$ h_{t} = (1 - z_{t}) \circ \tilde{h}_{t-1} + z_{t} \circ h_{t} \mbox{ (Hidden state)}$$

Recurrent neural networks have shown success in areas such as language modeling and generation, machine translation, speech recognition, image description or captioning, question answering, etc.

## Conclusions

Deep learning constitutes a novel methodology to train very large neural networks (in terms of number of parameters), composed of a large number of specialized layers that are able of representing data in an optimal way to perform regression or classification tasks. 

Nowadays, training of deep learning models is performed with the aid of large software environments  that hide some of the complexities of the task. This allows the practitioner to focus in designing the best architecture and tuning hyper-parameters, but this comes at a cost: seeing these models as black boxes that learn in an almost magical way. 

To fully appreciate this fact, here we show a full model specification, training procedure and model evaluation in Keras, for a convolutional neural network:

```python
model = Sequential()
model.add(Convolution2D(32, 3, 3, 
                        activation='relu',
                        input_shape=(1,28,28)))
model.add(Convolution2D(32, 3, 3, 
                        activation='relu'))
model.add(MaxPooling2D(pool_size=(2,2)))
model.add(Flatten())
model.add(Dense(128, 
          activation='relu'))
model.add(Dense(10, 
          activation='softmax'))
model.compile(loss='categorical_crossentropy',
              optimizer='SGD',
              metrics=['accuracy'])
model.fit(X_train, Y_train, 
          batch_size=32, 
          nb_epoch=10)
score = model.evaluate(X_test, Y_test)    
```

It is not difficult to see in this program some of the elements we have discussed in this paper: SGD, minibatch training, epochs, pooling, convolutional layers, etc. 

But to fully understand this model, it is necessary to understand everyone of the parameters and options. It is necessary to understand that this program is implementing an optimization strategy for fitting a neural network model, composed of 2 convolutional layers with 32 $3 \times 3$ kernel filters and 2 dense layers with 128 and 10 neurons respectively. It is important to be aware that fitting this model requires a relatively large data set and that the only way of minimizing the loss function, cross-entropy in this case, is by using minibatch stochastic gradient descend. We need to know how to find the optimal minibatch size to speed up the optimization process in a specific machine and also to select the optimal non linearity function. Automatic differentiation is hidden in the fitting function, but it is absolutely necessary to deal with the optimization of the complex mathematical expression that results from this model specification. 
