# class AddCategoryToProducts < ActiveRecord::Migration[8.1]
#   def change
#     add_reference :products, :category, null: false, foreign_key: true
#   end
# end

class AddCategoryToProducts < ActiveRecord::Migration[8.1]
  def change
    add_reference :products, :category, foreign_key: true
  end
end