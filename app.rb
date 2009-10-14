require 'rubygems'
require 'sinatra'
require 'xml/xslt'

use_in_file_templates!

get '/' do
  erb :index
end



__END__



@@ layout

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
  	<title>untitled</title>
  	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  </head>
  <body>
    <%= yield %>
  </body>
</html>



@@ index

<h1>XSLT Out</h1>