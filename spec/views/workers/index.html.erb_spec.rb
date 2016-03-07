require 'rails_helper'

RSpec.describe "workers/index", type: :view do
  before(:each) do
    assign(:workers, [
      Worker.create!(
        :user => nil,
        :count => 1
      ),
      Worker.create!(
        :user => nil,
        :count => 1
      )
    ])
  end

  it "renders a list of workers" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
