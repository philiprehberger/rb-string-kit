# Changelog

All notable changes to this gem will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this gem adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.0] - 2026-04-25

### Added
- `StringKit.strip_zero_width` removes zero-width and invisible Unicode characters
- `StringKit.levenshtein` returns Levenshtein edit distance between two strings
- `StringKit.similarity` returns a 0.0–1.0 similarity score derived from Levenshtein distance

## [0.2.1] - 2026-04-15

### Fixed
- Align issue templates with guide: add required `gem-version` input to bug report and `alternatives` textarea plus code placeholder to feature request
- Pin `actions/checkout` to `v5` in CI workflow to match guide

## [0.2.0] - 2026-04-03

### Added
- Add `slug` method for URL-safe slug generation with custom separator support
- Add `pad` method for left, right, and center string padding
- Add `transliterate` method to replace accented/diacritical characters with ASCII equivalents
- Add `dot_case` method for dot.case conversion
- Add `path_case` method for path/case conversion
- Add `reverse_case` method to swap upper and lower case characters

## [0.1.6] - 2026-03-31

### Added
- Add GitHub issue templates, dependabot config, and PR template

## [0.1.5] - 2026-03-31

### Changed
- Standardize README badges, support section, and license format

## [0.1.4] - 2026-03-26

### Changed

- Add Sponsor badge and fix License link format in README

## [0.1.3] - 2026-03-24

### Fixed
- Standardize README code examples to use double-quote require statements
- Remove inline comments from Development section to match template

## [0.1.2] - 2026-03-24

### Fixed
- Fix Installation section quote style to double quotes

## [0.1.1] - 2026-03-22

### Changed
- Update rubocop configuration for Windows compatibility

## [0.1.0] - 2026-03-22

### Added

- Initial release
- Case conversion: titlecase, kebab_case, camel_case, pascal_case, snake_case, constant_case
- HTML stripping and whitespace normalization
- Word counting and reading time estimation
- Excerpt extraction around a phrase
- String squeeze, indent, and dedent utilities
