# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'populator'

#Todo.destroy_all

def generateRandomDateTime to_date = Time.now.to_i, from_date = 1527717600
    #from_date = 1546210800 # 1546210800 => 2018-12-31 00:00:00 +0100     in Ruby
    #from_date = 1527717600 # 1527717600 => 2018-05-31 00:00:00 +0200     in Ruby
    if (to_date == from_date || to_date > from_date || to_date < 0 || from_date < 0)
        dateMillsc = Random.rand(1524584672...1527717600)
        Time.at(dateMillsc)
    else
        dateMillsc = Random.rand(to_date...from_date)
        Time.at(dateMillsc)
    end
end

def explodeDateTime theDateTime = "2018-05-09 08:12:36 +0200"
    theTime = "00:00:00"
    theDate = "2018-12-31"
    regxpPatternDateTime= /(\d{4}-\d{2}-\d{2})\s(\d{2}:\d{2}:\d{2})/
    matchRegxTime = regxpPatternDateTime.match(theDateTime.to_s)
    unless matchRegxTime  
        #"There was no match..."
    end
    theDate =  matchRegxTime.captures[0]
    theTime = matchRegxTime.captures[1]
    return theDate, theTime
end

100.times do |index|

    theDateTime = generateRandomDateTime
    theDateTime_exploded = explodeDateTime theDateTime

    Todo.create!( title: Faker::Lorem.sentence(3, false, 0).chop,
                  notes: Faker::Lorem.paragraph,
                  deadline: theDateTime_exploded[0],
                  time: theDateTime_exploded[1]
                )
end

p "Created #{Todo.count} Todos"