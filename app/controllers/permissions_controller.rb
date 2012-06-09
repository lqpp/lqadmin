class PermissionsController < ApplicationController
  
  before_filter :fetch_logged_user

  def fetch_logged_user
    if session[:user_id].blank? then
      redirect_to :controller => "login", :action => "index"
    else
      @user = User.find(session[:user_id])
      if not @user.admin? then
        flash[:error] = "Sie haben nicht das Recht dafür!"
        redirect_to :action => "index", :controller => "home"
      end
    end
  end
  
  
  # GET /permissions
  # GET /permissions.xml
  def index
    @permissions = Permission.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @permissions }
    end
  end

  # GET /permissions/1
  # GET /permissions/1.xml
  def show
    @permission = Permission.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @permission }
    end
  end

  # GET /permissions/new
  # GET /permissions/new.xml
  def new
    @permission = Permission.new
    
    @users    = User.all
    @instants = Instants.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @permission }
    end
  end

  # GET /permissions/1/edit
  def edit
    @permission = Permission.find(params[:id])
  end

  # POST /permissions
  # POST /permissions.xml
  def create
    if Permission.find_by_sql("select * from permissions where user_id = #{params[:permission][:user_id]} AND instants_id = #{params[:permission][:instants_id]}").count != 0 then
      flash[:error] = "Die Kompination von disem User und der Instants gib es schon!"
      redirect_to 
      return
    end
    @permission = Permission.new(params[:permission])

    respond_to do |format|
      if @permission.save
        flash[:notice] = 'Permission was successfully created.'
        format.html { redirect_to(@permission) }
        format.xml  { render :xml => @permission, :status => :created, :location => @permission }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @permission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /permissions/1
  # PUT /permissions/1.xml
  def update
    @permission = Permission.find(params[:id])

    respond_to do |format|
      if @permission.update_attributes(params[:permission])
        flash[:notice] = 'Permission was successfully updated.'
        format.html { redirect_to(@permission) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @permission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /permissions/1
  # DELETE /permissions/1.xml
  def destroy
    @permission = Permission.find(params[:id])
    @permission.destroy

    respond_to do |format|
      format.html { redirect_to(permissions_url) }
      format.xml  { head :ok }
    end
  end
end
