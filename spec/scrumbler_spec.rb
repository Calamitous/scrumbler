require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Scrumbler' do
  describe '#new' do
    it 'requires a string parameter' do
      lambda { Scrumbler.new }.should raise_error
    end

    it 'exposes the provided string' do
      test_string = 'A noisy noise annoys an oyster.'
      Scrumbler.new(test_string).original.should == test_string
    end

    it 'automatically enscrumbles the string' do
      test_string = 'A noisy noise annoys an oyster.'
      Scrumbler.new(test_string).scrumbled.should_not == test_string
    end
  end

  describe '#enscrumble' do
    it 'returns a scrumbled string' do
      test_string = 'A noisy noise annoys an oyster.'
      Scrumbler.new(test_string).enscrumble.should match(/^A n...y n...e a....s an o....r\.$/)
    end

    it 'handles words with dashes' do
      test_string = 'en-scrumble'
      Scrumbler.new(test_string).enscrumble.should match(/e.........e/)
    end

    it "handles words with apostrophes" do
      test_string = "don't won't shan't"
      Scrumbler.new(test_string).enscrumble.should match(/d...t w...t s....t/)
    end

    it 'steps around punctuation' do
      test_string = 'How, without interjections?'
      Scrumbler.new(test_string).enscrumble.should match(/How, w.....t i..........s?/)
    end
  end

  describe '.scrumble' do
    it 'returns a scrumbled string' do
      test_string = 'A noisy noise annoys an oyster.'
      Scrumbler.scrumble(test_string).should match(/^A n...y n...e a....s an o....r\.$/)
    end

    it 'handles words with dashes' do
      test_string = 'en-scrumble'
      Scrumbler.scrumble(test_string).should match(/e.........e/)
    end

    it 'handles words with apostrophes' do
      test_string = "don't won't shan't"
      Scrumbler.scrumble(test_string).should match(/d...t w...t s....t/)
    end

    it 'steps around punctuation' do
      test_string = 'How, without interjections?'
      Scrumbler.scrumble(test_string).should match(/How, w.....t i..........s?/)
    end

    it 'handles single quoted text' do
      test_string = "'Magic belly'"
      Scrumbler.scrumble(test_string).should match(/'M...c b...y'/)
    end

    it 'handles single quoted word' do
      test_string = "'Magic' belly"
      Scrumbler.scrumble(test_string).should match(/'M...c' b...y/)
    end

    it 'handles double quoted text' do
      test_string = '"Magic belly"'
      Scrumbler.scrumble(test_string).should match(/\"M...c b...y\"/)
    end

    it 'handles double quoted word' do
      test_string = '"Magic" belly'
      Scrumbler.scrumble(test_string).should match(/\"M...c\" b...y/)
    end

    it 'handles crazy quotes' do
      test_string = 'The "Magic" belly \'has\' "crazy quotes"'
      Scrumbler.scrumble(test_string).should match(/The \"M...c\" b...y 'has' \"c...y q....s\"/)
    end

    it 'handles single quotes and contractions simultaneously' do
      test_string = "'don't won't' 'can't' 'shouldn't couldn't wouldn't'"
      Scrumbler.scrumble(test_string).should match(/'d...t w...t' 'c...t' 's.......t c......t w......t'/)
    end

    it 'handles all quotes and contractions simultaneously' do
      test_string = "\"'don't won't' 'can't' 'shouldn't couldn't wouldn't'\""
      Scrumbler.scrumble(test_string).should match(/"'d...t w...t' 'c...t' 's.......t c......t w......t'"/)
    end

    it 'handles extra-crazy quotes' do
      test_string = "The 'quick brown fox doesn't jump' \"over the lazy dog\""
      Scrumbler.scrumble(test_string).should match(/The 'q...k b...n fox d....'t j..p' \"o..r the l..y dog\"/)
    end
  end

  describe '.release_the_monkeys!' do
    it 'monkeypatches the String class to add #scrumble' do
      'Hello'.should_not respond_to(:scrumble)
      Scrumbler.release_the_monkeys!
      'Hello'.should respond_to(:scrumble)
    end

    context 'once the monkeys have been released' do
      before { Scrumbler.release_the_monkeys! }

      it 'returns a scrumbled string' do
        'A noisy noise annoys an oyster'.scrumble.should match(/^A n...y n...e a....s an o....r$/)
      end

      it 'handles words with dashes' do
        'en-scrumble'.scrumble.should match(/^e.........e$/)
      end

      it 'handles words with apostrophes' do
        "don't won't shan't".scrumble.should match(/^d...t w...t s....t$/)
      end

      it 'steps around punctuation' do
        'How, without more stuff?'.scrumble.should match(/^How, w.....t m..e s...f\?/)
      end
    end
  end

end
