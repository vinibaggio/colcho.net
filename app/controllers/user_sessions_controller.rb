class UserSessionsController < ApplicationController
  before_filter :require_no_authentication, :only => [:new, :create]
  before_filter :require_authentication, :only => :destroy

  def new
    @session = UserSession.new(session)
  end

  def create
    @session = UserSession.new(session, params[:user_session])
    if @session.authenticate
      redirect_to root_path, :notice => t('flash.notice.signed_in')
    else
      render :new
    end
  end

  def destroy
    user_session.destroy
    redirect_to root_path, :notice => t('flash.notice.signed_out')
  end
end
