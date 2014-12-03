require 'dragonfly_phantomjs/processors/phantomjs_processor'

module DragonflyPhantomjs
  class Plugin

    def call app, opts={}
      app.add_processor :phantomjs, DragonflyPhantomjs::Processors::PhantomjsProcessor.new
    end

  end
end

Dragonfly::App.register_plugin(:phantomjs) { DragonflyPhantomjs::Plugin.new }