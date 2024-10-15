Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'

    resource '*', headers: :any,
             expose: %w(etag access-token uid expiry token-type client),
             methods: %i[get post options delete put patch head],
             max_age: 600
  end
end
