module ProjectsHelper
  def has_plan_view(project)
    has_plan_view = false
    project.move_types.each do |move_type|
      move_type.widgets.each do |widget|
        if widget.widget_type == 0
          has_plan_view = true
        end
      end
    end

    return has_plan_view
  end
end
