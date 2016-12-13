class CommentsController < ApplicationController
  before_action :authenticate_user!, :load_product, only: [:create]

  def create
    @comment = @product.comments.build comment_params
    @comment.user = current_user
    if @comment.save!
      respond_to do |format|
        format.html {redirect_to @product}
        format.js
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content
  end

  def load_product
    @product = Product.find_by slug: params[:product_id]
    render_404 unless @product
  end
end
