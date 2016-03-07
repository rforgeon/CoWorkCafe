require 'rails_helper'

RSpec.describe "workers/edit", type: :view do
  before(:each) do
    @worker = assign(:worker, Worker.create!(
      :user => nil,
      :count => 1
    ))
  end

  it "renders the edit worker form" do
    render

    assert_select "form[action=?][method=?]", worker_path(@worker), "post" do

      assert_select "input#worker_user_id[name=?]", "worker[user_id]"

      assert_select "input#worker_count[name=?]", "worker[count]"
    end
  end
end
