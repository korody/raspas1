module ApplicationHelper

  # Return a title on a per-page basis.
	def title
    	base_title = "raspas"
    	if @title.nil?
      	base_title
      else      
        "#{base_title} | #{@title}"
      end
  end

  def logo
  	image_tag("logo.png", :alt => "raspas", :class => "logo")
	end

  def active?(controller, action)
    "active" if controller?(controller) && action?(action)
  end

  private

    def controller?(*controller)
      controller.include?(params[:controller])
    end

    def action?(*action)
      action.include?(params[:action])
    end
end 