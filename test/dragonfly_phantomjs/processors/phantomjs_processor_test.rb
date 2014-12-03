require 'test_helper'

module DragonflyPhantomjs
  module Processors
    describe PhantomjsProcessor do

      let(:app) { test_app.configure_with(:svg) }
      let(:processor) { DragonflyPhantomjs::Processors::PhantomjsProcessor.new }
      let(:svg) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample.svg')) }

    end
  end
end