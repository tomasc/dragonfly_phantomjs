require 'test_helper'

module DragonflyPhantomjs
  module Processors
    describe Rasterize do

      let(:app) { test_app.configure_with(:svg) }
      let(:processor) { DragonflyPhantomjs::Processors::Rasterize.new }

      let(:html) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample.html')) }
      let(:svg) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample.svg')) }

      let(:options) {
        {
          border: 0,
          format: 'A4',
          paper_size: '210mm*297mm',
          viewport_size: '1440*900',
          zoom_factor: 1
        }
      }

      describe 'html' do
        it 'returns PDF' do
          result = processor.call(html, :pdf, options)
          get_mime_type(result.path).must_include "application/pdf"
        end

        it 'returns PNG' do
          result = processor.call(html, :png, options)
          get_mime_type(result.path).must_include "image/png"
        end

        it 'returns GIF' do
          result = processor.call(html, :gif, options)
          get_mime_type(result.path).must_include "image/gif"
        end

        it 'returns JPEG' do
          result = processor.call(html, :jpeg, options)
          get_mime_type(result.path).must_include "image/jpeg"
        end
      end

      describe 'svg' do
        it 'returns PDF' do
          result = processor.call(svg, :pdf, options)
          get_mime_type(result.path).must_include "application/pdf"
        end

        it 'returns PNG' do
          result = processor.call(svg, :png, options)
          get_mime_type(result.path).must_include "image/png"
        end

        it 'returns GIF' do
          result = processor.call(svg, :gif, options)
          get_mime_type(result.path).must_include "image/gif"
        end

        it 'returns JPEG' do
          result = processor.call(svg, :jpeg, options)
          get_mime_type(result.path).must_include "image/jpeg"
        end
      end

      # ---------------------------------------------------------------------

      def get_mime_type file_path
        `file -Ib #{file_path}`.gsub(/\n/, "")
      end

    end
  end
end