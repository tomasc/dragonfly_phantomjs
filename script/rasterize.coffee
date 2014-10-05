


fs = require('fs')
system = require('system')



# ---------------------------------------------------------------------



input = system.args[1]
output = system.args[2]

if options_json = system.args[3]
  options = JSON.parse options_json
else
  options = {}



# ---------------------------------------------------------------------



border = options['border'] || 0
format = options['format'] || 'A4'
paper_size = options['paper_size']
viewport_size = options['viewport_size']
zoom_factor = options['zoom_factor'] || 1
user_agent = options['user_agent']
referer = options['referer']
element_id = options['element_id']



# ---------------------------------------------------------------------



page = require('webpage').create()
page.settings.userAgent = options['user_agent'] if user_agent
page.customHeaders = { 'Referer': options['referer'] } if referer



# ---------------------------------------------------------------------



if output.substr(-4) is ".pdf"
  if paper_size != undefined
    page_width = paper_size.split('*')[0]
    page_height = paper_size.split('*')[1]
    page.paperSize = { width: page_width, height: page_height, border: border }

  else if format != undefined
    page.paperSize = { format: format, border: border }

if viewport_size != undefined
  viewport_width = viewport_size.split('*')[0]
  viewport_height = viewport_size.split('*')[1]
  page.viewportSize = { width: viewport_width, height: viewport_height }

page.zoomFactor = zoom_factor



# ---------------------------------------------------------------------



page.open input, ->
  if element_id
    page.clipRect = page.evaluate ->
      document.getElementById('demo').getBoundingClientRect()
  page.render(output)
  phantom.exit()


