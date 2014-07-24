# RFSP

Loads RSS from www.fl.ru, www.weblancer.net, freelansim.ru and normalize project info.

## Installation

    $ gem install rfsp

## Usage

```ruby

projects = RFSP::Fl.parse_rss
projects = RFSP::Weblancer.parse_rss
projects = RFSP::Freelansim.parse_rss
```

Project contains info:

1. `uri`
1. `id`
1. `published`
1. `title`
1. `body`
1. `category` - ex. `Дизайн / Логотипы, Дизайн / Фирменный стиль`, not availiable for freelansim.ru
1. `budget`
    1. `origin` - originally parsed string
    2. `amount` - integer
    3. `currency` - ex. 'rur, 'usd'
1. `tags` - only for freelansim.ru

For freelansim to get budget and tags you should call `RFSP::Freelansim.parse_page project` - it'll get info from project page.

Each class have methods:

* `::feed` - returns feed parsed by Feedjira
* `::update` - reloads cached feed
