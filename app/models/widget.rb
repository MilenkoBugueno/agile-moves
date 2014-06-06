class Widget < ActiveRecord::Base
  attr_accessible :path, :title, :widget_type

  has_and_belongs_to_many :move_types

end
