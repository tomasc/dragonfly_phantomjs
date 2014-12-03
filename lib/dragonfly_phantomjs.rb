require "dragonfly_phantomjs/phantom_js_encoder"
require "dragonfly_phantomjs/version"

module DragonflyPhantomjs
  def self.root
    File.expand_path '../..', __FILE__
  end
end
