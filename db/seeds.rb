# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Room.create!(:title => "The Room", :location => 'Sao Paulo, SP', :description => 'An awesome room in sampa.')

10.times do
  names = %w{John Peter Frank Paul Mark Greg}
  names.each do |name|
    u = User.create! :full_name => name,
      :password => name.downcase,
      :location => 'Sao Paulo, SP',
      :password_confirmation => name.downcase,
      :bio => name * 10,
      :email => "#{name.downcase}#{rand(100000)}@example.com"

    room_id = Room.pluck(:id).sample
    rev = Room.find(room_id).reviews.build  :points => rand(5) + 1
    rev.user = u
    rev.save!
  end
end

30.times do |i|
  r = Room.new :title => "Teste #{i}", :description => "Teste de quarto nro #{i}", :location => 'Sao Paulo, SP'
  r.user=  User.first
  r.save
end
