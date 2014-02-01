# philiprehberger-string_kit

[![Tests](https://github.com/philiprehberger/rb-string-kit/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/rb-string-kit/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/philiprehberger-string_kit.svg)](https://rubygems.org/gems/philiprehberger-string_kit)
[![License](https://img.shields.io/github/license/philiprehberger/rb-string-kit)](LICENSE)

Comprehensive string utilities without ActiveSupport dependency

## Requirements

- Ruby >= 3.1

## Installation

Add to your Gemfile:

```ruby
gem 'philiprehberger-string_kit'
```

Or install directly:

```bash
gem install philiprehberger-string_kit
```

## Usage

```ruby
require 'philiprehberger/string_kit'

Philiprehberger::StringKit.titlecase('hello world')       # => "Hello World"
Philiprehberger::StringKit.kebab_case('helloWorld')        # => "hello-world"
Philiprehberger::StringKit.camel_case('hello world')       # => "helloWorld"
Philiprehberger::StringKit.pascal_case('hello world')      # => "HelloWorld"
Philiprehberger::StringKit.snake_case('Hello World')       # => "hello_world"
Philiprehberger::StringKit.constant_case('hello world')    # => "HELLO_WORLD"
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

## API

| Method | Description |
|--------|-------------|
| `StringKit.titlecase(str)` | Convert string to Title Case |
| `StringKit.kebab_case(str)` | Convert string to kebab-case |
| `StringKit.camel_case(str)` | Convert string to camelCase |
| `StringKit.pascal_case(str)` | Convert string to PascalCase |
| `StringKit.snake_case(str)` | Convert string to snake_case |
| `StringKit.constant_case(str)` | Convert string to CONSTANT_CASE |
| `StringKit.strip_html(str)` | Remove HTML tags from string |
| `StringKit.normalize_whitespace(str)` | Collapse whitespace to single spaces |
| `StringKit.word_count(str)` | Count words in string |
| `StringKit.reading_time(str, wpm:)` | Estimate reading time in minutes |
| `StringKit.excerpt(str, phrase, radius:)` | Extract text around a phrase |
| `StringKit.squeeze(str)` | Remove consecutive duplicate characters |
| `StringKit.indent(str, n)` | Indent each line by n spaces |
| `StringKit.dedent(str)` | Remove common leading whitespace |

## Development

```bash
bundle install
bundle exec rspec      # Run tests
bundle exec rubocop    # Check code style
```

## License

MIT
