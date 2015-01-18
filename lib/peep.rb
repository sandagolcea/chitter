# Peeps (posts to chitter) have the name of the maker and their user handle.
class Peep

  # this makes the instances of this class Datamapper resources
  include DataMapper::Resource

  has n, :hashtags, :through => Resource
  # This block describes what resources our model will have
  property :id,     Serial # Serial means that it will be auto-incremented for every record
  property :message,  Text

end