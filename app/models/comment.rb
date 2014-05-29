class Comment < ActiveRecord::Base
  attr_accessible :content, :lft, :rgt, :move_id, :user_id, :created_at, :tomato_id, :id

  belongs_to :move
  belongs_to :user
  belongs_to :tomato

  def self.get_last_right(id, type)
    if type == "tomato"
      last_right = Comment.where("tomato_id = ?", id).maximum("rgt")
    elsif type == "move"
      last_right = Comment.where("move_id = ?", id).maximum("rgt")
    end
  end

  def self.update_root(id, type)
    if type == "tomato"
      current_max = Comment.where("tomato_id = ? and lft = 1", id).maximum("rgt")
      new_max = Comment.where("tomato_id = ? and lft = 1", id).update_all(:rgt => current_max + 2)
    elsif type == "move"
      current_max = Comment.where("move_id = ? and lft = 1", id).maximum("rgt")
      new_max = Comment.where("move_id = ? and lft = 1", id).update_all(:rgt => current_max + 2)
    end
  end

  def self.update_rgt(id, type, rgt)
    if type == "tomato"
      update = Comment.where("tomato_id = ?", id).update_all("rgt = rgt + 2", ["rgt >= ?", rgt.to_i])
    elsif type == "move"
      update = Comment.where("move_id = ?", id).update_all("rgt = rgt + 2", ["rgt >= ?", rgt.to_i])
    end
  end

  def self.update_lft(id, type, lft)
    if type == "tomato"
      update = Comment.where("tomato_id = ?", id).update_all("lft = lft + 2", ["lft > ?", lft.to_i])
    elsif type == "move"
      update = Comment.where("move_id = ?", id).update_all("lft = lft + 2", ["lft > ?", lft.to_i])
    end
  end
end