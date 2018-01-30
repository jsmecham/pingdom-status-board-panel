#
# Load Dependencies
#
Bundler.require(:default, ENV["RACK_ENV"])

#
# Force SSL to be used, in Production.
#
use Rack::SSL if production?

#
# Run the Sinatra app!
#
require "./app"
run Sinatra::Application
