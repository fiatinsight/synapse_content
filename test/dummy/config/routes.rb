Rails.application.routes.draw do
  mount FiatPublication::Engine => "/fiat_publication"
end
