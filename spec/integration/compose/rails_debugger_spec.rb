require "spec_helper"

RSpec.describe "Compose rails debugger" do
  ComposeHelper.rails_services.each do |service_name, service|
    it "#{service_name} supports attaching an interactive debugger" do
      expect(service["tty"]).to be_truthy
      expect(service["stdin_open"]).to be_truthy
    end
  end
end
