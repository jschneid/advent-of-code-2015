class Wire
  attr_accessor :value, :operation, :inputs

  def initialize
    @inputs = []
  end

  def perform_operation
    return unless @inputs.all? { |input| (input.is_a? Integer) || !input.value.nil? }

    operand0 = @inputs[0].is_a?(Integer) ? @inputs[0] : @inputs[0].value
    operand1 = @inputs[1].is_a?(Integer) ? @inputs[1] : @inputs[1].value unless @inputs[1].nil?

    case @operation
    when nil
      @value = operand0
    when 'AND'
      @value = operand0 & operand1
    when 'LSHIFT'
      @value = operand0 << operand1
    when 'NOT'
      @value = ~operand0
    when 'OR'
      @value = operand0 | operand1
    when 'RSHIFT'
      @value = operand0 >> operand1
    end
  end
end

def wire_up(wires)
  wires.each do |id, wire|
    wire_inputs = []
    wire.inputs.each do |input|
      wire_inputs << if input == '0' || input.to_i.positive?
                       input.to_i
                     else
                       wires[input]
      end
    end
    wire.inputs = wire_inputs
  end
end

wires = {}
File.foreach('input.txt', chomp: true) do |line|
  tokenized_line = line.split

  id = tokenized_line[-1]

  wire = Wire.new
  if tokenized_line[0] == 'NOT'
    wire.operation = 'NOT'
    wire.inputs << tokenized_line[1]
  elsif tokenized_line[1] == '->'
    wire.inputs << tokenized_line[0]
  else
    wire.inputs << tokenized_line[0]
    wire.operation = tokenized_line[1]
    wire.inputs << tokenized_line[2]
  end

  wires[id] = wire
end

wire_up(wires)

loop do
  wires.each do |id, wire|
    wire.perform_operation if wire.value.nil?

    next if wire.value.nil?

    if id == 'a'
      p wire.value
      return
    end

    wires.delete(id)
  end
end
