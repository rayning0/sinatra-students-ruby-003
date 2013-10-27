Sequel.migration do
  change do 
    add_column :students, :slug, String
  end
end