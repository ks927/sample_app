module ApplicationHelper
    # returns full title or base title if none given
    def full_title(page_title = '')
       base_title = "Ruby on Rails Tutorial Sample App"
        if page_title.empty?
            base_title
        else
            page_title + " | " + base_title
        end
    end
end
