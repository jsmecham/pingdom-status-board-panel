
require "base64"
require "multi_json"
require "open-uri"
require "sass"
require "sinatra"
require "sinatra/json"
require "sinatra/reloader" if development?

# Credentials -----------------------------------------------------------------

set :email, ""
set :password, ""
set :app_key, ""

# Configuration ---------------------------------------------------------------

set :styles_path, "#{File.dirname(__FILE__)}/public/styles"

# Checks ----------------------------------------------------------------------

get "/check/:check_id" do |check_id|

  app_key       = params[:app_key] || settings.app_key
  authorization = Base64.encode64("#{settings.email}:#{settings.password}")

  # Request Check Detail from Pingdom API
  @check = open("https://api.pingdom.com/api/2.0/checks/#{check_id}", "App-Key" => app_key, "Authorization" => "Basic #{authorization}") do |response|
    MultiJson.load(response.read)["check"]
  end

  haml :check

end

# Process Assets --------------------------------------------------------------

get "/styles/:stylesheet.css" do |stylesheet|
  content_type "text/css"
  template = File.read(File.join(settings.styles_path, "#{stylesheet}.sass"))
  Sass::Engine.new(template).render
end
