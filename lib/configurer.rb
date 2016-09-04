require 'monkey_type'

using MonkeyType

NeuralnetConfig = Struct.new(:type,
                             :inputs,
                             :outputs,
                             :hidden)
class NeuralnetConfig
  def set_defaults
    inputs.is Numeric
    outputs.is Numeric

    self.type ||= :sse
    self.hidden ||= (inputs + outputs) / 2

    self.hidden.is Numeric
  end
end
