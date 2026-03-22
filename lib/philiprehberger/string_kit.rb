# frozen_string_literal: true

require_relative 'string_kit/version'

module Philiprehberger
  module StringKit
    class Error < StandardError; end

    WORD_BOUNDARY = /[^a-zA-Z0-9\u00C0-\u024F]+/

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
