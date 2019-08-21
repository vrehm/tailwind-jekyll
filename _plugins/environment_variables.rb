# Plugin to add environment variables to the `site` object in Liquid templates
require 'dotenv'

module Jekyll
  class EnvironmentVariablesGenerator < Generator
    def generate(site)
      # Load up .env variables.
      site.config['env'] = Dotenv.load('.env')
      ENV.each do |key, value|
        site.config['env'][key] = value
      end
      print 'dotenv variables: '
      print site.config['env']
    end
  end
end
