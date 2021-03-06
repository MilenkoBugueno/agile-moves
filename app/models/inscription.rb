class Inscription < ActiveRecord::Base
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
    min_moves_num = self.certification.approvements
    self.moves.each do |move|
      if move.thumbs_up >= min_moves_num && move.rejects <= 0
        approved_moves << move
      end
    end

    return approved_moves
  end

  def completed
    result = false
    if approved_moves.count >= self.certification.moves_number
      result = true
    end
    return result
  end

  private
  def init
    if self.certification_id.present?
      certification = Certification.find(self.certification_id)
      self.update_attributes(end_date: self.start_date + certification.duration.day)
    end
  end

end
