#
# Pingdom Status Board Panel
#

require "sinatra/reloader" if development?
require "base64"
require "json"
require "open-uri"

# Configuration --------------------------------------------------------------

configure do

  set :email, ENV["PINGDOM_EMAIL"]
  set :password, ENV["PINGDOM_PASSWORD"]
  set :app_key, ENV["PINGDOM_APP_KEY"] || ""
  set :styles_path, "#{File.dirname(__FILE__)}/public/styles"
  set :scripts_path, "#{File.dirname(__FILE__)}/public/scripts"
  set :session_secret, ENV["SESSION_SECRET"] unless ENV["SESSION_SECRET"].nil?

end

# -----------------------------------------------------------------------------

get "/" do
end

# Checks ----------------------------------------------------------------------

get "/check/:check_id" do |check_id|

  app_key       = params[:app_key] || settings.app_key
  authorization = Base64.encode64("#{settings.email}:#{settings.password}")
  headers       = { "App-Key" => app_key, "Authorization" => "Basic #{authorization}" }

  # Request Check Detail from Pingdom API
  @check = open("https://api.pingdom.com/api/2.0/checks/#{check_id}", headers) do |response|
    JSON.parse(response.read)["check"]
  end

  if request.xhr?
    haml :check, :layout => false
  else
    haml :check
  end

end

# Process Assets -------------------------------------------------------------

get "/styles/:stylesheet.css" do |stylesheet|
  content_type "text/css"
  template = File.read(File.join(settings.styles_path, "#{stylesheet}.sass"))
  Sass::Engine.new(template).render
end

get "/scripts/:script.js" do |script|
  content_type "application/javascript"
  template = File.read(File.join(settings.scripts_path, "#{script}.coffee"))
  CoffeeScript.compile(template)
end
