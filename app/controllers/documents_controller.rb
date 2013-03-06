class DocumentsController < ApplicationController
  
  def index
    @documents = Document.all
    respond_to do |format|
      format.html
      format.json { render :json => @documents }
      format.xml { render :xml => @documents }
    end
  end
  
  def show
    @document = Document.find_by_id(params[:id])
    
    respond_to do |format|
      if @document
        format.html #show.html.erb
        format.json {render :json => @document}
        format.xml {render :xml => @document}
      else
        flash[:error] = 'Document not found'
        format.html do
          redirect_to documents_path
        end
        format.json { render :text => flash[:error] }
        format.xml { render :text => flash[:error] }
      end
      
    end
    
  end
  
  def new
    @document = Document.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
    end
  end
  
  def edit
    @document = current_user.documents.find(params[:id])
  end
  
  def create
    @document = current_user.documents.new(params[:document])

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Doc was successfully created.' }
        format.json { render json: @document, status: :created, location: @document }
      else
        format.html { render action: "new" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @document = current_user.documents.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to @document, notice: 'Doc was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @document = current_user.documents.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url }
      format.json { head :no_content }
    end
  end
  
  def download
    doc = current_user.documents.find_by_id(params[:document_id])
    if doc
      send_file doc.filename.path
    else
      flash[:notice] = 'Sorry Document not found!'
      redirect_to documents_path
    end
  end
  
end
