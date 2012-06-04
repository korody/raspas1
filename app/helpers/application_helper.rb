module ApplicationHelper

  # Return a title on a per-page basis.
	def title
      if !@micropost
      	base_title = "raspas"
      	if @title.nil?
        	base_title
        else      
          "#{base_title} | #{@title}"
        end
      else
        @micropost.content  
      end
  end

    def logo
    	image_tag("logo.png", :alt => "raspas", :class => "logo")
  	end
end 