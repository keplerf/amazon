class ContactController < ApplicationController
  def contact

  end

  def thankyou
    @name = params[:name]

  end
end
