require 'dragonfly/analysis/file_command_analyser'
require 'dragonfly/analysis/svg_analyser'



module Dragonfly
  module Encoders

    # IMPORTANT: Requires +phantomjs+

    class PhantomJsEncoder



      include Dragonfly::Configurable
      include Dragonfly::Shell
      include Dragonfly::Utils



      # ---------------------------------------------------------------------
      # This encoder uses PhantomJs to convert .html or .svg documents to
      # .gif, .jpeg, .pdf or .png
      # 
      # Incase of .svg file, the viewport_size is automatically set to the
      # dimensions in the .svg file, unless explicitly specified in options



      # @param [Dragonfly::Tempfile]
      # @param [Symbol] format
      # @param [Hash] options
      #   :border         - {number, string}, defaults to 0, supported units are 'mm', 'cm', 'in', 'px'
      #   :format         - {string}, defaults to 'A4', supported formats are 'A4', 'A3', 'A5', 'Legal', 'Letter', 'Tabloid'
      #   :paper_size     - {string}, 'width*height', '300mm*300mm', supported units are 'mm', 'cm', 'in', 'px'
      #   :viewport_size  - {string}, 'width*height', '1440*900'
      #   :zoom_factor    - {number}, defaults to 1
      # @return [Array]
      def encode temp_object, format=:pdf, options={}
        throw :unable_to_handle unless [:gif, :jpeg, :pdf, :png].include?(format)

        mime_type = Dragonfly::Analysis::FileCommandAnalyser.new.mime_type(temp_object)

        ext = case
        when mime_type =~ /html/ then :html
        when mime_type =~ /svg/ then :svg
        end

        throw :unable_to_handle unless ["text/html", "image/svg+xml"].include?(mime_type)

        # FIXME: bit of a hack, as PhantomJS (1.9) requires the file extension to be set
        tempfile_orig = new_tempfile(ext, temp_object.data)
        tempfile = new_tempfile(format)

        # in case we convert SVG, and view_port not set, set SVG dimensions from file
        if ext == :svg && options[:viewport_size].blank?
          width = Dragonfly::Analysers::SvgAnalyser.new.width tempfile_orig
          height = Dragonfly::Analysers::SvgAnalyser.new.height tempfile_orig
          options[:viewport_size] = "#{width.to_i}*#{height.to_i}"
        end

        phantom_js_command "rasterize.coffee", tempfile_orig, tempfile, options

        [
          tempfile,
          { name: "#{temp_object.basename}.#{format}", size: tempfile.size, format: format }
        ]
      end



      private # =============================================================



      def phantom_js_command script_name, input_file, output_file, options={}
        run "phantomjs #{DragonflyPhantomjs.root}/script/#{script_name} #{input_file.path} #{output_file.path} '#{options.to_json}'"
      end



      # ---------------------------------------------------------------------



    end
  end
end