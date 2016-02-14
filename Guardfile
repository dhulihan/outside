guard 'rack', :port => 9292 do
  watch('Gemfile.lock')
  watch(%r{^(config|lib|app)/.*})
  watch('app.rb')
  watch('api.rb')
end