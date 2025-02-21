require 'sinatra'
require 'sqlite3'
require 'rqrcode'
require 'chunky_png'

set :database, {adapter: "sqlite3", database: "db/development_wallet.sqlite3"}

get '/' do
  '¡Hola, mundo!'
end

get '/rico' do
  '¡Hola, teromundo!'
end
get '/qr/:data' do
  content_type 'image/png'

  qr = RQRCode::QRCode.new(params[:data])
  png = qr.as_png(
    size: 300,
    border_modules: 4
  )

  png.to_blob
end
