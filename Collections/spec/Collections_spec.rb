require 'rspec'
require_relative '../model/house'
require_relative '../model/department'
require_relative '../model/edifice'


# Documentacion: https://ruby-doc.org/core-2.2.0/Array.html


describe 'dado ciertas colecciones veremos que clase de operaciones podemos utilizar' do

  before :each do
    @house1 = House.new "Calle falsa 1234", 5, 2050
    @house2 = House.new "lalala 23", 2, 1342
    @house3 = House.new "Sevilla 140", 1, 3000
    @house4 = House.new "32 y 137", 3, 1500
    @houses = [@house1,@house2,@house3,@house4] #syntax sugar para crear un array con ciertos elementos.

  # --------------------------------------------------------------------------------------------------

    @department1 = Department.new "Calle falsa 1234", 2, 11, 500
    @department2 = Department.new "lalala 23", 1, 3, 120
    @department3 = Department.new "Sevilla 140", 2, 1, 203
    @department4 = Department.new "32 Y 137", 3, 9, 43
    @department5 = Department.new "Mitre e/ 4 y 5", 5, 2, 8
    @departments = [@department1,@department2,@department3,@department4,@department5]
  #---------------------------------------------------------------------------------------------------

    @edifice1 = Edifice.new [@department1,@department3]
    @edifice2 = Edifice.new [@department1,@department5,@department4]
    @edifice3 = Edifice.new [@department3,@department2,@department4]
    @edifice4 = Edifice.new @departments
    @edifices = [@edifice1,@edifice2,@edifice3,@edifice4]

  end

  it 'dado una lista de casas, chequear si la lista esta vacia ' do

    (expect @houses.empty?).to eq false

  end

  it 'dado una lista de casas, invertir el orden de ellas ' do

    (expect @houses.reverse).to eq [@house4,@house3,@house2,@house1]

  end

  it 'dado una lista de casas , eliminar todas aquellas casas que son monoambiente ' do

    (expect @houses.delete_if { |house| house.ambients == 1 }).to eq [@house1,@house2,@house4]

  end

  it 'dado una lista de casas , decir si por lo menos alguna tiene mas de 4 ambientes ' do

    (expect @houses.any? { |house| house.ambients > 4 }).to eq true

  end

  it 'dado una lista de casas , decir si todas tienen mas de un ambiente' do

    (expect @houses.all? { |house| house.ambients > 1 }).to eq false

  end

  it 'dado una lista de departamentos, obtener la cantidad total de departamentos' do

    (expect @departments.size).to eq 5

  end

  it 'dado una lista de casas, chequear que la cantidad de casas con mas de 2 ambientes es ' do

    (expect @houses.select { |house| house.ambients >= 2 }.size).to eq 3

  end

  it 'dado una lista de casas, chequear que la cantidad de casas con 1 ambiente es  ' do

    (expect @houses.select { |house| house.ambients == 1 }.size).to eq 1

  end

  it 'dado una lista de casas, chequear que la lista queda ordenada por numero de casa  ' do

                              # ordena de mayor a menor

    (expect @houses.sort { |house1,house2| house1.number <=> house2.number }).to eq [@house2,@house4,@house1,@house3]

  end

  it 'dado una lista de edificios, chequear que la cantidad de edificios con mas de 3 departamentos es ' do

    (expect @edifices.select { |edifice| edifice.departments.size > 3 }.size).to eq 1

  end

  it 'dado un edificio, obtener los numeros de todos los departamentos ' do

    (expect @edifice1.departments.map { |department| department.number }).to eq [500,203]

  end

  it 'dado una lista de departamentos, obtener todos los departamentos que son monoambientes' do

    (expect @departments.select { |department| department.ambients == 1 }).to eq [@department2]

  end

  it 'dado una lista de edificios, obtener los edificios con 3 o más pisos' do

    (expect @edifices.select { |edifice| edifice.departments.any? { |department| department.floor > 5 } }).to eq @edifices

  end

  it 'dado una lista de edificios, obtener el edificio con el departamento con más ambientes ' do

    superEdifice = @edifices.sort { |e1,e2 |
                          (e1.departments.sort { |d1,d2| d1.ambients <=> d2.ambients }.first.ambients) <=>
                          (e2.departments.sort { |d1,d2| d1.ambients <=> d2.ambients }.first.ambients)
                        }.last

    (expect superEdifice).to eq @edifice2

  end

  it 'dado una lista de edificios, obtener las direcciones de los departamentos de más de un ambiente que se encuentran en edificios de menos de 3 pisos' do

    shortEdifices = @edifices.select { |edifice| edifice.departments.any? { |department| department.floor < 3 } }

    bigDepartments = shortEdifices.map { |edifice| edifice.departments.select { |department| department.ambients == 1} }

    directions = bigDepartments.flatten.map { |department| department.direction}

    (expect directions).to eq ["lalala 23", "lalala 23"]

  end

end