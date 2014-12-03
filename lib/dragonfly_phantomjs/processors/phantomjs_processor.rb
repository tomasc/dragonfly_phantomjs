require 'dragonfly_svg'

module DragonflyPhantomjs
  module Processors

    # ---------------------------------------------------------------------
    # This processor uses PhantomJs to convert .html or .svg documents to
    # .gif, .jpeg, .pdf or .png
    #
    # Incase of .svg file, the viewport_size is automatically set to the
    # dimensions in the .svg file, unless explicitly specified in options
    #
    # IMPORTANT: Requires +phantomjs+

    class PhantomjsProcessor

      # @param [Dragonfly::Content]
      # @param [Symbol] format
      # @param [Hash] options
      #   :border         - {number, string}, defaults to 0, supported units are 'mm', 'cm', 'in', 'px'
      #   :format         - {string}, defaults to 'A4', supported formats are 'A4', 'A3', 'A5', 'Legal', 'Letter', 'Tabloid'
      #   :paper_size     - {string}, 'width*height', '300mm*300mm', supported units are 'mm', 'cm', 'in', 'px'
      #   :viewport_size  - {string}, 'width*height', '1440*900'
      #   :zoom_factor    - {number}, defaults to 1
      # @return [Array]
      def call content, format=:pdf, *args
        throw :unable_to_handle unless [:gif, :jpeg, :pdf, :png].include?(format)

        mime_type = content.mime_type

        ext = case
        when mime_type =~ /html/ then :html
        when mime_type =~ /svg/ then :svg
        end

        throw :unable_to_handle unless ["text/html", "image/svg+xml"].include?(mime_type)

        # FIXME: bit of a hack, as PhantomJS (1.9) requires the file extension to be set
        tempfile_orig = Dragonfly::TempObject.new(content)
        tempfile = Dragonfly::TempObject.new(format)

        if ext == :svg && options[:viewport_size].blank?
          width = Dragonfly::Analysers::SvgAnalyser.new(content)['width']
          height = Dragonfly::Analysers::SvgAnalyser.new.(content)['width']
          options[:viewport_size] = "#{width.to_i}*#{height.to_i}"
        end

        phantom_js_command "rasterize.coffee", content, tempfile, options

        [
          tempfile,
          { name: "#{content.basename}.#{format}", size: tempfile.size, format: format }
        ]
      end

      private # =============================================================

      def phantom_js_command script_name, input_file, output_file, options={}
        run "phantomjs #{DragonflyPhantomjs.root}/script/#{script_name} #{input_file.path} #{output_file.path} '#{options.to_json}'"
      end

    end
  end
end