require 'dragonfly_phantomjs/processors/rasterize'

module DragonflyPhantomjs
  class Plugin

    def call app, opts={}
      app.add_processor :rasterize, DragonflyPhantomjs::Processors::Rasterize.new
    end

  end
end

Dragonfly::App.register_plugin(:phantomjs) { DragonflyPhantomjs::Plugin.new }