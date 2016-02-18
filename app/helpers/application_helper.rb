module ApplicationHelper

	# Returns the full title on a per-page basis.
	def full_title (page_title = '')
		base_title = "Ruby on Rails Tutorial Sample App"
		if page_title.empty?
			base_title
		else
			page_title + " | " + base_title
		end
	end

	# Returns the full class -> superclass structure of an object.
	def get_superclass(obj=nil)
		result = []
		obj = obj.class unless obj.class == Class
		if obj != NilClass
	 		result << obj
	 		result << get_superclass(obj.superclass)
	 	end
		return result.join(" ").split
	end
end
