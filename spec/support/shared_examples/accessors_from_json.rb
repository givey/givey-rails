shared_examples "a givey_rails model with attr_accessors" do
  
  let(:subject)     { described_class.new }
  let(:object_hash) { send("#{described_class.name.demodulize.underscore}_hash") }

  it "should have all the correct accessors" do
    object_hash.keys.each do |method_from_json_key|
      should respond_to(method_from_json_key)
    end
  end
  
end
