class ReviewsController < InheritedResources::Base

  private

    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end

