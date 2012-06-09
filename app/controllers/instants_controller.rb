class InstantsController < ApplicationController
  
  before_filter :fetch_logged_user

  def fetch_logged_user
    if session[:user_id].blank? then
      redirect_to :controller => "user", :action => "login"
    else
      @user = User.find(session[:user_id])
      if not @user.admin? then
        flash[:error] = "Sie haben nicht das Recht dafür!"
        redirect_to :action => "index", :controller => "home"
      end
    end
  end
  
  # GET /instants
  # GET /instants.xml
  def index
    @instants = Instants.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @instants }
    end
  end

  # GET /instants/1
  # GET /instants/1.xml
  def show
    @instants = Instants.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @instants }
    end
  end

  # GET /instants/new
  # GET /instants/new.xml
  def new
    @instants = Instants.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @instants }
    end
  end

  # GET /instants/1/edit
  def edit
    @instants = Instants.find(params[:id])
  end

  # POST /instants
  # POST /instants.xml
  def create
    @instants = Instants.new(params[:instants])

    respond_to do |format|
      if @instants.save
        flash[:notice] = 'instants was successfully created.'
        format.html { redirect_to(@instants) }
        format.xml  { render :xml => @instants, :status => :created, :location => @instants }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @instants.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /instants/1
  # PUT /instants/1.xml
  def update
    @instants = Instants.find(params[:id])

    respond_to do |format|
      if @instants.update_attributes(params[:instants])
        flash[:notice] = 'instants was successfully updated.'
        format.html { redirect_to(@instants) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @instants.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /instants/1
  # DELETE /instants/1.xml
  def destroy
    @instants = Instants.find(params[:id])
    @instants.destroy

    respond_to do |format|
      format.html { redirect_to(instants_url) }
      format.xml  { head :ok }
    end
  end
end
