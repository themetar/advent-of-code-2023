def get_lines(filepath)
  File.open(filepath) do |file|
    file.readlines(chomp: true)
  end
end

def get_input_lines(n)
  get_lines(__dir__ + "/../inputs/#{n}.txt")
end
