class StaticPagesController < ApplicationController
  def home
    @active = 'home'
  end

  def about
    @active = 'about'
  end
end

# get '/' do
#   @active = 'home'
#   erb :home
# end