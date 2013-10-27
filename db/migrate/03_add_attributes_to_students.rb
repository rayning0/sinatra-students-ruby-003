Sequel.migration do
  change do 
    add_column :students, :background_image, String
    add_column :students, :twitter, String
    add_column :students, :linkedin, String
    add_column :students, :github, String
    add_column :students, :quote, String
    add_column :students, :bio, String
    add_column :students, :work, String
    add_column :students, :work_title, String
    add_column :students, :education, String
  end
end