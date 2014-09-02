class Medium < ActiveRecord::Base
  attr_accessible :arranger, :artist, :catalog, :composer, :description, :publisher, :state_id, :title, :writer

  after_initialize :init

  private
  def init
    if self.new_record?
      self.state_id = 1
    end
  end
end