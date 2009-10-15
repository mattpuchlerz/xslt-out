require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'xml/xslt'
require 'htmlentities'

class XSLTOut
  
  attr_reader :errors, :output
  
  def initialize attributes
    @errors = []
    read_xml  attributes['xml']
    read_xslt attributes['xslt']
    parse
  end
  
  private 
  
  def parse
    return if not @xml or not @xslt or not @errors.empty?

    begin
      xslt = XML::XSLT.new
      xslt.xml = @xml
      xslt.xsl = @xslt
      html = HTMLEntities.new
      @output = html.encode xslt.serve#, :named
    rescue
      @errors << case $!
        when /XML/; 'Error parsing the XML file.'
        when /XSL/; 'Error parsing the XSLT file.'
        else $!
      end
    end
  end
  
  def read_xml file
    open(file) { |f| @xml = f.read } rescue @errors << 'URI given for the XML was invalid.'
    @errors << 'Could not read the XML file.' unless @xml
  end
  
  def read_xslt file
    open(file) { |f| @xslt = f.read } rescue @errors << 'URI given for the XSLT was invalid.'
    @errors << 'Could not read the XSLT file.' unless @xslt
  end
  
end



use_in_file_templates!

get '/' do
  erb :index
end

post '/' do
  @xsltout = XSLTOut.new params
  erb :out, :layout => !request.xhr?
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
    <script type="text/javascript">
      window.addEvent('domready', function() {
        new Autopilot( $('header').getElement('form'), { update: 'content' } );
      });
    </script>
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

<% unless @xsltout.errors.empty? %>
<div id="errors">
  <h2>Uh oh!</h2>
  <ul>
    <% @xsltout.errors.each do |error| %>
    <li><%= error %></li>
    <% end %>
  </ul>
</div>
<% end %>

<% if @xsltout.output %>
<pre id="out"><code><%= @xsltout.output %></code></pre>
<% end %>

