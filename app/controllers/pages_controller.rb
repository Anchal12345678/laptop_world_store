class PagesController < ApplicationController
  def contact
    @page = Page.find_by(page_type: 'contact')
  end

  def about
    @page = Page.find_by(page_type: 'about')
  end
end
