require 'monkey_type'

using MonkeyType

Neuralnet_config = Struct.new( :type,
                               :inputs,
                               :outputs,
                               :hidden)
class Neuralnet_configurer
  attr_reader :data

  def initialize
    @data = Neuralnet_config.new
  end

  def set_defaults
    @data.inputs.is Numeric
    @data.outputs.is Numeric

    @data.type ||= :sse
    @data.hidden ||= (@data.inputs + @data.outputs)/2

    @data.hidden.is Numeric
  end
end
