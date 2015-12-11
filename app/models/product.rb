class Product < ActiveRecord::Base

	default_scope { order('name') }
	has_many :line_items

	before_destroy :ensure_not_referenced_by_any_line_item

	#ensuring that there are no line items referencing this product
	def ensure_not_referenced_by_any_line_item
		if line_items.count.zero?
			return true
		else
			errors[:base] << "Line Items Prsent"
			return false
		end
	end 

validates :brand, :name, :description, :long_description, :image_url, :presence => true
validates :price, :numericality => {:greater_than => 0.01}
validates :name, :uniqueness => true
validates :image_url, :format => {:with => %r{\.(gif|jpg|png)\z}i,
:message => 'Must be a URL for GIF, JPG or PNG image.'
}

end