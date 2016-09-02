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

  def method_missing( name, *args, &block )
    @kernel.send(name, *args, &block)
  end

  def process( list )
    list.is Array

    data = @kernel.process(list)

    if block_given?
      yield(data)
    end
    return data
  end

end
