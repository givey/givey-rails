require "spec_helper"

describe "routes to the givey_rails/passwords controller" do

  it "routes to new_password_path" do
    expect(get: new_password_path).to route_to(controller: "givey_rails/passwords", action: "new")
  end

  it "routes to password_path create" do
    expect(post: password_path).to route_to(controller: "givey_rails/passwords", action: "create")
  end

  it "routes to edit_password_path" do
    expect(get: edit_password_path).to route_to(controller: "givey_rails/passwords", action: "edit")
  end

  it "routes to password_path update" do
    expect(put: password_path).to route_to(controller: "givey_rails/passwords", action: "update")
  end

end
