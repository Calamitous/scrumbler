class Scrumbler
  attr_reader :original, :scrumbled

  def self.scrumble(new_string)
    self.new(new_string).enscrumble
  end

  def self.release_the_monkeys!
    String.class_eval("def scrumble; Scrumbler.scrumble(self); end")
  end

  def initialize(new_string)
    @original = new_string
    @scrumbled = enscrumble
  end

  def enscrumble
    @original.split(' ').map{ |x| word_scrumble(x) }.join(' ')
  end

  private

  def word_scrumble(chunk)
    word = chunk.scan(/[\w\d\'-]*/).join
    other = chunk.scan(/[^\w\d\'-]*/).join

    return chunk if word.length <= 3

    start_length = word[1].chr == 'h' ? 2 : 1

    first_bit = word[0..(start_length - 1)]
    middle_bit = word[start_length..-2]
    last_bit = word[-1].chr

    scrumbled_word = [first_bit, scramble(middle_bit), last_bit].flatten.join
    scrumbled_word + other
  end

  def scramble(text)
    text.scan(/./).sort{|x,y| rand(3) - 1 }
  end
end
