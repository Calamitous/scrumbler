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
    word_single_quoted_start = false
    word_single_quoted_end = false
    word_double_quoted_start = false
    word_double_quoted_end = false

    word = chunk.scan(/[\w\d\'\"-]*/).join
    other = chunk.scan(/[^\w\d\'\"-]*/).join

    word_single_quoted_start = true if word[0].chr == "'"
    word_single_quoted_end = true if word[-1].chr == "'"
    word.gsub!(/^'/,"") if word_single_quoted_start
    word.gsub!(/'$/,"") if word_single_quoted_end

    word_double_quoted_start = true if word[0].chr == "\""
    word_double_quoted_end = true if word[-1].chr == "\""
    word.gsub!(/^\"/,"") if word_double_quoted_start
    word.gsub!(/\"$/,"") if word_double_quoted_end

    if word.length <= 3
      word = "'#{word}" if word_single_quoted_start
      word = "#{word}'" if word_single_quoted_end
      word = "\"#{word}" if word_double_quoted_start
      word = "#{word}\"" if word_double_quoted_end
      return word + other
    end

    start_length = word[1].chr == 'h' ? 2 : 1

    first_bit = word[0..(start_length - 1)]
    first_bit = "'#{first_bit}" if word_single_quoted_start
    first_bit = "\"#{first_bit}" if word_double_quoted_start
    middle_bit = word[start_length..-2]
    last_bit = word[-1].chr
    last_bit = "#{last_bit}'" if word_single_quoted_end
    last_bit = "#{last_bit}\"" if word_double_quoted_end

    scrumbled_word = [first_bit, scramble(middle_bit), last_bit].flatten.join
    scrumbled_word + other
  end

  def scramble(text)
    text.scan(/./).sort{|x,y| rand(3) - 1 }
  end
end
