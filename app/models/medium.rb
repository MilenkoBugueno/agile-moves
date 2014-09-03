class Medium < ActiveRecord::Base
  attr_accessible :arranger, :artist, :catalog, :composer, :description, :publisher, :state_id, :title, :writer, :move_ids
  validates_presence_of :title, :composer

  has_and_belongs_to_many :moves

  after_initialize :init

  private
  def init
    if self.new_record?
      self.state_id = 1
    end
  end
end
