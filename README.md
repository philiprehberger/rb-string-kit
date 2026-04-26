# philiprehberger-string_kit

[![Tests](https://github.com/philiprehberger/rb-string-kit/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/rb-string-kit/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/philiprehberger-string_kit.svg)](https://rubygems.org/gems/philiprehberger-string_kit)
[![Last updated](https://img.shields.io/github/last-commit/philiprehberger/rb-string-kit)](https://github.com/philiprehberger/rb-string-kit/commits/main)

Comprehensive string utilities without ActiveSupport dependency

## Requirements

- Ruby >= 3.1

## Installation

Add to your Gemfile:

```ruby
gem "philiprehberger-string_kit"
```

Or install directly:

```bash
gem install philiprehberger-string_kit
```

## Usage

```ruby
require "philiprehberger/string_kit"

Philiprehberger::StringKit.titlecase('hello world')       # => "Hello World"
Philiprehberger::StringKit.kebab_case('helloWorld')        # => "hello-world"
Philiprehberger::StringKit.camel_case('hello world')       # => "helloWorld"
Philiprehberger::StringKit.pascal_case('hello world')      # => "HelloWorld"
Philiprehberger::StringKit.snake_case('Hello World')       # => "hello_world"
Philiprehberger::StringKit.constant_case('hello world')    # => "HELLO_WORLD"
Philiprehberger::StringKit.dot_case('SomeString')          # => "some.string"
Philiprehberger::StringKit.path_case('SomeString')         # => "some/string"
Philiprehberger::StringKit.reverse_case('Hello')           # => "hELLO"
```

### Slug Generation and Transliteration

```ruby
Philiprehberger::StringKit.slug('Hello World!')                  # => "hello-world"
Philiprehberger::StringKit.slug('Hello World!', separator: '_')  # => "hello_world"
Philiprehberger::StringKit.transliterate('cr\u00E8me br\u00FBl\u00E9e')          # => "creme brulee"
```

### String Padding

```ruby
Philiprehberger::StringKit.pad('hi', 5)                   # => "hi   "
Philiprehberger::StringKit.pad('hi', 5, side: :left)      # => "   hi"
Philiprehberger::StringKit.pad('hi', 6, side: :both)      # => "  hi  "
Philiprehberger::StringKit.pad('hi', 5, char: '*')        # => "hi***"
```

### Text Processing

```ruby
Philiprehberger::StringKit.strip_html('<p>hello</p>')          # => "hello"
Philiprehberger::StringKit.normalize_whitespace('a   b')       # => "a b"
Philiprehberger::StringKit.word_count('hello world foo')       # => 3
Philiprehberger::StringKit.reading_time(long_text, wpm: 200)  # => 2
```

### Excerpt and Indentation

```ruby
Philiprehberger::StringKit.excerpt(text, 'fox', radius: 10)   # => "...brown fox jumps..."
Philiprehberger::StringKit.squeeze('aaabbb')                   # => "ab"
Philiprehberger::StringKit.indent("hello\nworld", 2)           # => "  hello\n  world"
Philiprehberger::StringKit.dedent("    hello\n    world")      # => "hello\nworld"
```

### Zero-Width Characters

```ruby
require "philiprehberger/string_kit"

raw = "hello​world"
Philiprehberger::StringKit.strip_zero_width(raw)  # => "helloworld"
```

### String Similarity

```ruby
Philiprehberger::StringKit.levenshtein('kitten', 'sitting')  # => 3
Philiprehberger::StringKit.similarity('kitten', 'sitting')   # => ~0.571
```

## API

| Method | Description |
|--------|-------------|
| `StringKit.titlecase(str)` | Convert string to Title Case |
| `StringKit.kebab_case(str)` | Convert string to kebab-case |
| `StringKit.camel_case(str)` | Convert string to camelCase |
| `StringKit.pascal_case(str)` | Convert string to PascalCase |
| `StringKit.snake_case(str)` | Convert string to snake_case |
| `StringKit.constant_case(str)` | Convert string to CONSTANT_CASE |
| `StringKit.dot_case(str)` | Convert string to dot.case |
| `StringKit.path_case(str)` | Convert string to path/case |
| `StringKit.reverse_case(str)` | Swap upper and lower case characters |
| `StringKit.slug(str, separator:)` | Generate URL-safe slug |
| `StringKit.pad(str, length, char:, side:)` | Pad string to target length |
| `StringKit.transliterate(str)` | Replace accented characters with ASCII equivalents |
| `StringKit.strip_html(str)` | Remove HTML tags from string |
| `StringKit.normalize_whitespace(str)` | Collapse whitespace to single spaces |
| `StringKit.word_count(str)` | Count words in string |
| `StringKit.reading_time(str, wpm:)` | Estimate reading time in minutes |
| `StringKit.excerpt(str, phrase, radius:)` | Extract text around a phrase |
| `StringKit.squeeze(str)` | Remove consecutive duplicate characters |
| `StringKit.indent(str, n)` | Indent each line by n spaces |
| `StringKit.dedent(str)` | Remove common leading whitespace |
| `.strip_zero_width(str)` | Remove zero-width and invisible Unicode characters |
| `.levenshtein(a, b)` | Edit distance between two strings |
| `.similarity(a, b)` | 0.0–1.0 similarity derived from Levenshtein distance |

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## Support

If you find this project useful:

⭐ [Star the repo](https://github.com/philiprehberger/rb-string-kit)

🐛 [Report issues](https://github.com/philiprehberger/rb-string-kit/issues?q=is%3Aissue+is%3Aopen+label%3Abug)

💡 [Suggest features](https://github.com/philiprehberger/rb-string-kit/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement)

❤️ [Sponsor development](https://github.com/sponsors/philiprehberger)

🌐 [All Open Source Projects](https://philiprehberger.com/open-source-packages)

💻 [GitHub Profile](https://github.com/philiprehberger)

🔗 [LinkedIn Profile](https://www.linkedin.com/in/philiprehberger)

## License

[MIT](LICENSE)
