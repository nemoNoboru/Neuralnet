require 'monkey_type'

using MonkeyType

Neuralnet_config = Struct.new( :type,
                               :inputs,
                               :ouputs,
                               :hidden)
class Neuralnet_configurer
  attr_reader :data

  def initialize
    @data = Neuralnet_config.new
    set_defaults
  end

  def set_defaults
    @data.type ||= :sse
    @data.hidden ||= (inputs + outputs)/2

    @data.type.is String
    @data.inputs.is Numeric
    @data.hidden.is Numeric
    @data.outputs.is Numeric
  end
end
