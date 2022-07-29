# frozen_string_literal: true

class HomeController < ApplicationController
  def index 
  end
  
  def show
    if current_user.has_role? :applicant
      @applicants=User.find(current_user.id)
    elsif(current_user.has_role? :employer)
      @applicants=User.find(params[:id])
    end

  end
end
