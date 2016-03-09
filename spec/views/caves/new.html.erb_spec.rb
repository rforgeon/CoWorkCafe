require 'rails_helper'

RSpec.describe "caves/new", type: :view do
  before(:each) do
    assign(:cafe, Cafe.new(
      :name => "MyString",
      :description => "MyText",
      :address => "MyText",
      :city => "MyString",
      :state => "MyString",
      :zipcode => 1
    ))
  end

  it "renders new cafe form" do
    render

    assert_select "form[action=?][method=?]", caves_path, "post" do

      assert_select "input#cafe_name[name=?]", "cafe[name]"

      assert_select "textarea#cafe_description[name=?]", "cafe[description]"

      assert_select "textarea#cafe_address[name=?]", "cafe[address]"

      assert_select "input#cafe_city[name=?]", "cafe[city]"

      assert_select "input#cafe_state[name=?]", "cafe[state]"

      assert_select "input#cafe_zipcode[name=?]", "cafe[zipcode]"
    end
  end
end
