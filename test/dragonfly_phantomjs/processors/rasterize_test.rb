require 'test_helper'

module DragonflyPhantomjs
  module Processors
    describe Rasterize do

      let(:app) { test_app.configure_with(:phantomjs) }
      let(:processor) { DragonflyPhantomjs::Processors::Rasterize.new }

      let(:html) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample.html')) }
      let(:svg) { Dragonfly::Content.new(app, SAMPLES_DIR.join('sample.svg')) }

      let(:html_string) { Dragonfly::Content.new(app, '<html><head></head><body>foo</body></html>', name: 'foo.html') }

      let(:options) {
        {
          margin: 0,
          format: 'A4',
          paper_size: '210mm*297mm',
          viewport_size: '1440*900',
          zoom_factor: 1,
          header: {
            height: '10mm',
            content: 'foo'
          },
          footer: {
            height: '10mm',
            content: 'foo'
          }
        }
      }

      describe 'html' do
        it 'returns PDF' do
          processor.call(html, :pdf)
          get_mime_type(html.path).must_include "application/pdf"
          assert is_pdf(html.data)
        end

        it 'returns PNG' do
          processor.call(html, :png, options)
          get_mime_type(html.path).must_include "image/png"
        end

        it 'returns GIF' do
          processor.call(html, :gif, options)
          get_mime_type(html.path).must_include "image/gif"
        end

        it 'returns JPEG' do
          processor.call(html, :jpeg, options)
          get_mime_type(html.path).must_include "image/jpeg"
        end
      end

      describe 'svg' do
        it 'returns PDF' do
          processor.call(svg, :pdf, options)
          get_mime_type(svg.path).must_include "application/pdf"
          assert is_pdf(svg.data)
        end

        it 'returns PNG' do
          processor.call(svg, :png, options)
          get_mime_type(svg.path).must_include "image/png"
        end

        it 'returns GIF' do
          processor.call(svg, :gif, options)
          get_mime_type(svg.path).must_include "image/gif"
        end

        it 'returns JPEG' do
          processor.call(svg, :jpeg, options)
          get_mime_type(svg.path).must_include "image/jpeg"
        end
      end

      describe 'string' do
        it 'returns PDF' do
          obj = '<html><head></head><body>foo</body></html>'
          def obj.original_filename; 'something.html'; end
          html_string.update(obj)
          processor.call(html_string, :pdf)
          get_mime_type(html_string.path).must_include "application/pdf"
          assert is_pdf(html_string.data)
        end
      end

      # ---------------------------------------------------------------------

      def is_pdf data
        data =~ /\A%PDF-1.4/
      end

      def get_mime_type file_path
        `file --mime-type #{file_path}`.gsub(/\n/, "")
      end

    end
  end
end