require "spec_helper"
require_relative "../../lib/govuk_docker/commands/startup"

describe GovukDocker::Commands::Startup do
  let(:config_directory) { "spec/fixtures" }

  subject { described_class.new(config_directory: config_directory, service: "example-service") }

  let(:compose_command) { double }

  before do
    allow(Thread).to receive(:new).and_yield # to run the thread in the current context
    allow(subject).to receive(:wait_until_can_visit?).and_return(true)
    allow(subject).to receive(:puts)

    expect(GovukDocker::Commands::Compose).to receive(:new)
      .with(a_hash_including(config_directory: config_directory)).and_return(compose_command)
  end

  context "without a variation" do
    it "calls `Run` in the correct stack" do
      expect(compose_command).to receive(:call).with(%w[up example-service-app])
      subject.call
    end
  end

  context "with a variation" do
    it "calls `Run` in the correct stack" do
      expect(compose_command).to receive(:call).with(%w[up example-service-app-e2e])
      subject.call("e2e")
    end
  end

  it "prints the URL of the app" do
    expect(compose_command).to receive(:call).with(%w[up example-service-app])
    expect(subject).to receive(:wait_until_can_visit?).and_return(true)
    expect(subject).to receive(:puts).with("\e[0;34;49mApplication is available at: http://example_service.dev.gov.uk\e[0m")
    subject.call
  end
end
