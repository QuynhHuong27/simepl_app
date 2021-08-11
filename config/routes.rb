Rails.application.routes.draw do
  get "page_not_fould", to: "page_error#not_fould"
  get "page_error_server", to: "page_error#error_server"
  root "application#helloworld"
end
