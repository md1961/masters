# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

FILENAMES = %w(course player).freeze

paths = FILENAMES.map { |filename| File.join('db', 'seeds', "#{filename}.rb") }
paths.each do |path|
  unless File.exist?(Rails.root.join(path))
    STDERR.puts "Cannot find '#{path}'."
    exit
  end
end

paths.each do |path|
  STDERR.puts "Applying seed '#{path}'..."
  require(Rails.root.join(path))
end
