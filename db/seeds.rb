# require 'csv'
# CSV.foreach(Rails.root.join("db/seeds_data/products.csv"), headers: true) do |row|
#   Product.find_or_create_by(brand: row[0], name: row[1], description: row[2], image_url: row[3], price: row[4])
# end