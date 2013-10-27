# The student class inherits from Sequel Model to wrap a database table
# named students. The columns in that table become attributes of instances
# of this class.

# http://sequel.rubyforge.org/rdoc/classes/Sequel/Model.html

# Read the methods defined:
# http://sequel.rubyforge.org/rdoc/classes/Sequel/Model/ClassMethods.html
# http://sequel.rubyforge.org/rdoc/classes/Sequel/Model/InstanceMethods.html 
# http://sequel.rubyforge.org/rdoc/classes/Sequel/Dataset.html

class Student < Sequel::Model
  def slugify!
    self.slug = self.name.downcase.gsub(' ','-')
  end

  def before_save   # before saving to DB, will slugify name
    self.slug ||= self.slugify!
    super
  end
end