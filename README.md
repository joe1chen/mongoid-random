# mongoid-random

[![CI RSpec Test](https://github.com/joe1chen/mongoid-random/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/joe1chen/mongoid-random/actions/workflows/test.yml)

Random document retrieval for **Mongoid**. Including `Mongoid::Random` gives every new document a random
`_randomization_key` (a float in `[0, 1)`), and `Model.random(n)` returns a criteria for `n` documents picked
by comparing that key against a fresh random number — no `$sample` aggregation and no `skip` over the
whole collection.

This is the [DOGOnews](https://www.dogonews.com)-maintained fork of
[davekrupinski/mongoid-random](https://github.com/davekrupinski/mongoid-random) (upstream has been inactive since
2013, though not archived). It is kept working on current Ruby, Rails, Mongoid and MongoDB versions.

## Supported versions

Tested on every push by the [GitHub Actions matrix](https://github.com/joe1chen/mongoid-random/actions/workflows/test.yml)
([workflow](.github/workflows/test.yml)):

| Ruby | Rails | Mongoid | MongoDB |
|---|---|---|---|
| 2.7 | 6.1 | 7.5 | 6.0 |
| 3.0 | 6.1 | 8.0 | 6.0 |
| 3.1 | 7.0 | 8.1 | 7.0 |
| 3.2 | 7.1 | 8.1 | 7.0 |
| 3.2 | 7.2 | 9.0 | 7.0 |
| 3.3 | 7.2 | 9.0 | 8.0 |
| 3.4 | 8.0 | 9.0 | 8.0 |

The gemspec allows `mongoid >= 3.0, < 10`; only the versions above are tested.

## Installation

This fork is not published to RubyGems; install it from GitHub, pinned to a release tag
([releases](https://github.com/joe1chen/mongoid-random/releases)). The gem name is `mongoid-random`:

```ruby
# Gemfile
gem 'mongoid-random', github: 'joe1chen/mongoid-random', tag: 'v0.2.0'
```

Then `bundle install`.

## Usage

```ruby
class Article
  include Mongoid::Document
  include Mongoid::Random

  # recommended, so the range queries in .random use an index
  index({ _randomization_key: 1 })
end
```

`Mongoid::Random` adds a `_randomization_key` field (`Float`) and sets it in a `before_create` callback.

```ruby
Article.random            # criteria for 1 random article
Article.random.first      # the article itself
Article.random(5).to_a    # up to 5 random articles
Article.random(5, 0.42)   # use a given key instead of rand (e.g. for reproducible results)
```

`random(count = 1, random_key = rand)` returns a `Mongoid::Criteria` limited to `count` documents. It selects
documents whose key is `>= random_key` if there are at least `count` of them, otherwise those with a key
`<= random_key`, otherwise every document that has a key; the result is ordered by `_id` or
`_randomization_key`, ascending or descending, chosen at random.

Notes:

- Only documents **created** after `Mongoid::Random` was included get a key. Documents that already existed
  have `_randomization_key: nil` and are never returned by `random`; backfill them, e.g.
  `Article.where(_randomization_key: nil).each { |a| a.set(_randomization_key: rand) }`.
- The selection is cheap but not uniformly random: the documents returned are the first `count` of the
  matching range in the chosen sort order, so documents next to a large gap in the key space, and the
  oldest/newest documents (when sorting by `_id`), are picked more often. Use `$sample` when uniformity matters.

## Development

```bash
# needs a MongoDB on localhost:27017 (e.g. docker run -p 27017:27017 mongo:8.0)
MONGOID_VERSION=9.0 RAILS_VERSION=8.0 bundle install
MONGOID_VERSION=9.0 RAILS_VERSION=8.0 bundle exec rspec spec
```

`MONGOID_VERSION` and `RAILS_VERSION` select the versions in the `Gemfile` (defaults: Mongoid 7.5, Rails 6.1).
To add a combination to CI, add a row to `matrix.include` in `.github/workflows/test.yml`.

## History

Dave Krupinski's original (2011, released to RubyGems as 0.0.1 and 0.1.0 for Mongoid 3 in 2013) was continued by
DOGOnews in this fork: 0.1.1 (2018: specs running on Mongoid 3–5), then 0.2.0 (2026: tested on Mongoid 7.5–9.x
with current Ruby/Rails/MongoDB by a GitHub Actions matrix, plain RSpec 3.13 harness).
See [CHANGELOG.md](CHANGELOG.md).

## Credits

- Dave Krupinski — original author
- [Contributors](https://github.com/joe1chen/mongoid-random/graphs/contributors)
