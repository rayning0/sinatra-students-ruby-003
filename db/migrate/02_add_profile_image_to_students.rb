Sequel.migration do
  up do 
    add_column :students, :profile_image, String
  end

  down do
    remove_column :students, :profile_image
  end
end