class CommentsController < ApplicationController
  # Workaround for lost user session on create comment - TODO needs another solution maybe
  skip_before_filter :verify_authenticity_token

  # GET /states
  # GET /states.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /states/1
  # GET /states/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /states/new
  # GET /states/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /states/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /states
  # POST /states.json
  def create
    @comment = Comment.new
    rgt = params['rgt']
    lft = params['lft']

    # Wenn es noch keinen Kommentar für einen Move gibt, muss der Root-Eintrag des Baums vor einem Kommentar angelegt werden
    if params['first_comment'].to_i == 1
      # If root = 1 then there is a root entry, if root = 0 then something went wrong
      root = create_root(params[:move_id], params[:tomato_id], params[:user_id])
      rgt = 2
      lft = 2
    else
       root = 1
    end

    if root == 1
      if params[:tomato_id] != nil
        Comment.update_rgt(params['tomato_id'], "tomato", rgt)
        Comment.update_lft(params['tomato_id'], "tomato", rgt)
      elsif params[:move_id] != nil
        Comment.update_rgt(params['move_id'], "move", rgt)
        Comment.update_lft(params['move_id'], "move", rgt)
      end

      #New Entry where the lft is rgt of the old value and rgt is one more
      @comment.lft = rgt
      @comment.rgt = rgt.to_i + 1
      @comment.content = params['content']
      @comment.user_id = params['user_id']
      @comment.move_id = params['move_id']
      @comment.tomato_id = params['tomato_id']
    else
      respond_to do |err|
        if params[:tomato_id] != nil
          err.html { redirect_to @tomato.move, notice: "Couldn't create tomato root tree entry"  }
        else
          err.html { redirect_to @move, notice: "Couldn't create move root tree entry"}
        end
        err.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
    respond_to do |format|
      if @comment.save && (params[:tomato_id] != nil)

        # This is for returning to the right tomato after writing a comment
        @tomato = Tomato.find(params[:tomato_id])
        if @tomato.move.present?
          format.html { redirect_to @tomato.move, notice: 'Comment was successfully created.' }
        else
          format.html { redirect_to @tomato, notice: 'Comment was successfully created.' }
        end
        format.json { render json: @comment, status: :created, location: @comment }
      elsif params[:move_id] != nil
        # This is for returning to the right move after writing a comment
        @move = Move.find(params[:move_id])
        format.html { redirect_to @move, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_root(move_id, tomato_id, user_id)

    @root_comment = Comment.new
    @root_comment.lft = 1
    @root_comment.rgt = 2
    @root_comment.content = "root"
    @root_comment.move_id = move_id
    @root_comment.tomato_id = tomato_id
    @root_comment.user_id = user_id

    if @root_comment.save
      return 1
    else
      return 0
    end
  end

  # PUT /states/1
  # PUT /states/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:state])
        format.html { redirect_to @comment, notice: 'State was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /states/1
  # DELETE /states/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to states_url }
      format.json { head :no_content }
    end
  end
end