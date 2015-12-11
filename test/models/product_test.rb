require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products

  test "product attributes must not be empty" do 
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:brand].any?
  	assert product.errors[:name].any?
  	assert product.errors[:description].any?
  	assert product.errors[:long_description].any?
  	assert product.errors[:image_url].any?
  	assert product.errors[:price].any?
  end

  test "product price must be positive" do
  	product = Product.new(:brand => "BSN",
						  :name => "Post Jym",
						  :description => "this is description",
						  :long_description => "this is long_description",
						  :image_url => "image.jpg")
	product.price = -1
	assert product.invalid?
	assert_equal "must be greater than 0.01",
	product.errors[:price].join('; ')
	
	product.price = 0
	assert product.invalid?
	assert_equal "must be greater than 0.01",
	product.errors[:price].join('; ')
	
	product.price = 1
	assert product.valid?
  end

  def new_product(image_url)
	product = Product.new(:brand => "BSN",
						  :name => "Post Jym",
						  :description => "this is description",
						  :long_description => "this is long_description",
						  :price => 1,
						  :image_url => image_url)
  end

  test "image url" do
	ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
			http://a.b.c/x/y/z/fred.gif }
	bad = %w{ fred.doc fred.gif/more fred.gif.more }

	ok.each do |name|
	  assert new_product(name).valid?, "#{name} shouldn't be invalid"
  end

  bad.each do |name|
  	assert new_product(name).invalid?, "#{name} shouldn't be valid"
  end

  end

  test "product is not valid without a unique title" do
  	product = Product.new(:brand => 'dskj',
  						  :name => products(:farhan_valid).name,
  						  :description => "ska",
  						  :price => 1,
  						  :image_url => "farhan.jpg")
  	assert !product.save
  	assert_equal "has already been taken", product.errors[:name].join('; ')
  end

end
