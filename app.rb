require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'xml/xslt'
require 'htmlentities'

use_in_file_templates!

before do
  @errors = []
end

get '/' do
  erb :index
end

post '/' do
  open(params['xml'])  { |file| @xml  = file.read } rescue @errors << 'URI given for the XML was invalid.'
  open(params['xslt']) { |file| @xslt = file.read } rescue @errors << 'URI given for the XSLT was invalid.'
  
  @errors << 'Could not read the XML file.'  if not @xml
  @errors << 'Could not read the XSLT file.' if not @xslt

  if @errors.empty?
    begin
      xslt = XML::XSLT.new
      xslt.xml = @xml
      xslt.xsl = @xslt
      html = HTMLEntities.new
      @out = html.encode xslt.serve#, :named
    rescue
      @errors << 'Error parsing the XML or XSLT file.'
    end
  end
  
  erb :out
end



__END__



@@ layout

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>XSLT Out</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="/styles.css" media="screen" />
    <script type="text/javascript" src="/mootools-1.2.3-core-yc.js"></script>
    <script type="text/javascript" src="/autopilot.js"></script>
  </head>
  <body>
    <div id="header">
      <h1>XSLT Out</h1>
      <form action="/" method="post">
        <% %w[ xml xslt ].each do |field| %>
        <dl>
          <dt><label for="<%= field %>"><%= field.upcase %></label></dt>
          <dd><input type="text" name="<%= field %>" value="<%= params[field] || 'http://' %>" /></dd>
        </dl>
        <% end %>
        <p><input type="submit" value="Get the Output!" /></p>
      </form>
    </div>
    <div id="content">
      <%= yield %>
    </div>
  </body>
</html>



@@ index

<p>Just fill in the <em>xml</em> and <em>xslt</em> fields above, and <strong>get the output!</strong></p>
<p>If you&rsquo;re feeling really saucy, you can turn on <em>autopilot</em>.</p>



@@ out

<% unless @errors.empty? %>
<div id="errors">
  <h2>Uh oh!</h2>
  <ul>
    <% @errors.each do |error| %>
    <li><%= error %></li>
    <% end %>
  </ul>
</div>
<% end %>

<% if @out %>
<pre id="out"><code><%= @out %></code></pre>
<% end %>

