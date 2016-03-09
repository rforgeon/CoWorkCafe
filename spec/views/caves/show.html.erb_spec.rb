require 'rails_helper'

RSpec.describe "caves/show", type: :view do
  before(:each) do
    @cafe = assign(:cafe, Cafe.create!(
      :name => "Name",
      :description => "MyText",
      :address => "MyText",
      :city => "City",
      :state => "State",
      :zipcode => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/1/)
  end
end
