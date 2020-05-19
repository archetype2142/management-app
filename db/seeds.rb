# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

TaxCategory.all.destroy_all
ShippingCategory.all.destroy_all
Address.all.destroy_all
User.all.destroy_all
Product.all.destroy_all
Country.all.destroy_all
Role.all.destroy_all

c = Country.create!(name: "Poland", iso: "PL", iso3: "POL", iso_name: "Poland")
poland_sates = %w[dolnośląskie kujawsko-pomorskie lubelskie lubuskie łódzkie 
                  małopolskie mazowieckie opolskie podkarpackie podlaskie 
                  pomorskie śląskie świętokrzyskie warmińsko-mazurskie 
                  wielkopolskie zachodniopomorskie ]
poland_sates.each do |state|
  c.states << State.new(name: state)
end

u = User.create!(email: 'test@test.com', password: 'test123')

tax_category = TaxCategory.create!(name: "24% VAT")
shipping_category = ShippingCategory.create!(name: "Free Shipping!")

%w[person company].each { |r| Role.create!(name: r) }

(1..50).each do |user|
  random = SecureRandom.hex
  
  user = User.create!(
    email: "#{random[0..5]}@#{random[5..10]}.com", 
    password: "test123"
  )

  Address.create!(
    user: user,
    country: Country.last,
    city: "Warzawa",
    address1: "abc",
    firstname: "#{[*?A..?Z].sample( 2 ).join}#{rand 100..999}",
    lastname: "#{[*?A..?Z].sample( 2 ).join}#{rand 100..999}"
  )

  user.roles << Role.all.sample
  Product.create!(
    price: Money.new((10000..50000).to_a.sample),
    name: "#{[*?A..?Z].sample( 2 ).join}#{rand 100..999}", 
    tax_category: tax_category,
    shipping_category: shipping_category,
    slug: random[8..12],
    sku: SecureRandom.hex[1..5]
  )
end

i = File.open(Rails.root.join('app', 'assets', 'images', 'sample.jpeg'))
image = Image.new(attachment:{io: i, filename: "#{rand(1..210)}.jpg"})

Product.last.images << image


