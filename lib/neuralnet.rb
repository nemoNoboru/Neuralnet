require_relative 'neuralnet_sse.rb'
require_relative 'configurer.rb'
require 'json'
require 'monkey_type'

using MonkeyType

class NeuralNet
  def initialize
    @config = Neuralnet_configurer.new
    yield(@config.data)
    @config.set_defaults
    @config = @config.data

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
    mutate(new_genoma)
  end

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
