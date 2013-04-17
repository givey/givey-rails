# -*- encoding : utf-8 -*-
module GiveyRails

  module TestHelpers

    SPEC_ROOT = File.expand_path('../../../spec', __FILE__)
    
    %w( business channel charity donation me user ).each do |model_name|

      define_method("#{model_name}_json") do
        File.read(File.join(SPEC_ROOT, "support/demo_json/#{model_name}.json"))
      end

      define_method("#{model_name}_hash") do
        Hashie::Mash.new(JSON.parse(send("#{model_name}_json")))
      end

    end

  end

end
