require 'minitest/autorun'
require_relative '../lib/neuralnet.rb'

class NeuralnetTest < Minitest::Test
  def test_create_neuralnet
    t = NeuralNet.new do |config|
      config.inputs = 10
      config.outputs = 3
    end
    assert t
  end

  def test_should_fail_creating
    assert_raises(TypeError) do
      NeuralNet.new do |config|
      end
    end
  end

  def test_should_fail_creating_2
    assert_raises(TypeError) do
      NeuralNet.new do |config|
        config.inputs = 'hello'
      end
    end
  end

  def test_create_random
    t = NeuralNet.new do |config|
      config.inputs = 10
      config.outputs = 3
    end

    t.random
    assert t
  end

  def test_process_should_error
    assert_raises(RuntimeError) do
      t = NeuralNet.new do |config|
        config.inputs = 3
        config.outputs = 1
      end
      t.process([0.1, 0.2, 0.3])
    end
  end

  def test_processing
    t = NeuralNet.new do |config|
      config.inputs = 30
      config.outputs = 1
    end

    t.random
    data = t.process(Array.new(30) { rand })

    result = data.is_a? Array
    result2 = data[0].is_a? Numeric

    assert(result, 'data is not an array')
    assert(result2, 'data is not numeric')
  end

  def test_mixing
    n1 = NeuralNet.new do |config|
      config.inputs = 3
      config.outputs = 4
    end
    n1.random

    n2 = NeuralNet.new(n1.config)
    n2.random

    neurals = Array.new(4) { n1.mix n2 }
    assert neurals[0]
  end
end
