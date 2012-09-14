class UserSession
  include ActiveModel::Validations
  include ActiveModel::Conversion

  extend ActiveModel::Translation
  extend ActiveModel::Naming

  attr_accessor :email, :password

  validates_presence_of :email, :password

  def initialize(session, attributes={})
    @session = session
    @email = attributes[:email]
    @password = attributes[:password]
  end

  def authenticate
    user = User.authenticate(@email, @password)

    if user.present?
      store(user)
    else
      errors.add(:base, :invalid_login)
      false
    end
  end

  def store(user)
    @session[:user_id] = user.id
  end

  def persisted?
    false
  end

  def current_user
    User.find(@session[:user_id])
  end

  def user_signed_in?
    @session[:user_id].present?
  end

  def destroy
    @session[:user_id] = nil
  end
end
