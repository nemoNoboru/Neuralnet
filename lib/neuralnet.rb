require_relative 'neuralnet_sse.rb'
require_relative 'configurer.rb'
require 'json'
require 'monkey_type'

using MonkeyType

class NeuralNet
  attr_reader :config # or create method #clone

  def initialize(*config)
    if config[0] == nil
      @config = NeuralnetConfig.new
      yield(@config)
      @config.set_defaults
    else
      @config = config[0]
    end

    unless @config.inputs && @config.outputs
      raise 'you must specify at least the numbers of inputs and outputs'
    end

    if @config.type == :sse
      @kernel = Neuralnet_SSE.new(@config.inputs, @config.hidden, @config.outputs)
    else
      raise 'invalid type'
    end
  end

  def method_missing(name, *args, &block)
    @kernel.send(name, *args, &block)
  end

  def process(list)
    list.is Array

    data = @kernel.process(list)

    yield(data) if block_given?
    data
  end

  def mix(neural)
    neural.is NeuralNet

    index = 0
    new_genoma = []
    gnoma1 = self.gnoma
    gnoma2 = neural.gnoma

    gnoma1.each do
      t = if rand >= 0.5
            gnoma1[index]
          else
            gnoma2[index]
          end
      new_genoma << t
      index += 1
    end
    gen = mutate(new_genoma)
    new_neural = NeuralNet.new(@config)
    new_neural.load_gnoma(gen)
    return new_neural
  end
  contract :mix, NeuralNet

  def mutate(a)
    count = 0
    a.map do |i|
      if rand < 1.0 / a.size
        ((0.7 * i) + (rand * 0.3))
        count += 1
      else
        i
      end
    end
  end
end
