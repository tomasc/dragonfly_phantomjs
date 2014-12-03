require 'test_helper'

module DragonflyPhantomjs
  describe Plugin do

    let(:app) { test_app.configure_with(:phantomjs) }
    let(:svg) { app.fetch_file(SAMPLES_DIR.join('sample.svg')) }

    # ---------------------------------------------------------------------

    describe 'processors' do
      it 'adds #phantomjs' do
        svg.must_respond_to :phantomjs
      end
    end

  end
end