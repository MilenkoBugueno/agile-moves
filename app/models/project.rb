class Project < ActiveRecord::Base
  attr_accessible :body, :title, :user_ids, :move_type_ids
  
  has_and_belongs_to_many :users
  has_many :states
  has_many :moves
  has_and_belongs_to_many :move_types


  scope :by_user_ids, lambda {|uid| joins(:users).where(["users.id =?", uid])}

  def has_make_my_sprint()
    has_sprint = false
    self.move_types.each do |move_type|
      if move_type.make_my_sprint
        has_sprint = true
      end
    end
    return has_sprint
  end

  def has_make_my_day()
    has_sprint = false
    self.move_types.each do |move_type|
      if move_type.make_my_day
        has_sprint = true
      end
    end
    return has_sprint
  end

end
