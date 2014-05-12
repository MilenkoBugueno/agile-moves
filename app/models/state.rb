class State < ActiveRecord::Base
  attr_accessible :body, :position, :title, :visibility, :project_id
  belongs_to :move

  def closed
    return self.title == "closed"
  end
end
