class CommentsController < ApplicationController

def create

	@post = Post.find(params[:post_id])
	@post.comments.build(:body=>params[:body],:user=>current_user)
    respond_to do |format|
      if @post.save
        format.html { redirect_to '/posts/view/'+params[:post_id].to_s, notice: 'comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
end
