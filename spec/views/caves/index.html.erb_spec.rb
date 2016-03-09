require 'rails_helper'

RSpec.describe "caves/index", type: :view do
  before(:each) do
    assign(:caves, [
      Cafe.create!(
        :name => "Name",
        :description => "MyText",
        :address => "MyText",
        :city => "City",
        :state => "State",
        :zipcode => 1
      ),
      Cafe.create!(
        :name => "Name",
        :description => "MyText",
        :address => "MyText",
        :city => "City",
        :state => "State",
        :zipcode => 1
      )
    ])
  end

  it "renders a list of caves" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
