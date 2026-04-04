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
end
