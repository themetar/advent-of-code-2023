def get_lines(filepath)
  File.open(filepath) do |file|
    file.readlines(chomp: true)
  end
end
