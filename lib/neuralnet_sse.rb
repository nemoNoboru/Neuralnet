require 'monkey_type'
require 'vector_sse'

using MonkeyType

class VectorSSE::Mat
  def get_data
    @data
  end

  def set_data(data)
    @data = data
  end
end

class Neuralnet_SSE
  def initialize( inputs, hidden, outputs )
    inputs.is Numeric
    hidden.is Numeric
    outputs.is Numeric

    @num_inputs = inputs
    @num_outputs = outputs
    @hidden_size = hidden
    @gnoma = []
  end

  def random
    init_layer = @num_inputs * @hidden_size
    hidden_layer = @hidden_size * @hidden_size
    output_layer = @hidden_size * @num_outputs
    self.load_gnoma(Array.new(init_layer+hidden_layer+output_layer+1){ rand })
  end

  def load_gnoma(gnoma)
    gnoma.is Array

    @gnoma = gnoma.clone

    num_end = @hidden_size * @num_outputs
    num_init = @num_inputs * @hidden_size
    num_hidden = @hidden_size * @hidden_size

    if gnoma.size <= num_end + num_init + num_hidden
      puts gnoma.size
      puts num_end + num_init + num_hidden
      raise "add more genes to the neural network"
    end

    @init = VectorSSE::Matrix.new( VectorSSE::Type::F32, @num_inputs, @hidden_size , gnoma.shift(num_init) )

    @hidden = VectorSSE::Matrix.new( VectorSSE::Type::F32, @hidden_size, @hidden_size, gnoma.shift(num_hidden) )

    @end = VectorSSE::Matrix.new( VectorSSE::Type::F32 , @hidden_size, @num_outputs, gnoma.shift(num_end) )

  end

  def gnoma
    @gnoma
  end

  def process(params)
    params.is Array

    initialMatrix = VectorSSE::Matrix.new( VectorSSE::Type::F32 , 1, @num_inputs ,params )
    n = activate(initialMatrix * @init )
    n = activate(n * @hidden )
    n = activate(n * @end )
    return (n.get_data)
  end

  def activate(matrix)
    if block_given?
      newMatrix = VectorSSE::Matrix.new( VectorSSE::Type::F32, matrix.rows, matrix.cols, matrix.get_data.map {|i| yield(i) } )
    else
      newMatrix = VectorSSE::Matrix.new( VectorSSE::Type::F32, matrix.rows, matrix.cols, matrix.get_data.map {|i| Math::sin(i) } )
    end
  end
end
