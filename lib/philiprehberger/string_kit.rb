# frozen_string_literal: true

require_relative 'string_kit/version'

module Philiprehberger
  module StringKit
    class Error < StandardError; end

    WORD_BOUNDARY = /[^a-zA-Z0-9\u00C0-\u024F]+/

    TRANSLITERATION_MAP = {
      "\u00C0" => 'A', "\u00C1" => 'A', "\u00C2" => 'A', "\u00C3" => 'A', "\u00C4" => 'A', "\u00C5" => 'A',
      "\u00E0" => 'a', "\u00E1" => 'a', "\u00E2" => 'a', "\u00E3" => 'a', "\u00E4" => 'a', "\u00E5" => 'a',
      "\u00C6" => 'AE', "\u00E6" => 'ae',
      "\u00C7" => 'C', "\u00E7" => 'c',
      "\u00C8" => 'E', "\u00C9" => 'E', "\u00CA" => 'E', "\u00CB" => 'E',
      "\u00E8" => 'e', "\u00E9" => 'e', "\u00EA" => 'e', "\u00EB" => 'e',
      "\u00CC" => 'I', "\u00CD" => 'I', "\u00CE" => 'I', "\u00CF" => 'I',
      "\u00EC" => 'i', "\u00ED" => 'i', "\u00EE" => 'i', "\u00EF" => 'i',
      "\u00D0" => 'D', "\u00F0" => 'd',
      "\u00D1" => 'N', "\u00F1" => 'n',
      "\u00D2" => 'O', "\u00D3" => 'O', "\u00D4" => 'O', "\u00D5" => 'O', "\u00D6" => 'O', "\u00D8" => 'O',
      "\u00F2" => 'o', "\u00F3" => 'o', "\u00F4" => 'o', "\u00F5" => 'o', "\u00F6" => 'o', "\u00F8" => 'o',
      "\u00D9" => 'U', "\u00DA" => 'U', "\u00DB" => 'U', "\u00DC" => 'U',
      "\u00F9" => 'u', "\u00FA" => 'u', "\u00FB" => 'u', "\u00FC" => 'u',
      "\u00DD" => 'Y', "\u00FD" => 'y', "\u00FF" => 'y',
      "\u00DE" => 'Th', "\u00FE" => 'th',
      "\u00DF" => 'ss',
      "\u0100" => 'A', "\u0101" => 'a', "\u0102" => 'A', "\u0103" => 'a', "\u0104" => 'A', "\u0105" => 'a',
      "\u0106" => 'C', "\u0107" => 'c', "\u0108" => 'C', "\u0109" => 'c', "\u010A" => 'C', "\u010B" => 'c',
      "\u010C" => 'C', "\u010D" => 'c',
      "\u010E" => 'D', "\u010F" => 'd', "\u0110" => 'D', "\u0111" => 'd',
      "\u0112" => 'E', "\u0113" => 'e', "\u0114" => 'E', "\u0115" => 'e', "\u0116" => 'E', "\u0117" => 'e',
      "\u0118" => 'E', "\u0119" => 'e', "\u011A" => 'E', "\u011B" => 'e',
      "\u011C" => 'G', "\u011D" => 'g', "\u011E" => 'G', "\u011F" => 'g', "\u0120" => 'G', "\u0121" => 'g',
      "\u0122" => 'G', "\u0123" => 'g',
      "\u0124" => 'H', "\u0125" => 'h', "\u0126" => 'H', "\u0127" => 'h',
      "\u0128" => 'I', "\u0129" => 'i', "\u012A" => 'I', "\u012B" => 'i', "\u012C" => 'I', "\u012D" => 'i',
      "\u012E" => 'I', "\u012F" => 'i', "\u0130" => 'I', "\u0131" => 'i',
      "\u0134" => 'J', "\u0135" => 'j',
      "\u0136" => 'K', "\u0137" => 'k',
      "\u0139" => 'L', "\u013A" => 'l', "\u013B" => 'L', "\u013C" => 'l', "\u013D" => 'L', "\u013E" => 'l',
      "\u0141" => 'L', "\u0142" => 'l',
      "\u0143" => 'N', "\u0144" => 'n', "\u0145" => 'N', "\u0146" => 'n', "\u0147" => 'N', "\u0148" => 'n',
      "\u014C" => 'O', "\u014D" => 'o', "\u014E" => 'O', "\u014F" => 'o', "\u0150" => 'O', "\u0151" => 'o',
      "\u0152" => 'OE', "\u0153" => 'oe',
      "\u0154" => 'R', "\u0155" => 'r', "\u0156" => 'R', "\u0157" => 'r', "\u0158" => 'R', "\u0159" => 'r',
      "\u015A" => 'S', "\u015B" => 's', "\u015C" => 'S', "\u015D" => 's', "\u015E" => 'S', "\u015F" => 's',
      "\u0160" => 'S', "\u0161" => 's',
      "\u0162" => 'T', "\u0163" => 't', "\u0164" => 'T', "\u0165" => 't', "\u0166" => 'T', "\u0167" => 't',
      "\u0168" => 'U', "\u0169" => 'u', "\u016A" => 'U', "\u016B" => 'u', "\u016C" => 'U', "\u016D" => 'u',
      "\u016E" => 'U', "\u016F" => 'u', "\u0170" => 'U', "\u0171" => 'u', "\u0172" => 'U', "\u0173" => 'u',
      "\u0174" => 'W', "\u0175" => 'w',
      "\u0176" => 'Y', "\u0177" => 'y', "\u0178" => 'Y',
      "\u0179" => 'Z', "\u017A" => 'z', "\u017B" => 'Z', "\u017C" => 'z', "\u017D" => 'Z', "\u017E" => 'z'
    }.freeze

    # Convert string to Title Case
    #
    # @param str [String]
    # @return [String]
    def self.titlecase(str)
      validate!(str)
      str.gsub(/\b(\w)/) { ::Regexp.last_match(1).upcase }
    end

    # Convert string to kebab-case
    #
    # @param str [String]
    # @return [String]
    def self.kebab_case(str)
      validate!(str)
      separate_words(str).join('-')
    end

    # Convert string to camelCase
    #
    # @param str [String]
    # @return [String]
    def self.camel_case(str)
      validate!(str)
      words = separate_words(str)
      return '' if words.empty?

      words.first + words[1..].map(&:capitalize).join
    end

    # Convert string to PascalCase
    #
    # @param str [String]
    # @return [String]
    def self.pascal_case(str)
      validate!(str)
      separate_words(str).map(&:capitalize).join
    end

    # Convert string to snake_case
    #
    # @param str [String]
    # @return [String]
    def self.snake_case(str)
      validate!(str)
      separate_words(str).join('_')
    end

    # Convert string to CONSTANT_CASE
    #
    # @param str [String]
    # @return [String]
    def self.constant_case(str)
      validate!(str)
      separate_words(str).join('_').upcase
    end

    # Strip HTML tags from string
    #
    # @param str [String]
    # @return [String]
    def self.strip_html(str)
      validate!(str)
      str.gsub(/<[^>]*>/, '')
    end

    # Normalize whitespace to single spaces
    #
    # @param str [String]
    # @return [String]
    def self.normalize_whitespace(str)
      validate!(str)
      str.gsub(/\s+/, ' ').strip
    end

    # Count words in string
    #
    # @param str [String]
    # @return [Integer]
    def self.word_count(str)
      validate!(str)
      str.split(/\s+/).reject(&:empty?).length
    end

    # Estimate reading time in minutes
    #
    # @param str [String]
    # @param wpm [Integer] words per minute
    # @return [Float]
    def self.reading_time(str, wpm: 200)
      validate!(str)
      count = word_count(str)
      (count.to_f / wpm).ceil
    end

    # Extract excerpt around a phrase
    #
    # @param str [String]
    # @param phrase [String]
    # @param radius [Integer] number of characters around the phrase
    # @return [String]
    def self.excerpt(str, phrase, radius: 32)
      validate!(str)
      index = str.downcase.index(phrase.downcase)
      return '' if index.nil?

      start_pos = [index - radius, 0].max
      end_pos = [index + phrase.length + radius, str.length].min

      result = str[start_pos...end_pos]
      result = "...#{result}" if start_pos.positive?
      result = "#{result}..." if end_pos < str.length
      result
    end

    # Remove consecutive duplicate characters
    #
    # @param str [String]
    # @return [String]
    def self.squeeze(str)
      validate!(str)
      str.squeeze
    end

    # Indent each line by n spaces
    #
    # @param str [String]
    # @param n [Integer]
    # @return [String]
    def self.indent(str, n)
      validate!(str)
      prefix = ' ' * n
      str.gsub(/^/, prefix)
    end

    # Remove common leading whitespace from all lines
    #
    # @param str [String]
    # @return [String]
    def self.dedent(str)
      validate!(str)
      lines = str.lines
      non_empty = lines.reject { |line| line.strip.empty? }
      return str if non_empty.empty?

      min_indent = non_empty.map { |line| line[/\A\s*/].length }.min
      lines.map { |line| line.length > min_indent ? line[min_indent..] : line.lstrip }.join
    end

    # Generate a URL-safe slug
    #
    # @param str [String]
    # @param separator [String] separator character (default: '-')
    # @return [String]
    def self.slug(str, separator: '-')
      validate!(str)
      result = transliterate(str)
      result = result.downcase
      result = result.gsub(/[^a-z0-9\s-]/, '')
      result = result.strip.gsub(/[\s-]+/, separator)
      result.gsub(/#{Regexp.escape(separator)}+/, separator)
    end

    # Pad string to target length
    #
    # @param str [String]
    # @param length [Integer] target length
    # @param char [String] padding character (default: ' ')
    # @param side [Symbol] :left, :right, or :both (default: :right)
    # @return [String]
    def self.pad(str, length, char: ' ', side: :right)
      validate!(str)
      return str if str.length >= length

      diff = length - str.length
      case side
      when :left
        (char * diff) + str
      when :both
        left_pad = diff / 2
        right_pad = diff - left_pad
        (char * left_pad) + str + (char * right_pad)
      else
        str + (char * diff)
      end
    end

    # Replace accented/diacritical characters with ASCII equivalents
    #
    # @param str [String]
    # @return [String]
    def self.transliterate(str)
      validate!(str)
      str.gsub(/[^\x00-\x7F]/) { |char| TRANSLITERATION_MAP.fetch(char, char) }
    end

    # Convert string to dot.case
    #
    # @param str [String]
    # @return [String]
    def self.dot_case(str)
      validate!(str)
      separate_words(str).join('.')
    end

    # Convert string to path/case
    #
    # @param str [String]
    # @return [String]
    def self.path_case(str)
      validate!(str)
      separate_words(str).join('/')
    end

    # Swap upper and lower case characters
    #
    # @param str [String]
    # @return [String]
    def self.reverse_case(str)
      validate!(str)
      str.swapcase
    end

    class << self
      private

      def validate!(str)
        raise Error, 'input must be a String' unless str.is_a?(String)
      end

      def separate_words(str)
        str
          .gsub(/([a-z])([A-Z])/, '\1 \2')
          .gsub(/[^a-zA-Z0-9]+/, ' ')
          .strip
          .downcase
          .split
      end
    end
  end
end
