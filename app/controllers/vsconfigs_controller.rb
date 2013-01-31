
class VsconfigsController < ApplicationController
  before_filter :authenticate_admin, :except => 'vs'
  layout 'main_layout'

  # GET /vsconfigs
  # GET /vsconfigs.json
  def index
    @vsconfigs = Vsconfig.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vsconfigs }
    end
  end

  # GET /vsconfigs/1
  # GET /vsconfigs/1.json
  def show
    @vsconfig = Vsconfig.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vsconfig }
    end
  end

  # GET /vsconfigs/new
  # GET /vsconfigs/new.json
  def new
    @vsconfig = Vsconfig.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vsconfig }
    end
  end

  # GET /vsconfigs/1/edit
  def edit
    @vsconfig = Vsconfig.find(params[:id])
  end

  # POST /vsconfigs
  # POST /vsconfigs.json
  def create
    @vsconfig = Vsconfig.new(params[:vsconfig])

    respond_to do |format|
      if @vsconfig.save

        @vsconfig.create_table
        format.html { redirect_to @vsconfig, notice: 'Vsconfig was successfully created.' }
        format.json { render json: @vsconfig, status: :created, location: @vsconfig }
      else
        format.html { render action: "new" }
        format.json { render json: @vsconfig.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /vsconfigs/1
  # PUT /vsconfigs/1.json
  def update
    @vsconfig = Vsconfig.find(params[:id])


    respond_to do |format|
      if @vsconfig.update_attributes(params[:vsconfig])
        format.html { render action: "edit" }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @vsconfig.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vsconfigs/1
  # DELETE /vsconfigs/1.json
  def destroy
    @vsconfig = Vsconfig.find(params[:id])
    @vsconfig.destroy

    respond_to do |format|

      # ActiveRecord::Schema.drop_table @vsconfig.table_name

      format.html { redirect_to vsconfigs_url }
      format.json { head :ok }
    end
  end

  
  #
  # Home page if not admin
  #
  def vs
    @vsconfigs = Vsconfig.limit(3).where("private = ? OR private = ?", nil, false)
    render :layout => false
  end

  protected
  def authenticate_admin
    if current_user == nil or current_user.admin != true
      redirect_to :action => 'vs'
    end
  end
end
