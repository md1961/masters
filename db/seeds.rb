# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

HOLE_ATTRS = [
  [ 1, 4, 400],
  [ 2, 5, 555],
  [ 3, 4, 360],
  [ 4, 3, 205],
  [ 5, 4, 435],
  [ 6, 3, 180],
  [ 7, 4, 365],
  [ 8, 5, 535],
  [ 9, 4, 435],
  [10, 4, 485],
  [11, 4, 455],
  [12, 3, 155],
  [13, 5, 465],
  [14, 4, 405],
  [15, 5, 500],
  [16, 3, 170],
  [17, 4, 400],
  [18, 4, 405],
]

Hole.destroy_all
HOLE_ATTRS.each do |number, par, distance|
  Hole.create!(number: number, par: par, distance: distance)
end
