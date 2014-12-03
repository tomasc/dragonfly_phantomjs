require "dragonfly_phantomjs/phantomjs_processor"
require "dragonfly_phantomjs/version"

module DragonflyPhantomjs
  def self.root
    File.expand_path '../..', __FILE__
  end
end
