module ApplicationHelper
  def render_if(condition, cart)
    render cart if condition
  end
end
