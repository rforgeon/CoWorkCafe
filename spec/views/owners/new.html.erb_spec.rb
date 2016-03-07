require 'rails_helper'

RSpec.describe "owners/new", type: :view do
  before(:each) do
    assign(:owner, Owner.new(
      :user => nil,
      :address => "MyString",
      :state => "MyString",
      :city => "MyString",
      :zipcode => 1,
      :description => "MyText",
      :rating => 1.5
    ))
  end

  it "renders new owner form" do
    render

    assert_select "form[action=?][method=?]", owners_path, "post" do

      assert_select "input#owner_user_id[name=?]", "owner[user_id]"

      assert_select "input#owner_address[name=?]", "owner[address]"

      assert_select "input#owner_state[name=?]", "owner[state]"

      assert_select "input#owner_city[name=?]", "owner[city]"

      assert_select "input#owner_zipcode[name=?]", "owner[zipcode]"

      assert_select "textarea#owner_description[name=?]", "owner[description]"

      assert_select "input#owner_rating[name=?]", "owner[rating]"
    end
  end
end
