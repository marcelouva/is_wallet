require 'sinatra'
require 'sqlite3'
require 'rqrcode'
require 'chunky_png'
require 'zxing'
require 'openssl'
require 'base64'
require 'rotp'
require 'sinatra/activerecord'



require 'bcrypt'
require './config/database'


set :sessions, true

require_relative './config/database'  # Carga la base de datos antes de todo

set :database, {adapter: "sqlite3", database: "db/development_is_wallet.sqlite3"}


# Cargar modelos
require './models/user'
require './models/account'

# Función para cifrar el contenido
def encrypt_data(data, key)
  cipher = OpenSSL::Cipher::AES.new(256, :CBC)
  cipher.encrypt
  cipher.key = key # Debe ser una clave secreta, de 32 bytes
  iv = cipher.random_iv
  encrypted = cipher.update(data) + cipher.final
  encrypted_data = Base64.encode64(iv + encrypted) # Incluye el IV para descifrarlo
  encrypted_data
end

# Ejemplo de uso
# data = "Transferencia bancaria: $500 a cuenta XXXXXX"
# key = "estaeslaclave1234567890clave32" # Asegúrate de mantener la clave secreta segura
# encrypted_data = encrypt_data(data, key)

# Ahora puedes generar un código QR con el `encrypted_data`
# puts encrypted_data



# Función para descifrar el contenido
def decrypt_data(encrypted_data, key)
  data = Base64.decode64(encrypted_data)
  iv = data[0..15] # El primer bloque es el IV
  encrypted = data[16..-1]
  
  decipher = OpenSSL::Cipher::AES.new(256, :CBC)
  decipher.decrypt
  decipher.key = key
  decipher.iv = iv
  decrypted_data = decipher.update(encrypted) + decipher.final
  decrypted_data
end

# Ejemplo de uso
# encrypted_data = "Base64_cifrado_del_qr_recibido"
# key = "estaeslaclave1234567890clave32"
# decrypted_data = decrypt_data(encrypted_data, key)

# puts decrypted_data # Debería mostrar los datos originales
# Generar secreto único por usuario (debe guardarse en la base de datos)
def generate_secret
  ROTP::Base32.random_base32
end





get '/' do
  erb :index
end

get '/scan' do
  erb :scan
end

#post '/decode' do
#  tempfile = params[:file][:tempfile]
#  decoded_text = ZXing.decode(tempfile.path)
#  "QR Code Content: #{decoded_text}"
#end




post '/decode' do
  qr_content = params[:qr_content]

  if qr_content && !qr_content.empty?
    # Procesar el contenido del código QR según tus necesidades
    "Contenido del Código QR: #{qr_content}"
  else
    "No se recibió contenido del código QR."
  end
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



get '/scan_qr' do
  image_path = "qr2.png"  # Aquí pones el path de tu imagen con QR
  texto = ZXing.decode(File.open(image_path))

  texto
end


get '/escanear_qr' do
  erb :scan
end

post '/procesar_qr' do
  qr_data = params[:qr_data]
  # Procesa la información del QR según tus necesidades
  "Datos del QR recibidos: #{qr_data}"
end



post '/generate_qr' do
  username = params[:username]
  secret = ROTP::Base32.random_base32
  session[:secret] = secret  # Guardar en la sesión o BD

  totp = ROTP::TOTP.new(secret, issuer: "MiApp")
  qr = RQRCode::QRCode.new(totp.provisioning_uri(username))

  erb :show_qr, locals: { qr_svg: qr.as_svg }
end

# Ruta para verificar el código ingresado por el usuario
post '/verify_totp' do
  totp = ROTP::TOTP.new(session[:secret])
  user_code = params[:otp]

  if totp.verify(user_code)
    redirect '/secure_qr'
  else
    "❌ Código incorrecto. Inténtalo nuevamente."
  end
end

# Ruta protegida: muestra el QR seguro si la autenticación es exitosa
get '/secure_qr' do
  qr_data = "https://miapp.com/datos-seguros"
  qr_encoded = RQRCode::QRCode.new(qr_data).as_svg
  erb :show_secure_qr, locals: { qr_encoded: qr_encoded }
end




post '/users' do
  # Obtener los parámetros de la solicitud
  user_params = {
    email: params[:email],
    password_digest: BCrypt::Password.create(params[:password]),
    full_name: params[:full_name],
    phone_number: params[:phone_number],
    is_verified: params[:is_verified] || false,
    auth_token: SecureRandom.hex(16),  # Puedes generar un token o usar otro mecanismo
    profile_picture_url: params[:profile_picture_url],
    is_active: params[:is_active] || true,
    dob: params[:dob] ? DateTime.parse(params[:dob]) : nil,
    language_preference: params[:language_preference] || 'en'
  }

  # Crear el nuevo usuario
  user = User.new(user_params)

  if user.save
    status 201  # Creación exitosa
    user.to_json  # Puedes devolver la representación JSON del usuario
  else
    status 400  # Error al crear
    { error: 'User could not be created' }.to_json
  end
end





