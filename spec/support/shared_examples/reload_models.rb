# Need to reload models when checking for correct attr_accessors
# otherwise spec running order can affect passing
shared_context "reload models" do

  before(:each) do
    GiveyRails.send(:remove_const, described_class.name.demodulize)
    load "#{described_class.name.underscore}.rb"
  end

end
