class HomesController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show]
  load_and_authorize_resource

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
        pdf.move_down 15    
        pdf.stroke_horizontal_rule

        # Check to see if there is a home image.
        if @home.image_main.present?
          # If present print image
          pdf.image open("#{@home.image_main_url}"), :width => 270, :at => [0, 670]
        end
        if @home.image_side_top.present?
          # If present print image
          pdf.image open("#{@home.image_side_top_url}"), :width => 270, :at => [280, 670]
        end

        pdf.image open("https://chart.googleapis.com/chart?chs=100x100&cht=qr&chl=http://homey.io/homes/#{@home.id}"), :width => 55, :at => [480, 745]
        
        table_data = 
                  [["<b>Price</b>", "$#{@home.price}"], 
                  ["<b>Beds</b>", "#{@home.beds}"], 
                  ["<b>Baths</b>", "#{@home.baths}"],
                  ["<b>House Size</b>", "#{@home.house_size} square ft."],
                  ["<b>Lot Size</b>", "#{@home.lot_size} acres"],
                  ["<b>Year Built</b>", "#{@home.year}"]]
        pdf.move_down(230)
        pdf.table(table_data, :width => 280, :cell_style => { :inline_format => true }) 
        pdf.bounding_box([300, 455], :width => 230) do
        pdf.text "#{@home.description}", size: 11
        end

          # Print the static map
        pdf.image open("http://maps.google.com/maps/api/staticmap?size=600x500&sensor=false&zoom=15&markers=#{@home.latitude}%2C#{@home.longitude}"), :width => 280, :at => [0, 280]

        pdf.move_down 90    
        pdf.stroke_horizontal_rule
        pdf.move_down 10
        pdf.text "Made with <3 by Homey.io", size: 11
        
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
      params.require(:home).permit(:address, :latitude, :longitude, :filepicker_url, :price, :beds, :baths, :house_size, :lot_size, :year, :description, :user_id, :image_main, :image_side_top, :image_side_bottom)
    end
end
