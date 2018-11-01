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
```

despues de ejecutar el `bundle install` ejecutamos

` rails g rspec:install` despues de que termine este comando ejecutamos `bundle binstubs rspec-core`
