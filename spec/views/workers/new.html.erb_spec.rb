require 'rails_helper'

RSpec.describe "workers/new", type: :view do
  before(:each) do
    assign(:worker, Worker.new(
      :user => nil,
      :count => 1
    ))
  end

  it "renders new worker form" do
    render

    assert_select "form[action=?][method=?]", workers_path, "post" do

      assert_select "input#worker_user_id[name=?]", "worker[user_id]"

      assert_select "input#worker_count[name=?]", "worker[count]"
    end
  end
end
