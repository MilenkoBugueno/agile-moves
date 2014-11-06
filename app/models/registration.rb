class Registration < ActiveRecord::Base
  attr_accessible :certification_id, :end_date, :start_date, :user_id, :user_ids

  validates_presence_of :certification_id, :user_id

  belongs_to :user
  belongs_to :certification
  has_many :moves
  has_and_belongs_to_many :users

  scope :by_move_type_id, lambda {|uid| joins(:certification).where(["certifications.move_type_id =?", uid])}
  scope :by_user_id, lambda {|uid| where(["#{table_name}.user_id =?", uid])}
  scope :by_user_ids, lambda {|uid| joins(:users).where(["users.id =?", uid])}

  def certification_label
    level = self.certification.level_id
    title = ""
    if level == 1
      title = "Apprentice"
    elsif  level == 2
      title = "Journeyman"
    elsif  level == 2
      title = "Master"
    end

    return "#{self.certification.label} (#{title}) | #{self.user.name}"
  end

end
