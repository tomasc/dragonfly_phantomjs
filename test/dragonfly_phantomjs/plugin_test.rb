require 'test_helper'

module DragonflyPhantomjs
  describe Plugin do

    let(:app) { test_app.configure_with(:phantomjs) }
    let(:html) { app.fetch_file(SAMPLES_DIR.join('sample.html')) }
    let(:svg) { app.fetch_file(SAMPLES_DIR.join('sample.svg')) }

    # ---------------------------------------------------------------------

    describe 'processors' do
      it 'adds #rasterize' do
        html.must_respond_to :rasterize
        svg.must_respond_to :rasterize
      end
    end

  end
end