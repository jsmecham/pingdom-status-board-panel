require 'rack/ssl'
require './app'
use Rack::SSL
run Sinatra::Application
