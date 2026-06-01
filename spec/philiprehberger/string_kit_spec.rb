# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Philiprehberger::StringKit do
  it 'has a version number' do
    expect(described_class::VERSION).not_to be_nil
  end

  describe '.titlecase' do
    it 'converts a simple string' do
      expect(described_class.titlecase('hello world')).to eq('Hello World')
    end

    it 'handles empty string' do
      expect(described_class.titlecase('')).to eq('')
    end

    it 'raises Error for non-string' do
      expect { described_class.titlecase(123) }.to raise_error(described_class::Error)
    end
  end

  describe '.kebab_case' do
    it 'converts spaces to hyphens' do
      expect(described_class.kebab_case('Hello World')).to eq('hello-world')
    end

    it 'converts camelCase' do
      expect(described_class.kebab_case('helloWorld')).to eq('hello-world')
    end

    it 'handles empty string' do
      expect(described_class.kebab_case('')).to eq('')
    end
  end

  describe '.camel_case' do
    it 'converts spaces to camelCase' do
      expect(described_class.camel_case('hello world')).to eq('helloWorld')
    end

    it 'converts kebab-case' do
      expect(described_class.camel_case('hello-world')).to eq('helloWorld')
    end

    it 'handles empty string' do
      expect(described_class.camel_case('')).to eq('')
    end
  end

  describe '.pascal_case' do
    it 'converts spaces to PascalCase' do
      expect(described_class.pascal_case('hello world')).to eq('HelloWorld')
    end

    it 'converts kebab-case' do
      expect(described_class.pascal_case('hello-world')).to eq('HelloWorld')
    end

    it 'handles empty string' do
      expect(described_class.pascal_case('')).to eq('')
    end
  end

  describe '.snake_case' do
    it 'converts spaces to underscores' do
      expect(described_class.snake_case('Hello World')).to eq('hello_world')
    end

    it 'converts camelCase' do
      expect(described_class.snake_case('helloWorld')).to eq('hello_world')
    end

    it 'handles empty string' do
      expect(described_class.snake_case('')).to eq('')
    end
  end

  describe '.constant_case' do
    it 'converts to CONSTANT_CASE' do
      expect(described_class.constant_case('hello world')).to eq('HELLO_WORLD')
    end

    it 'converts camelCase' do
      expect(described_class.constant_case('helloWorld')).to eq('HELLO_WORLD')
    end

    it 'handles empty string' do
      expect(described_class.constant_case('')).to eq('')
    end
  end

  describe '.strip_html' do
    it 'removes HTML tags' do
      expect(described_class.strip_html('<p>hello</p>')).to eq('hello')
    end

    it 'handles nested tags' do
      expect(described_class.strip_html('<div><b>bold</b></div>')).to eq('bold')
    end

    it 'returns plain text unchanged' do
      expect(described_class.strip_html('hello')).to eq('hello')
    end
  end

  describe '.normalize_whitespace' do
    it 'collapses multiple spaces' do
      expect(described_class.normalize_whitespace('hello   world')).to eq('hello world')
    end

    it 'handles tabs and newlines' do
      expect(described_class.normalize_whitespace("hello\t\nworld")).to eq('hello world')
    end

    it 'strips leading and trailing whitespace' do
      expect(described_class.normalize_whitespace('  hello  ')).to eq('hello')
    end
  end

  describe '.word_count' do
    it 'counts words' do
      expect(described_class.word_count('hello world foo')).to eq(3)
    end

    it 'handles empty string' do
      expect(described_class.word_count('')).to eq(0)
    end

    it 'handles multiple spaces' do
      expect(described_class.word_count('hello   world')).to eq(2)
    end
  end

  describe '.reading_time' do
    it 'estimates reading time' do
      text = (['word'] * 400).join(' ')
      expect(described_class.reading_time(text)).to eq(2)
    end

    it 'accepts custom wpm' do
      text = (['word'] * 100).join(' ')
      expect(described_class.reading_time(text, wpm: 100)).to eq(1)
    end

    it 'returns 0 for empty string' do
      expect(described_class.reading_time('')).to eq(0)
    end
  end

  describe '.excerpt' do
    it 'extracts around a phrase' do
      text = 'The quick brown fox jumps over the lazy dog'
      result = described_class.excerpt(text, 'fox', radius: 5)
      expect(result).to include('fox')
    end

    it 'returns empty string when phrase not found' do
      expect(described_class.excerpt('hello world', 'missing')).to eq('')
    end

    it 'handles case-insensitive matching' do
      result = described_class.excerpt('Hello World', 'hello', radius: 5)
      expect(result).to include('Hello')
    end
  end

  describe '.squeeze' do
    it 'removes consecutive duplicates' do
      expect(described_class.squeeze('aaabbbccc')).to eq('abc')
    end

    it 'handles empty string' do
      expect(described_class.squeeze('')).to eq('')
    end
  end

  describe '.indent' do
    it 'indents each line' do
      expect(described_class.indent("hello\nworld", 2)).to eq("  hello\n  world")
    end

    it 'handles single line' do
      expect(described_class.indent('hello', 4)).to eq('    hello')
    end
  end

  describe '.dedent' do
    it 'removes common leading whitespace' do
      text = "    hello\n    world"
      expect(described_class.dedent(text)).to eq("hello\nworld")
    end

    it 'handles mixed indentation' do
      text = "    hello\n      world"
      expect(described_class.dedent(text)).to eq("hello\n  world")
    end

    it 'handles empty string' do
      expect(described_class.dedent('')).to eq('')
    end
  end

  describe '.slug' do
    it 'converts a simple string' do
      expect(described_class.slug('Hello World!')).to eq('hello-world')
    end

    it 'strips special characters' do
      expect(described_class.slug('Hello @#$ World!!!')).to eq('hello-world')
    end

    it 'collapses multiple separators' do
      expect(described_class.slug('hello---world')).to eq('hello-world')
    end

    it 'handles unicode via transliteration' do
      expect(described_class.slug("Cr\u00E8me Br\u00FBl\u00E9e")).to eq('creme-brulee')
    end

    it 'accepts a custom separator' do
      expect(described_class.slug('Hello World!', separator: '_')).to eq('hello_world')
    end

    it 'handles empty string' do
      expect(described_class.slug('')).to eq('')
    end
  end

  describe '.pad' do
    it 'pads on the right by default' do
      expect(described_class.pad('hi', 5)).to eq('hi   ')
    end

    it 'pads on the left' do
      expect(described_class.pad('hi', 5, side: :left)).to eq('   hi')
    end

    it 'pads on both sides (center)' do
      expect(described_class.pad('hi', 6, side: :both)).to eq('  hi  ')
    end

    it 'returns original string when already long enough' do
      expect(described_class.pad('hello', 3)).to eq('hello')
    end

    it 'accepts a custom padding character' do
      expect(described_class.pad('hi', 5, char: '*')).to eq('hi***')
    end

    it 'handles odd center padding' do
      expect(described_class.pad('hi', 7, side: :both)).to eq('  hi   ')
    end
  end

  describe '.transliterate' do
    it 'replaces accented characters' do
      expect(described_class.transliterate("caf\u00E9")).to eq('cafe')
    end

    it 'handles naive with diaeresis' do
      expect(described_class.transliterate("na\u00EFve")).to eq('naive')
    end

    it 'handles uber with umlaut' do
      expect(described_class.transliterate("\u00FCber")).to eq('uber')
    end

    it 'leaves plain ASCII unchanged' do
      expect(described_class.transliterate('hello')).to eq('hello')
    end

    it 'handles empty string' do
      expect(described_class.transliterate('')).to eq('')
    end
  end

  describe '.dot_case' do
    it 'converts PascalCase' do
      expect(described_class.dot_case('SomeString')).to eq('some.string')
    end

    it 'converts snake_case' do
      expect(described_class.dot_case('some_string')).to eq('some.string')
    end

    it 'converts spaces' do
      expect(described_class.dot_case('some string')).to eq('some.string')
    end

    it 'handles empty string' do
      expect(described_class.dot_case('')).to eq('')
    end
  end

  describe '.path_case' do
    it 'converts PascalCase' do
      expect(described_class.path_case('SomeString')).to eq('some/string')
    end

    it 'converts snake_case' do
      expect(described_class.path_case('some_string')).to eq('some/string')
    end

    it 'converts camelCase' do
      expect(described_class.path_case('someString')).to eq('some/string')
    end

    it 'handles empty string' do
      expect(described_class.path_case('')).to eq('')
    end
  end

  describe '.reverse_case' do
    it 'swaps upper and lower case' do
      expect(described_class.reverse_case('Hello')).to eq('hELLO')
    end

    it 'handles all uppercase' do
      expect(described_class.reverse_case('HELLO')).to eq('hello')
    end

    it 'handles all lowercase' do
      expect(described_class.reverse_case('hello')).to eq('HELLO')
    end

    it 'handles empty string' do
      expect(described_class.reverse_case('')).to eq('')
    end
  end

  describe '.strip_zero_width' do
    it 'removes zero-width space (U+200B)' do
      expect(described_class.strip_zero_width('hello​world')).to eq('helloworld')
    end

    it 'removes zero-width non-joiner (U+200C)' do
      expect(described_class.strip_zero_width('hello‌world')).to eq('helloworld')
    end

    it 'removes zero-width joiner (U+200D)' do
      expect(described_class.strip_zero_width('hello‍world')).to eq('helloworld')
    end

    it 'removes byte order mark (U+FEFF)' do
      expect(described_class.strip_zero_width('﻿hello')).to eq('hello')
    end

    it 'removes Arabic letter mark (U+061C)' do
      expect(described_class.strip_zero_width('hello؜world')).to eq('helloworld')
    end

    it 'removes word joiner (U+2060)' do
      expect(described_class.strip_zero_width('hello⁠world')).to eq('helloworld')
    end

    it 'leaves visible characters intact' do
      expect(described_class.strip_zero_width('hello world')).to eq('hello world')
    end

    it 'returns empty string for empty input' do
      expect(described_class.strip_zero_width('')).to eq('')
    end
  end

  describe '.levenshtein' do
    it 'returns 0 for identical strings' do
      expect(described_class.levenshtein('hello', 'hello')).to eq(0)
    end

    it 'returns length when one string is empty' do
      expect(described_class.levenshtein('', 'hello')).to eq(5)
      expect(described_class.levenshtein('hello', '')).to eq(5)
    end

    it 'returns length for fully different strings' do
      expect(described_class.levenshtein('abc', 'xyz')).to eq(3)
    end

    it 'returns 3 for kitten/sitting' do
      expect(described_class.levenshtein('kitten', 'sitting')).to eq(3)
    end

    it 'handles two empty strings' do
      expect(described_class.levenshtein('', '')).to eq(0)
    end
  end

  describe '.similarity' do
    it 'returns 1.0 for identical strings' do
      expect(described_class.similarity('hello', 'hello')).to eq(1.0)
    end

    it 'returns 0.0 for fully different strings' do
      expect(described_class.similarity('abc', 'xyz')).to eq(0.0)
    end

    it 'returns a partial score for similar strings' do
      expect(described_class.similarity('kitten', 'sitting')).to be_within(0.01).of(0.571)
    end

    it 'returns 1.0 for two empty strings' do
      expect(described_class.similarity('', '')).to eq(1.0)
    end
  end

  describe '.mask' do
    it 'masks all but the last n characters' do
      expect(described_class.mask('4242424242424242', show_last: 4)).to eq('************4242')
    end

    it 'masks the middle portion preserving first and last characters' do
      expect(described_class.mask('alice@example.com', show_first: 2, show_last: 4)).to eq('al***********.com')
    end

    it 'returns the string unchanged when too short to mask' do
      expect(described_class.mask('abc', show_first: 1, show_last: 1)).to eq('abc')
    end

    it 'returns the string unchanged when show_first + show_last exceeds length' do
      expect(described_class.mask('hi', show_first: 5)).to eq('hi')
    end

    it 'returns the string unchanged for an empty string' do
      expect(described_class.mask('')).to eq('')
    end

    it 'accepts a custom mask character' do
      expect(described_class.mask('password123', show_last: 3, mask_char: '#')).to eq('########123')
    end

    it 'raises Error for non-string input' do
      expect { described_class.mask(12_345, show_last: 2) }.to raise_error(described_class::Error)
    end
  end

  describe '.between' do
    it 'extracts text between two delimiters' do
      expect(described_class.between('hello [world] there', '[', ']')).to eq('world')
    end

    it 'returns nil when the left delimiter is missing' do
      expect(described_class.between('no brackets here', '[', ']')).to be_nil
    end

    it 'returns nil when the right delimiter is missing' do
      expect(described_class.between('only [left here', '[', ']')).to be_nil
    end

    it 'returns the first occurrence when delimiters repeat' do
      expect(described_class.between('a(b)c(d)', '(', ')')).to eq('b')
    end

    it 'returns an empty string for adjacent delimiters' do
      expect(described_class.between('foo[]bar', '[', ']')).to eq('')
    end

    it 'supports multi-character delimiters' do
      expect(described_class.between('start<<inner>>end', '<<', '>>')).to eq('inner')
    end

    it 'raises Error for non-string input' do
      expect { described_class.between(nil, '[', ']') }.to raise_error(described_class::Error)
    end
  end

  describe '.truncate_words' do
    it 'truncates to max_words and appends the default omission' do
      expect(described_class.truncate_words('The quick brown fox jumps', 3)).to eq('The quick brown…')
    end

    it 'returns the original string when word count is below max_words' do
      expect(described_class.truncate_words('Two words', 5)).to eq('Two words')
    end

    it 'returns the original string when word count equals max_words' do
      expect(described_class.truncate_words('one two three', 3)).to eq('one two three')
    end

    it 'accepts a custom omission' do
      expect(described_class.truncate_words('a b c d e', 2, omission: '...')).to eq('a b...')
    end

    it 'collapses whitespace between kept words' do
      expect(described_class.truncate_words("foo   bar\tbaz\nqux", 2)).to eq('foo bar…')
    end

    it 'returns empty string unchanged' do
      expect(described_class.truncate_words('', 3)).to eq('')
    end

    it 'raises Error for non-string input' do
      expect { described_class.truncate_words(nil, 3) }.to raise_error(described_class::Error)
    end

    it 'raises Error when max_words is zero' do
      expect { described_class.truncate_words('hello world', 0) }.to raise_error(described_class::Error)
    end

    it 'raises Error when max_words is negative' do
      expect { described_class.truncate_words('hello world', -1) }.to raise_error(described_class::Error)
    end

    it 'raises Error when max_words is not an Integer' do
      expect { described_class.truncate_words('hello world', 2.5) }.to raise_error(described_class::Error)
    end
  end

  describe '.word_wrap' do
    it 'wraps on word boundaries within the width' do
      result = described_class.word_wrap('The quick brown fox jumps over the lazy dog', 15)
      expect(result).to eq("The quick brown\nfox jumps over\nthe lazy dog")
    end

    it 'leaves a string shorter than width unchanged' do
      expect(described_class.word_wrap('short', 20)).to eq('short')
    end

    it 'keeps words longer than width intact on their own line' do
      result = described_class.word_wrap('Supercalifragilistic words', 10)
      expect(result).to eq("Supercalifragilistic\nwords")
    end

    it 'honors existing newlines as forced breaks' do
      result = described_class.word_wrap("one two\nthree four", 7)
      expect(result).to eq("one two\nthree\nfour")
    end

    it 'returns an empty string for empty input' do
      expect(described_class.word_wrap('', 10)).to eq('')
    end

    it 'collapses runs of whitespace within a logical line' do
      expect(described_class.word_wrap('a   b  c', 10)).to eq('a b c')
    end

    it 'raises Error on non-positive width' do
      expect { described_class.word_wrap('hello', 0) }.to raise_error(described_class::Error)
      expect { described_class.word_wrap('hello', -1) }.to raise_error(described_class::Error)
    end

    it 'raises Error on non-Integer width' do
      expect { described_class.word_wrap('hello', 5.5) }.to raise_error(described_class::Error)
    end

    it 'raises Error on non-String input' do
      expect { described_class.word_wrap(nil, 5) }.to raise_error(described_class::Error)
    end
  end
end
