# Peeps (posts to chitter) have the name of the maker and their user handle.
class Peep

  # this makes the instances of this class Datamapper resources
  include DataMapper::Resource

  # This block describes what resources our model will have
  property :id,     Serial # Serial means that it will be auto-incremented for every record
  property :name,  String
  property :user_handle,    String
  property :message,  Text

end