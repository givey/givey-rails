require "spec_helper"

describe "routes to the givey_rails/me controller" do

  it "routes to new me path" do
    expect(get: new_me_path).to route_to(controller: "givey_rails/me", action: "new")
  end

  it "routes to create me path" do
    expect(post: me_path).to route_to(controller: "givey_rails/me", action: "create")
  end

  it "routes to me/paypal_link" do
    expect(get: "me/paypal_link").to route_to(controller: "givey_rails/me", action: "paypal_link")
  end

  it "routes to me/paypal_link_callback" do
    expect(get: "me/paypal_link_callback").to route_to(controller: "givey_rails/me", action: "paypal_link_callback")
  end

  it "routes to /sign_up" do
    expect(get: "sign_up").to route_to(controller: "givey_rails/me", action: "new")
  end

end
