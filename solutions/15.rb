module Day15
  def self.get_hash(string)
    string.each_char.reduce(0) { |acc, ch| (acc + ch.ord) * 17 % 256 }
  end

  def self.hash_sequence(sequence)
    sequence.split(',').map do |part|
      get_hash(part)
    end
      .sum
  end

  def self.hashmap_sequence(sequence)
    # straightforward implementation

    data = Array.new(256) { [] }

    sequence.split(',').each do |part|
      label, op, focus = /([a-z]+)([-=])(\d?)/.match(part)[1..3]

      box_id = get_hash(label)

      box = data[box_id]

      i = box.find_index { |item| item[0] == label }

      case op
      when '='
        if i
          box[i][1] = focus.to_i
        else
          box << [label, focus.to_i]
        end
      when '-'
        box.delete_at(i) if i
      end
    end

    data.each_with_index.reduce(0) do |acc, (box, box_id)|
      acc + (box_id + 1) * box.each_with_index.reduce(0) { |acc, ((_, focus), i)| acc + (i + 1) * focus }
    end
  end
end
