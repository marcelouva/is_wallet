require 'sqlite3'
require 'active_record'
require 'fileutils'

DB_PATH = File.expand_path("../db/development_is_wallet.sqlite3", __dir__)

# Si la base de datos no existe, la crea
unless File.exist?(DB_PATH)
  FileUtils.mkdir_p(File.dirname(DB_PATH)) # Crea el directorio si no existe
  SQLite3::Database.new(DB_PATH) # Crea el archivo de la base de datos
  puts "🔹 Base de datos creada: #{DB_PATH}"
end

# Configurar ActiveRecord
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: DB_PATH
)

puts "✅ Base de datos conectada: #{DB_PATH}"
