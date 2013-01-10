require "spec_helper"

describe "routes to the givey_rails/sessions controller" do

  it "routes to new_session_path" do
    expect(get: new_session_path).to route_to(controller: "givey_rails/sessions", action: "new")
  end

  it "routes to GET /sign_in" do
    expect(get: "/sign_in").to route_to(controller: "givey_rails/sessions", action: "new")
  end

  it "routes to new_session_path" do
    expect(post: session_path).to route_to(controller: "givey_rails/sessions", action: "create")
  end

  it "routes to POST /sign_in" do
    expect(post: "/sign_in").to route_to(controller: "givey_rails/sessions", action: "create")
  end

  it "routes to facebook_session_path" do
    expect(get: facebook_session_path).to route_to(controller: "givey_rails/sessions", action: "new_facebook")
  end

  it "routes to GET /sign_in/facebook" do
    expect(get: "sign_in/facebook").to route_to(controller: "givey_rails/sessions", action: "new_facebook")
  end

  it "routes to facebook_callback_path" do
    expect(get: facebook_callback_path).to route_to(controller: "givey_rails/sessions", action: "create_facebook")
  end

  it "routes to GET /callback_facebook" do
    expect(get: "callback_facebook").to route_to(controller: "givey_rails/sessions", action: "create_facebook")
  end

  it "routes to destroy_session_path" do
    expect(get: destroy_session_path).to route_to(controller: "givey_rails/sessions", action: "destroy")
  end

  it "routes to destroy_session_path" do
    expect(delete: destroy_session_path).to route_to(controller: "givey_rails/sessions", action: "destroy")
  end

  it "routes to GET /sign_out" do
    expect(get: "/sign_out").to route_to(controller: "givey_rails/sessions", action: "destroy")
  end

end
