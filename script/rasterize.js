var border, element_id, footer, format, fs, header, input, margin, options, options_json, output, page, page_height, page_width, paper_size, referer, system, user_agent, viewport_height, viewport_size, viewport_width, zoom_factor;

fs = require('fs');
system = require('system');
input = system.args[1];
output = system.args[2];

if (options_json = system.args[3]) {
  options = JSON.parse(options_json);
} else {
  options = {};
}

margin = options['margin'] || 0;
border = options['border'] || 0;
format = options['format'] || 'A4';
paper_size = options['paper_size'];
viewport_size = options['viewport_size'];
zoom_factor = options['zoom_factor'] || 1;
user_agent = options['user_agent'];
referer = options['referer'];
element_id = options['element_id'];

header = options['header'] ? {
  height: options['header']['height'],
  contents: phantom.callback(function(pageNum, numPages) {
    if ((options['header']['hide_on'] || []).indexOf(pageNum) > -1) {
      return "";
    }
    return eval(options['header']['content']);
  })
} : null;

footer = options['footer'] ? {
  height: options['footer']['height'],
  contents: phantom.callback(function(pageNum, numPages) {
    if ((options['footer']['hide_on'] || []).indexOf(pageNum) > -1) {
      return "";
    }
    return eval(options['footer']['content']);
  })
} : null;

page = require('webpage').create();

if (user_agent) {
  page.settings.userAgent = options['user_agent'];
}

if (referer) {
  page.customHeaders = {
    'Referer': options['referer']
  };
}

if (output.substr(-4) === ".pdf") {
  if (paper_size !== void 0) {
    page_width = paper_size.split('*')[0];
    page_height = paper_size.split('*')[1];
    page.paperSize = {
      width: page_width,
      height: page_height,
      margin: margin,
      border: border,
      header: header,
      footer: footer
    };
  } else if (format !== void 0) {
    page.paperSize = {
      format: format,
      margin: margin,
      border: border,
      header: header,
      footer: footer
    };
  }
}

if (viewport_size !== void 0) {
  viewport_width = viewport_size.split('*')[0];
  viewport_height = viewport_size.split('*')[1];
  page.viewportSize = {
    width: viewport_width,
    height: viewport_height
  };
}

page.zoomFactor = zoom_factor;

page.open(input, function() {
  if (element_id) {
    page.clipRect = page.evaluate(function() {
      return document.getElementById('demo').getBoundingClientRect();
    });
  }
  page.render(output);
  return phantom.exit();
});