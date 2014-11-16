class Registration < ActiveRecord::Base
  attr_accessible :certification_id, :end_date, :start_date, :user_id, :user_ids, :project_id

  validates_presence_of :certification_id, :user_id

  belongs_to :user
  belongs_to :project
  belongs_to :certification
  has_many :moves
  has_and_belongs_to_many :users

  scope :by_move_type_id, lambda {|uid| joins(:certification).where(["certifications.move_type_id =?", uid])}
  scope :by_user_id, lambda {|uid| where(["#{table_name}.user_id =?", uid])}
  scope :by_user_ids, lambda {|uid| joins(:users).where(["users.id =?", uid])}

  after_create :init


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

  def approved_moves
    approved_moves = []
    min_moves_num = self.certification.moves_number
    self.moves.each do |move|
      if move.thumbs_up >= min_moves_num && move.rejects <= 0
        approved_moves << move
      end
    end

    return approved_moves
  end

  private
  def init
    if self.new_record? && self.certification.present? && self.certification.duration.present?
      self.end_date = self.start_date + self.certification.duration.day
    end
  end

end
