defmodule NeuralNetwork do
  @inputs_count 2
  @hidden_neurons_count 2

  def initialize do
    network_state = %{
      hidden_layer: %{},
      weights: %{}
    }
    |> initialize_weights()
    |> initialize_neurons()
  end

  defp initialize_neurons(state) do
    initialize_neurons(state, 0)
  end

  defp initialize_neurons(state, @hidden_neurons_count) do
    IO.puts "Finished: Initialize neurons"
    IO.inspect state
    IO.puts ""
    state
  end

  defp initialize_neurons(state, neuron_no) do
    new_hidden_layer =
      state.hidden_layer
      |> Map.put(neuron_no, generate_random_weight())
    
    %{ state | hidden_layer: new_hidden_layer }
    |> initialize_neurons(neuron_no + 1)
  end

  defp initialize_weights(state, []) do
    IO.puts "Finished: Initilize weights"
    IO.inspect state
    IO.puts ""
    state
  end

  defp initialize_weights(state, [ {input_no, hidden_neuron_no} | tail ]) do
    IO.puts "Initializing weight #{input_no} - #{hidden_neuron_no}"

    new_weights =
      state.weights
      |> Map.put({input_no, hidden_neuron_no}, generate_random_weight())

    %{ state | weights: new_weights }
    |> initialize_weights(tail)
  end

  defp initialize_weights(state) do
    weight_keys = 
      for input_no <- 0..@inputs_count-1, hidden_neuron_no <- 0..@hidden_neurons_count-1 do
        {input_no, hidden_neuron_no}
      end

    initialize_weights(state, weight_keys)
  end

  defp generate_random_weight do
    :rand.uniform
  end
end

defmodule NeuralNetworkApp do
  def run do
    IO.puts "### Starting ###"

    training_data = [
      {1, 1, 0},
      {0, 1, 1},
      {1, 0, 1},
      {0, 0, 0}
    ]

    network_state = NeuralNetwork.initialize()


    train(training_data, network_state)

  end

  def train([], network_state) do
    IO.puts "Empty trainig list. Training finished."
  end

  def train([head | tail], network_state) do
    IO.puts "Training..."
    IO.inspect head
    IO.puts ""

    train(tail, network_state)
  end
end

NeuralNetworkApp.run()
