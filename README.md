# Dragonfly PhantomJS

This [Dragonfly](https://github.com/markevans/dragonfly) plugin uses [PhantomJS](https://github.com/ariya/phantomjs) headless browser to convert `HTML` or `SVG` documents to `GIF`, `JPEG`, `PDF` or `PNG`

If passed an `SVG` and the `viewport_size` is not specified in the options, the `viewport_size` is automatically set to the dimensions of the `SVG` file.

IMPORTANT: Requires [PhantomJS](http://phantomjs.org)

## Installation

Add this line to your application's Gemfile:

    gem 'dragonfly_phantomjs'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dragonfly_phantomjs

## Usage

Add the plugin to Dragonfly:

```ruby
Dragonfly.app.configure do
  plugin :svg
end
```

## Rasterize

```ruby
html.rasterize(format, options)
svg.rasterize(format, options)
```

Formats: `:gif`, `:jpeg`, `:pdf`, `:png`
Options:
```Ruby
  :border         - {number, string}, defaults to 0, supported units are 'mm', 'cm', 'in', 'px'
  :format         - {string}, defaults to 'A4', supported formats are 'A4', 'A3', 'A5', 'Legal', 'Letter', 'Tabloid'
  :paper_size     - {string}, 'width*height', '300mm*300mm', supported units are 'mm', 'cm', 'in', 'px'
  :viewport_size  - {string}, 'width*height', '1440*900'
  :zoom_factor    - {number}, defaults to 1
``

## Contributing

1. Fork it ( https://github.com/tomasc/dragonfly_phantomjs/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
