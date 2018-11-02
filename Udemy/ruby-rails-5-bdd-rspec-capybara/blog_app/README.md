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

