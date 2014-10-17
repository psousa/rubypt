require "rubygems"
require 'rack/contrib'
require 'rack-rewrite'
DOMAIN = 'www.ruby-pt.org'
 

use Rack::Static, 
  :urls => ["/css", "/img"],
  :root => "public"
use Rack::ETag
use Rack::Rewrite do
  rewrite '/', '/index.html'
  r301 %r{.*}, "http://#{DOMAIN}$&", :if => Proc.new {|rack_env|
    rack_env['SERVER_NAME'] != DOMAIN && ENV['RACK_ENV'] == "production"
  }
end
run Rack::Directory.new('public')