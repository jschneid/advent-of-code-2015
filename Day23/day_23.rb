Register = Struct.new(:value)

def init(initial_register_a_value)
  @register_a = Register.new(initial_register_a_value)
  @register_b = Register.new(0)
  @instruction_pointer = 0
end

def read_instructions
  @instructions = File.readlines('input.txt', chomp: true)
end

def register_from_argument(argument)
  case argument[0]
  when 'a'
    @register_a
  when 'b'
    @register_b
  end
end

def execute_hlf(argument0, _argument1)
  register = register_from_argument(argument0)
  register.value /= 2
  @instruction_pointer += 1
end

def execute_tpl(argument0, _argument1)
  register = register_from_argument(argument0)
  register.value *= 3
  @instruction_pointer += 1
end

def execute_inc(argument0, _argument1)
  register = register_from_argument(argument0)
  register.value += 1
  @instruction_pointer += 1
end

def execute_jmp(argument0, _argument1)
  @instruction_pointer += argument0.to_i
end

def execute_jie(argument0, argument1)
  register = register_from_argument(argument0)
  @instruction_pointer += if register.value.even?
                            argument1.to_i
                          else
                            1
                          end
end

def execute_jio(argument0, argument1)
  register = register_from_argument(argument0)
  @instruction_pointer += if register.value == 1
                            argument1.to_i
                          else
                            1
                          end
end

def execute_instruction(instruction_line)
  operation, argument0, argument1 = instruction_line.split
  send("execute_#{operation}", argument0, argument1)
end

def run_program(initial_register_a_value)
  init(initial_register_a_value)
  read_instructions

  loop do
    return if @instruction_pointer < 0 || @instruction_pointer >= @instructions.length

    execute_instruction(@instructions[@instruction_pointer])
  end
end

run_program(1)
p @register_a
p @register_b
