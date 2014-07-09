# DragonflyPhantomjs

This encoder uses PhantomJs to convert .html or .svg documents to .gif, .jpeg, .pdf or .png

In case of .svg file, the viewport_size is automatically set to the dimensions in the .svg file, unless explicitly specified in options

IMPORTANT: Requires [PhantomJS](http://phantomjs.org)

## Installation

Add this line to your application's Gemfile:

    gem 'dragonfly_phantomjs'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dragonfly_phantomjs

## Usage

@param [Dragonfly::Tempfile]
@param [Symbol] format
@param [Hash] options
  :border         - {number, string}, defaults to 0, supported units are 'mm', 'cm', 'in', 'px'
  :format         - {string}, defaults to 'A4', supported formats are 'A4', 'A3', 'A5', 'Legal', 'Letter', 'Tabloid'
  :paper_size     - {string}, 'width*height', '300mm*300mm', supported units are 'mm', 'cm', 'in', 'px'
  :viewport_size  - {string}, 'width*height', '1440*900'
  :zoom_factor    - {number}, defaults to 1
@return [Array]
def encode temp_object, format=:pdf, options={}

## Contributing

1. Fork it ( https://github.com/[my-github-username]/dragonfly_phantomjs/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
