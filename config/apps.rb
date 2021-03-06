##
# This file mounts each app in the Padrino project to a specified sub-uri.
# You can mount additional applications using any of these commands below:
#
#   Padrino.mount("blog").to('/blog')
#   Padrino.mount("blog", :app_class => "BlogApp").to('/blog')
#   Padrino.mount("blog", :app_file =>  "path/to/blog/app.rb").to('/blog')
#
# You can also map apps to a specified host:
#
#   Padrino.mount("Admin").host("admin.example.org")
#   Padrino.mount("WebSite").host(/.*\.?example.org/)
#   Padrino.mount("Foo").to("/foo").host("bar.example.org")
#
# Note 1: Mounted apps (by default) should be placed into the project root at '/app_name'.
# Note 2: If you use the host matching remember to respect the order of the rules.
#
# By default, this file mounts the primary app which was generated with this project.
# However, the mounted app can be modified as needed:
#
#   Padrino.mount("AppName", :app_file => "path/to/file", :app_class => "BlogApp").to('/')
#

##
# Setup global project settings for your apps. These settings are inherited by every subapp. You can
# override these settings in the subapps as needed.
#

Padrino.configure_apps do
  key = '_kaja_nomination_session'
  if production?
    # Use Session Store of Dalli
    require 'rack/session/dalli'

    Padrino.use Rack::Session::Dalli, key: key,
      cache: Dalli::Client.new(ENV["MEMCACHIER_SERVERS"], 
                               { username: ENV["MEMCACHIER_USERNAME"],
                                 password: ENV["MEMCACHIER_PASSWORD"]}
                              )
  else
    set :sessions, key: key
  end
  set :session_secret, '1f1fa19bb9caf2a2e275ee7542a9a2a163cc803e94c329e4e76da07a5ba22a71'
end

# Mounts the core application for this project
Padrino.mount("KajaNomination").to('/')

Padrino.mount("Admin").to("/admin")
