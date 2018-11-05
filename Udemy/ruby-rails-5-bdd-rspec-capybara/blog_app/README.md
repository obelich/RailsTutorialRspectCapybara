# README

Despues de generar la aplicacion agregamos lo siguiente en el Gemfile
Generamos un grupo especifico de `:test`
```
group :test do
  gem 'capybara', '3.10.0'
end
```

y en uno de los grupos en development

```
gem 'rspec-rails', '3.8.1'
gem 'guard'
gem 'guard-rspec'
gem 'guard-cucumber'
```

despues de ejecutar el `bundle install` ejecutamos

` rails g rspec:install` despues de que termine este comando ejecutamos `bundle binstubs rspec-core`

## Guard
Para inicianlizar Guard ejecutamos

`bundle binstubs guard` despues ejecutas `guard init`

### Archivo Guardfile

Una vez tengamos eso ahora modificamos el archivo 'Guardfile' que se cneuntra en la raiz del proyecto
apartir de la linea 71 agregamos el siguiente codigo
```
  watch(%r{^app/controllers/(.+)_(controller)\.rb$}) { "spec/features" }
  watch(%r{^app/models/(.+)\.rb$}) { "spec/features" }
  
```
Esto antes del 
```
  watch(rails.controllers)
```

Archivo final Guard 
```
# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

cucumber_options = {
  # Below are examples overriding defaults

  # cmd: 'bin/cucumber',
  # cmd_additional_args: '--profile guard',

  # all_after_pass: false,
  # all_on_start: false,
  # keep_failed: false,
  # feature_sets: ['features/frontend', 'features/experimental'],

  # run_all: { cmd_additional_args: '--profile guard_all' },
  # focus_on: { 'wip' }, # @wip
  # notification: false
}

guard "cucumber", cucumber_options do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$}) { "features" }

  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) do |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || "features"
  end
end

# Note: The cmd option is now required due to the increasing number of ways
#       rspec may be run, below are examples of the most common uses.
#  * bundler: 'bundle exec rspec'
#  * bundler binstubs: 'bin/rspec'
#  * spring: 'bin/rspec' (This will use spring if running and you have
#                          installed the spring binstubs per the docs)
#  * zeus: 'zeus rspec' (requires the server to be started separately)
#  * 'just' rspec: 'rspec'

guard :rspec, cmd: "bundle exec rspec" do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  # Feel free to open issues for suggestions and improvements

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  # Rails files
  rails = dsl.rails(view_extensions: %w(erb haml slim))
  dsl.watch_spec_files_for(rails.app_files)
  dsl.watch_spec_files_for(rails.views)

  watch(%r{^app/controllers/(.+)_(controller)\.rb$}) { "spec/features" }
  watch(%r{^app/models/(.+)\.rb$}) { "spec/features" }

  watch(rails.controllers) do |m|
    [
      rspec.spec.call("routing/#{m[1]}_routing"),
      rspec.spec.call("controllers/#{m[1]}_controller"),
      rspec.spec.call("acceptance/#{m[1]}")
    ]
  end

  # Rails config changes
  watch(rails.spec_helper)     { rspec.spec_dir }
  watch(rails.routes)           { "spec" } #{ "#{rspec.spec_dir}/routing" }
  watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }

  # Capybara features specs
  watch(rails.view_dirs)     { "spec/features" } # { |m| rspec.spec.call("features/#{m[1]}") }
  watch(rails.layouts)       { |m| rspec.spec.call("features/#{m[1]}") }

  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$}) do |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || "spec/acceptance"
  end
end

```



# Hacer una prueba Rspec

para hacer una prueba primero generamos una carpeta dentro de `spec/[nombre]` por ejemplo features

## archivos de prueba

Una vez creada la carpeta dentro de dicha carpeta generamos un archivo con el nombre de la prueba por ejemplo
`creating_article_spec.rb` es importante que termine con _spec y la extencion sea `.rb`

### Estructura basica

```
require "rails_helper"

RSpec.feature "Descripcion general de la prueba" do

  scenario "Descripcion del escenario de la prueba" do
        # Codigo de la prubea
  end

end
```

# Ejecutar prueba

Para ejecutar todas las prubeas en la consola ejecutas `rspec` si solo queremos ejecutar un archivo de prueba en especifico se ejecuta 

`rspec spec/[NombreCarpeta]/[NombreArchivo]_spec.rb`

