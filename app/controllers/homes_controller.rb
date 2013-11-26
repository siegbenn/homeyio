class HomesController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show]

  # GET /homes
  # GET /homes.json
  def index
    @homes = Home.where(user_id: current_user.id)
  end

  # GET /homes/1
  # GET /homes/1.json
  def show
    respond_to do |format|
      format.html

      # Require on a .pdf request
      format.pdf do

        # Use open-uri to open images via url
        require "open-uri"

        # Create a blank pdf document with var pdf
        pdf = Prawn::Document.new

        # Home address
        pdf.text "#{@home.address}", size: 16, style: :bold

        # Check to see if there is a home image.
        if @home.filepicker_url.present?
          # If present print image
          pdf.image open("#{@home.filepicker_url}"), :width => 450
        end
          # Print the static map
        pdf.image open("http://maps.google.com/maps/api/staticmap?size=600x350&sensor=false&zoom=15&markers=#{@home.latitude}%2C#{@home.longitude}"), :width => 450

        # Render the pdf and set the filename to the address
        # Make the pdf render in the browser
        send_data pdf.render, filename: "#{@home.address}.pdf",
        type: "application/pdf", disposition: "inline"
      end
    end
  end

  # GET /homes/new
  def new
    @home = Home.new
  end

  # GET /homes/1/edit
  def edit
  end

  # POST /homes
  # POST /homes.json
  def create
    @home = Home.new(home_params)
    @home.user_id = current_user.id
    respond_to do |format|
      if @home.save
        format.html { redirect_to @home, notice: 'Home was successfully created.' }
        format.json { render action: 'show', status: :created, location: @home }
      else
        format.html { render action: 'new' }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homes/1
  # PATCH/PUT /homes/1.json
  def update
    respond_to do |format|
      if @home.update(home_params)
        format.html { redirect_to @home, notice: 'Home was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.json
  def destroy
    @home.destroy
    respond_to do |format|
      format.html { redirect_to homes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
      params.require(:home).permit(:address, :latitude, :longitude, :filepicker_url, :price, :beds, :baths, :house_size, :lot_size, :year, :description, :user_id)
    end
end
