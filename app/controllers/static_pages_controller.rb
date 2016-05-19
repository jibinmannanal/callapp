class StaticPagesController < ApplicationController
  def home

  end

  def help
  end
  def search
    @clients2 =  Organization.uniq.pluck(:organization_name)
  end

  def search_results
    keywords = params[:search_keywords]
    @found_clients = Organization.where("organization_name LIKE '%#{keywords}%'")
  end
end
