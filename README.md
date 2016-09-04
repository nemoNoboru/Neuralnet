# Neuralnet [![Build Status](https://travis-ci.org/nemoNoboru/Neuralnet.svg?branch=master)](https://travis-ci.org/nemoNoboru/Neuralnet)
Simple, powerfull, robust and easy to use neural network implementation on ruby.  
The neural network is meant to be used along a custom made genetic algorithm.  
Your workflow to train the neuralnets should be something like this:
- Create 2 (or more) neuralnets and mix them till a (big) population is made
- Pass each neuralnet to a fitness function that represents how well a neuralnet
solves your problem
- Mix the neuralnets who have the best score
- Repeat
- When finished save the neuralnet to a file

# Usage
# Creating & Configuring

```ruby
require 'neuralnet'

n = NeuralNet.new do |config|
  config.inputs = 3  # required
  config.outputs = 4 # required
  config.hidden = 23 # optional, default value is the average between inputs and outputs
  config.type = :sse # optional, default value is :sse
end
```
*n* is a neuralnet object but can't process inputs right now. Before any processing you have to load values to it. Both loading from a file or loading random values will work.

# Loading and saving to a file
WIP

# Loading random values
```ruby
n = NeuralNet.new do |config|
  config.inputs = 2
  config.outputs = 1
end

n.random
```

# Mixing two neuralnets to create a population
```ruby
population_size = 500
neurals = Array.new(population_size) do
  neuralnet1.mix(neuralnet2)
end
```
*neuralnet1* and *neuralnet2* are neuralnets with same inputs and outputs.

# Processing inputs
the inputs have to be passed as an array.
```ruby
n = NeuralNet.new do |config|
  config.inputs = 3
  config.outputs = 1
end
n.random
n.process([0.1,0.2,0.3])
```

# TO DO
- [x] Write tests
- [x] Add reproduction to NeuralNets
- [ ] Find a better name
- [x] set-up travis CI
- [ ] Code loading and saving system
- [ ] Write documentation (WIP)
- [ ] Publish to rubygems
