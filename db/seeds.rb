# db/seeds.rb

brands = [
  { name: 'Toyota' },
  { name: 'Honda' },
  { name: 'Ford' },
  { name: 'Chevrolet' },
  { name: 'BMW' },
  { name: 'Mercedes-Benz' },
  { name: 'Audi' },
  { name: 'Tesla' },
  { name: 'Hyundai' },
  { name: 'Kia' },
  { name: 'Nissan' },
  { name: 'Volkswagen' },
  { name: 'Porsche' },
  { name: 'Jaguar' },
  { name: 'Lamborghini' },
  { name: 'Ferrari' },
  { name: 'Maserati' },
  { name: 'Land Rover' },
  { name: 'Jeep' },
  { name: 'Subaru' }
]

brands.each do |brand|
  Brand.find_or_create_by(brand)
end

puts "Brands seeded successfully."
