# Jekyll Issue Mentions

Github #issueid mention support for your Jekyll site

[![Gem Version](https://badge.fury.io/rb/jekyll-issue-mentions.png)](http://badge.fury.io/rb/jekyll-issue-mentions)
[![Build Status](https://travis-ci.org/workato/jekyll-issue-mentions.svg?branch=master)](https://travis-ci.org/workato/jekyll-issue-mentions)

## Usage

Add the following to your site's `Gemfile`

```
gem 'jekyll-issue-mentions'
```

And add the following to your site's `_config.yml`

```yml
gems:
  - jekyll-issue-mentions
```

In any page or post, use #issueid as you would normally, e.g.

```markdown
Can you look at issue #1 today?
```

Will be converted to 

> Can you look at issue [#1](https://github.com/workato/jekyll-issue-mentions/issues/1) today?

## Configuration

Set the Github repo issue url:

```yaml
jekyll-issue-mentions:
  base_url: https://github.com/workato/jekyll-issue-mentions/issues
```

Or, you can use this shorthand:

```yaml
jekyll-issue-mentions: https://github.com/workato/jekyll-issue-mentions/issues
```
