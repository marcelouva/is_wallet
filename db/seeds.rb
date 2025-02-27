require_relative '../server' 
require_relative '../models/user' 
require_relative '../models/question' 
require_relative '../models/option' 


america = [
  ["Argentina", "Buenos Aires", "Brasilia", "Lima", "Santiago"],
  ["Bolivia", "La Paz", "Sucre", "Brasilia", "Lima"],
  ["Brasil", "Brasilia", "Buenos Aires", "Lima", "Ciudad de México"],
  ["Canadá", "Ottawa", "Washington D.C.", "Buenos Aires", "Lima"],
  ["Chile", "Santiago", "Buenos Aires", "Lima", "Brasilia"],
  ["Colombia", "Bogotá", "Quito", "Ciudad de Panamá", "Lima"],
  ["Costa Rica", "San José", "Ciudad de Panamá", "Bogotá", "Quito"],
  ["Cuba", "La Habana", "Ciudad de México", "Bogotá", "San Juan"],
  ["Dominica", "Roseau", "Saint George's", "Kingston", "Puerto Príncipe"],
  ["Ecuador", "Quito", "Lima", "Bogotá", "La Paz"],
  ["El Salvador", "San Salvador", "Ciudad de Guatemala", "Tegucigalpa", "Managua"],
  ["Estados Unidos", "Washington D.C.", "Ottawa", "Buenos Aires", "Brasilia"],
  ["Granada", "Saint George's", "Kingston", "Bridgetown", "Castries"],
  ["Guatemala", "Ciudad de Guatemala", "Ciudad de México", "San Salvador", "Tegucigalpa"],
  ["Guyana", "Georgetown", "Paramaribo", "Caracas", "Cayena"],
  ["Haití", "Puerto Príncipe", "La Habana", "San Juan", "Santo Domingo"],
  ["Honduras", "Tegucigalpa", "San Salvador", "Ciudad de Guatemala", "Managua"],
  ["Jamaica", "Kingston", "La Habana", "San Juan", "Bogotá"],
  ["México", "Ciudad de México", "Washington D.C.", "Bogotá", "La Habana"],
  ["Nicaragua", "Managua", "San Salvador", "Tegucigalpa", "San José"],
  ["Panamá", "Ciudad de Panamá", "Bogotá", "San José", "Lima"],
  ["Paraguay", "Asunción", "Buenos Aires", "Santiago", "Lima"],
  ["Perú", "Lima", "Quito", "La Paz", "Bogotá"],
  ["República Dominicana", "Santo Domingo", "San Juan", "Puerto Príncipe", "La Habana"],
  ["Surinam", "Paramaribo", "Georgetown", "Cayena", "Brasilia"],
  ["Trinidad y Tobago", "Puerto España", "Caracas", "Bridgetown", "San Juan"],
  ["Uruguay", "Montevideo", "Buenos Aires", "Asunción", "Santiago"],
  ["Venezuela", "Caracas", "Bogotá", "Quito", "Lima"],
    ["Antigua y Barbuda", "Saint John's", "Bridgetown", "Kingston", "Castries"],
    ["Bahamas", "Nasáu", "Havana", "Santo Domingo", "San Juan"],
    ["Barbados", "Bridgetown", "Castries", "Saint George's", "Port of Spain"],
    ["Belice", "Belmopán", "Ciudad de Guatemala", "San Salvador", "Tegucigalpa"],
    ["Dominica", "Roseau", "Saint George's", "Kingston", "Puerto Príncipe"],
    ["Grenada", "Saint George's", "Kingston", "Bridgetown", "Castries"],
    ["Santa Lucía", "Castries", "Saint George's", "Bridgetown", "Kingston"],
    ["San Cristóbal y Nieves", "Basseterre", "Roseau", "Castries", "Saint John's"],
    ["San Vicente y las Granadinas", "Kingstown", "Castries", "Bridgetown", "Saint George's"],
    ["Trinidad y Tobago", "Puerto España", "Caracas", "Bridgetown", "San Juan"]
  ]
  
  def recorrer_arreglo(america)
    cont=1000
    q_id,op1_id,op2_id,op3_id,op4_id= 0,0,0,0,0
    america.each do |elemento|
      q_id=cont 
      cont += 1
      op1_id=cont
      cont += 1
      op2_id=cont
      cont += 1
      op3_id=cont
      cont += 1
      op4_id=cont
      puts "Question.create(name: #{elemento[0]}, option_id: #{op1_id}, question_id: #{q_id})"
      p=Question.new(name:elemento[0], option_id: op1_id, question_id: q_id)
      puts "Option.create(option_id: #{op1_id} , question_id: #{q_id} ,name:#{elemento[1]})"
      opcion1=Option.new(option_id: op1_id , question_id: q_id ,name:elemento[1])
      puts "Option.create(option_id: #{op2_id} , question_id: #{q_id} ,name:#{elemento[2]})"
      opcion2=Option.new(option_id: op2_id , question_id: q_id ,name:elemento[2])
      puts "Option.create(option_id: #{op3_id} , question_id: #{q_id} ,name:#{elemento[3]})"
      opcion3=Option.new(option_id: op3_id , question_id: q_id ,name:elemento[3])

      puts "Option.create(option_id: #{op4_id} , question_id: #{q_id} ,name:#{elemento[4]})"
      opcion4=Option.new(option_id: op4_id , question_id:q_id ,name:elemento[4])
      p.option=opcion1
      p.options.append(opcion1)
      p.options.append(opcion4)
      p.options.append(opcion2)
      p.options.append(opcion3)
      p.save
    end
  end
  
  
  recorrer_arreglo(america)



puts 'Base de datos inicializada con datos de ejemplo.'
