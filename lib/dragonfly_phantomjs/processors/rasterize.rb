require 'dragonfly_svg'
require 'json'

module DragonflyPhantomjs
  module Processors

    # ---------------------------------------------------------------------
    # This processor uses PhantomJs to convert .html or .svg documents to
    # .gif, .jpeg, .pdf or .png
    #
    # Incase of .svg file, the viewport_size is automatically set to the
    # dimensions in the .svg file, unless explicitly specified in options
    #
    # IMPORTANT: Requires +phantomjs (~> 1.9)+

    class Rasterize

      class UnsupportedFormat < RuntimeError; end

      # :margin         - {number, string}, defaults to 0, supported units are 'mm', 'cm', 'in', 'px'
      # :format         - {string}, defaults to 'A4', supported formats are 'A4', 'A3', 'A5', 'Legal', 'Letter', 'Tabloid'
      # :paper_size     - {string}, 'width*height', '300mm*300mm', supported units are 'mm', 'cm', 'in', 'px'
      # :viewport_size  - {string}, 'width*height', '1440*900'
      # :zoom_factor    - {number}, defaults to 1
      # :header         - {hash}, {height: '10mm', contents: 'foo', hide_on: [1] }
      # :footer         - {hash}, {height: '10mm', contents: 'foo', hide_on: [1] }

      def call content, format=:pdf, options={}
        raise UnsupportedFormat unless %w(gif jpeg pdf png).include?(format.to_s)
        content.shell_update(ext: format) do |old_path, new_path|
          if File.extname(old_path) == 'svg' && options[:viewport_size].blank?
            width = Dragonfly::Analysers::SvgAnalyser.new(content)[:width]
            height = Dragonfly::Analysers::SvgAnalyser.new.(content)[:height]
            options[:viewport_size] = "#{width.to_i}*#{height.to_i}"
          end
          "#{phantomjs_command} #{rasterize_script} #{old_path} #{new_path} '#{options.to_json}'"
        end
      end

      def update_url attrs, format, args=""
        attrs.ext = format.to_s
      end

      private # =============================================================

      def phantomjs_command
        "phantomjs"
      end

      def rasterize_script
        File.join(DragonflyPhantomjs.root, "script", "rasterize.js")
      end

    end
  end
end
