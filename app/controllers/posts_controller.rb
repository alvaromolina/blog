class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    if params[:c] 
      @posts = Post.joins(:comments).where("comments.body LIKE '%#{params[:c]}%'").select("distinct posts.* ")
    elsif params[:category] and params[:category] != ""
      @posts = Post.where(:category=>params[:category])
    else
      q = params[:q] ? "body LIKE '%#{params[:q]}%'" : ""
      @posts = Post.where(q).order(:created_at).reverse  

    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
    
  end


  def history
    @history_posts = HistoryPost.where(:post_id=>params[:post_id])
  end
  
  def list
    @posts = Post.where(:status=>'1').order(:created_at).reverse

    @count_words = Hash.new(0)
    @posts.map {|p| p.body}.join(" ").split(" ").each{ |word| @count_words[word]+=1}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def view
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.status = '1'
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def publish
    @post = Post.find(params[:id])
    @post.status = params[:status]
    @post.save!
    redirect_to posts_path, notice: 'Post was successfully updated.'
  end

  def like
    @post = Post.find(params[:id])
    @post.likes.build(:user=>current_user)
    @post.save!
    redirect_to request.referer, notice: 'Post was successfully updated.'
  end


  def report

    @order = params[:order] ? params[:order] : 'id'
    @posts = Post.all

    if @order == 'comments_count'
      @posts.sort_by!{|obj| obj.comments.count}
    elsif @order == 'count_words'
      @posts.sort_by!{|obj| obj.body.split(' ').count}
    else
      @posts.sort_by!{|obj| obj[@order]}
    end
        

  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    @post.user = current_user
    
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
