module RailsDingtalk
  class Engine < ::Rails::Engine

    config.autoload_paths += Dir[
      "#{config.root}/app/models/app"
    ]

    config.generators do |g|
      g.rails = {
        assets: false,
        stylesheets: false,
        helper: false
      }
      g.test_unit = {
        fixture: true
      }
      #g.templates.unshift File.expand_path('lib/templates', RailsCom::Engine.root)
    end

  end
end
