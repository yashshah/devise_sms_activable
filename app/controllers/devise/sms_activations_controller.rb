class Devise::SmsActivationsController < DeviseController

  # GET /resource/sms_activation/new
  def new
    build_resource({})
    render_with_scope :new
  end

  # POST /resource/sms_activation
  def create
    self.resource = resource_class.send_sms_token(params[resource_name])

    if resource.errors.empty?
      set_flash_message :notice, :send_token, :phone => self.resource.phone if is_navigational_format?
      respond_with({}, :location => after_sending_sms_activation_code_path_for(resource_name))
    else
      respond_with(resource)
    end
  end
  
  # GET /resource/sms_activation/insert
  def insert
    build_resource({})
  end
  
  # GET or POST /resource/sms_activation/consume?sms_token=abcdef
  def consume
    self.resource = resource_class.confirm_by_sms_token(params[:sms_token])

    if resource.errors.empty?
      set_flash_message :notice, :confirmed if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with({}, :location => after_sign_in_path_for(resource_name))
    else
      respond_with(resource, :message => find_message(:sms_activation_error, :sms_token => params[:sms_token]))
    end
  end

  protected
    def after_sending_sms_activation_code_path_for(resource_name)
      new_session_path(resource_name) if is_navigational_format?
    end

end
