class Certification < ActiveRecord::Base
  attr_accessible :approvements, :description, :label, :level_id, :move_type_id, :moves_number, :title, :user_id
end
