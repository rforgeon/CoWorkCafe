require 'rails_helper'

RSpec.describe "owners/index", type: :view do
  before(:each) do
    assign(:owners, [
      Owner.create!(
        :user => nil,
        :address => "Address",
        :state => "State",
        :city => "City",
        :zipcode => 1,
        :description => "MyText",
        :rating => 1.5
      ),
      Owner.create!(
        :user => nil,
        :address => "Address",
        :state => "State",
        :city => "City",
        :zipcode => 1,
        :description => "MyText",
        :rating => 1.5
      )
    ])
  end

  it "renders a list of owners" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
