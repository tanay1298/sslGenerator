Rails.application.routes.draw do
  get 'certificate_info/expiration_date', to: 'certificate_info#expiration_date'
end

