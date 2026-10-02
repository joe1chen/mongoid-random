# Changelog

All notable changes to this project are documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- CI: test Mongoid 7.5 with Ruby driver 2.26 against MongoDB 8.0 (Ruby 2.7 / Rails 6.1).

## [0.2.0] - 2026-10-01
DOGOnews fork. Minor version: the minimum supported Mongoid is unchanged (3.0) and the library code is unchanged;
the release adds an upper bound, CI and documentation.

### Added
- Tested on Mongoid 7, 8 and 9: GitHub Actions test matrix (`.github/workflows/test.yml`), seven rows from
  Ruby 2.7 / Rails 6.1 / Mongoid 7.5 / MongoDB 6.0 to Ruby 3.4 / Rails 8.0 / Mongoid 9.0 / MongoDB 8.0. The
  `Gemfile` selects Rails and Mongoid from `RAILS_VERSION` / `MONGOID_VERSION` (defaults 6.1 / 7.5).
- GitHub Release workflow (`.github/workflows/release.yml`): pushing a `vX.Y.Z` tag creates a GitHub Release
  with this file's section as the notes.

### Changed
- Runtime dependency `mongoid >= 3.0.0, < 10` (was `>= 3.0.0`).
- Specs run on a plain RSpec 3.13 harness with `database_cleaner-mongoid` (was `rspec >= 2.13.0` with Spork,
  Guard and `database_cleaner`).
- The gemspec `homepage` points to this fork.
- README written for the maintained fork (supported versions, `random` semantics, indexing and backfilling
  notes); history moved to this file.

### Removed
- Travis CI configuration, `Guardfile`, and the `guard`, `guard-rspec`, `guard-spork` and `listen` development
  dependencies.

## [0.1.1] - 2018-06-01
### Changed
- Specs run with `rake` (`rake` added as a development dependency) and on Travis CI against Mongoid 3, 4 and 5.

## [0.1.0] - 2013-04-23
### Changed
- Requires Ruby 1.9.3 and Mongoid 3: runtime dependency `mongoid >= 3.0.0` (was `>= 2.0.0`).
- Specs moved from minitest to RSpec.

### Removed
- The automatic index on `_randomization_key` (declare `index({ _randomization_key: 1 })` in the model).

## [0.0.1] - 2011-11-02
### Added
- Initial release by Dave Krupinski: `include Mongoid::Random` adds a `_randomization_key` set on create and
  `Model.random(count = 1, random_key = rand)`, a criteria for `count` documents chosen by comparing the key.

[Unreleased]: https://github.com/joe1chen/mongoid-random/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/joe1chen/mongoid-random/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/joe1chen/mongoid-random/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/joe1chen/mongoid-random/compare/v0.0.1...v0.1.0
[0.0.1]: https://github.com/joe1chen/mongoid-random/releases/tag/v0.0.1
