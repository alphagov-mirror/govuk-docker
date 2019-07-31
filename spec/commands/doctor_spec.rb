require "spec_helper"
require_relative "../../lib/govuk_docker/commands/doctor"

describe GovukDocker::Commands::Doctor do
  let(:repo) { GovukDocker::Repo }
  let(:dnsmasq) { GovukDocker::Dnsmasq }
  let(:docker) { GovukDocker::Docker }
  let(:checks) { [repo, dnsmasq, docker] }

  describe "#call" do
    context "when no argument is passed" do
      it "runs all the checks" do
        arg = nil

        checks.each { |check| expect(check).to receive(:call).with(arg) }

        subject.call(arg)
      end
    end

    context "when the 'fix' argument is passed" do
      it "runs all the checks" do
        arg = "fix"

        checks.each { |check| expect(check).to receive(:call).with(arg) }

        subject.call(arg)
      end
    end

    context "when an unexpected argument is passed" do
      it "returns information about the correct usage" do
        arg = "wrong"
        output_message = "Unrecognised argument '#{arg}'. Usage: `govuk-docker doctor [fix]`"

        expect(STDOUT).to receive(:puts).with(output_message)

        subject.call(arg)
      end
    end
  end
end
