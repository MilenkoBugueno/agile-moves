class Medium < ActiveRecord::Base
  attr_accessible :arranger, :artist, :catalog, :composer, :description, :publisher, :state_id, :title, :writer
end
