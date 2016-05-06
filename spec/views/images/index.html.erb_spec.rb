require 'rails_helper'

RSpec.describe "images/index", type: :view do
  before(:each) do
    assign(:images, [
      Image.create!(
        :cafe_id => 1
      ),
      Image.create!(
        :cafe_id => 1
      )
    ])
  end

  it "renders a list of images" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
