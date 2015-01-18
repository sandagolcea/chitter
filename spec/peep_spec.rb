require 'spec_helper'

describe Peep do

  context 'Demonstration of how datamapper works' do

    # This is not a real test, it's simply a demo of how it works
    it 'should be created and then retrieved from the db' do
      # In the beginning our database is empty, so there are no links
      expect(Peep.count).to eq(0)
      # this creates it in the database, so it's stored on the disk
      Peep.create(name: 'Sanda',
                  user_handle: 'pianogrl',
                  message: "Hello world")
      # We ask the database how many links we have, it should be 1
      expect(Peep.count).to eq(1)
      # Let's get the first (and only) link from the database
      peep = Peep.first
      # Now it has all properties that it was saved with.
      expect(peep.name).to eq('Sanda')
      expect(peep.user_handle).to eq('pianogrl')
      expect(peep.message).to eq('Hello world')
      # If we want to, we can destroy it
      peep.destroy
      # so now we have no links in the database
      expect(Peep.count).to eq(0)
    end

  end

end