class UsersController < ApplicationController
  # will bypass :authorized which will allow the user login/signup
  skip_before_action :authorized, only: [:new, :create]

  rescue_from Pundit::NotAuthorizedError do 
    redirect_to error_path
  end

  def new
    authorize current_user, :user_admin?
    @user = User.new
  end

  def create
    authorize current_user, :user_admin?
    @user = User.new(user_params)
    user_name = User.create_username(params[:firstName], params[:lastName], Time.zone.now)
    pass_check = User.valid_pass?(params[:password])
    password_update = Time.now

    if pass_check.empty? && !user_name.nil?
      @user.username = user_name
      @user.passUpdatedAt = password_update

      if @user.save 
        initialize_security_question(@user, params[:security_question_1][:id], params[:security_question_answer])
        create_user_event_log("", @user, "Added")
        redirect_to user_management_path, success: ErrorMessage.find_by(error_name: "user_created").body 
      else 
        flash.now[:danger] = "#{@user.errors.full_messages.first}"
        render new_user_path
      end
    else
      flash.now[:danger] = "#{pass_check}"
      render new_user_path
    end
  end

  def edit
    authorize current_user, :user_admin?
    @user = User.find(params[:id])
    @suspend_time_edit = @user.suspendedTill - 5.hours
  end

  def update
    authorize current_user, :user_admin?
    @user = User.find(params[:user_id].to_i)
    @user_before = @user.to_json
    before_active_status = @user.active
    userType = params[:userType].to_i

    if params[:active].nil?
      active = false
    else
      active = true
    end

    # Manages users suspention time
    suspend_time = Time.now
    if params[:reset_suspension] != "true" && !params[:suspend_time].nil?
      date_params = params[:suspend_time].to_datetime.in_time_zone("EST") + 5.hours

      if (date_params) > Time.now.to_datetime
        suspend_time = date_params
      else
        bad_suspend_date = true
      end
    end

    if @user.update(username: params[:username],firstName: params[:firstName], lastName: params[:lastName], email: params[:email], phoneNum: params[:phoneNum], address: params[:address], userType: userType, suspendedTill: suspend_time, active: active)
      auth_id = @user.password_join_authorization_ids.first
      PasswordJoinAuthorization.update(auth_id, answer: params[:security_question_answer])
      @user.reload
      
      # If Admin activates a new users account it sents email to that user
      if @user.active != before_active_status && @user.active
        ResetMailer.with(user: @user).account_activated.deliver_now
      end

      # If user deactiviats own account, system kicks user out 
      if (!@user.active && (@user == current_user)) || current_user.suspendedTill > Time.now
        redirect_to '/logout'
      elsif bad_suspend_date == true
        redirect_to edit_user_path(@user), danger: "You can not suspend a user in the past"
      else
        @user_after = @user.to_json
        after_active_status = @user.active
        if before_active_status && !after_active_status
          create_user_event_log(@user_before, @user_after, "Deactivated")
        elsif !@user_before.eql?(@user_after)
          create_user_event_log(@user_before, @user_after, "Modified")
        end
        redirect_to user_management_path, success: ErrorMessage.find_by(error_name: "user_updated").body
      end
    else
      redirect_to edit_user_path(@user), danger: "#{@user.errors.full_messages.first}"
    end
  end

  def administrator_email
    @selected_user = User.find(params[:user][:user_id].to_i)
    @subject_text = params[:subject]
    @body_text = params[:body]
    ResetMailer.with(user: @selected_user, subject: @subject_text, body: @body_text).send_this.deliver_now
    redirect_to user_management_path, success: ErrorMessage.find_by(error_name: "email_sent").body
  end

  private

  def user_params
    params.permit(:firstName, :lastName, :user_name, :password, :address, :email, :phoneNum, :dob, :userType, :active)    
  end

  def initialize_security_question(user, question_id, answer)
    PasswordJoinAuthorization.create(user_id: user.id, security_questions_id: question_id.to_i, answer: answer)
  end
  
  def create_user_event_log(before, after, type)
    if type == "Added"
      UserEventLog.new( user_name: current_user.username, 
                        event_type: type, 
                        user_before: before, 
                        user_after: after.to_json
                      ).save

    elsif type == "Deactivated"
    UserEventLog.new( user_name: current_user.username, 
                      event_type: type, 
                      user_before: before, 
                      user_after: after
                    ).save
    
    elsif type == "Modified"
    UserEventLog.new( user_name: current_user.username, 
                      event_type: type, 
                      user_before: before, 
                      user_after: after
                    ).save
    end
  end
end