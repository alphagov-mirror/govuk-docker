require "spec_helper"
require "./lib/govuk_docker/dnsmasq"

describe GovukDocker::Dnsmasq do
  subject { described_class }

  let(:installed_check) { "which dnsmasq 1>/dev/null" }
  let(:running_check) { "pgrep dnsmasq 1>/dev/null" }
  let(:running_as_different_user_check) { "ps aux | grep `pgrep dnsmasq` | grep -v `whoami` 1>/dev/null" }
  let(:dnsmasq_resolver_file) { "/etc/resolver/dev.gov.uk" }
  let(:dnsmasq_resolver_string_double) { double }
  let(:right_resolver_content_check) { "nameserver 127.0.0.1\nport 53" }

  let(:installed) { false }
  let(:running) { false }
  let(:running_as_different_user) { false }
  let(:right_resolver_content) { false }

  before do
    expect(subject).to receive(:system).with(installed_check)
      .ordered.and_return(installed)
    expect(subject).to receive(:system).with(running_check)
      .ordered.and_return(running)
    expect(subject).to receive(:system).with(running_as_different_user_check)
      .ordered.and_return(running_as_different_user)
    expect(File).to receive(:read).with(dnsmasq_resolver_file)
      .and_return(dnsmasq_resolver_string_double)
    expect(dnsmasq_resolver_string_double).to receive_message_chain(:strip, :==)
      .with(right_resolver_content_check).and_return(right_resolver_content)
  end

  context "when dnsmasq is not installed" do
    let(:installed) { false }

    context "and no argument is passed" do
      let(:arg) { nil }

      it "should report that it is not installed" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::NOT_INSTALLED_MESSAGE)
      end

      xit "should not try to install dnsmasq" do
        # TODO: do it
      end
    end

    context "and the 'fix' argument is passed" do
      let(:arg) { "fix" }

      it "should report that it is not installed" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::NOT_INSTALLED_MESSAGE)
      end

      xit "should try to install dnsmasq" do
        # TODO: do it
      end
    end
  end

  context "when dnsmasq is installed" do
    let(:installed) { true }

    context "and no argument is passed" do
      let(:arg) { nil }

      it "should report that it is installed" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::INSTALLED_MESSAGE)
      end

      xit "should not try to install dnsmasq" do
        # TODO: do it
      end
    end

    context "and the 'fix' argument is passed" do
      let(:arg) { "fix" }

      it "should report that it is installed" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::INSTALLED_MESSAGE)
      end

      xit "should not try to install dnsmasq" do
        # TODO: do it
      end
    end
  end

  context "when dnsmasq is not running" do
    let(:running) { false }

    context "and no argument is passed" do
      let(:arg) { nil }

      it "should report that it is not running" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::NOT_RUNNING_MESSAGE)
      end

      xit "should not try to run dnsmasq" do
        # TODO: do it
      end
    end

    context "and the 'fix' argument is passed" do
      let(:arg) { "fix" }

      it "should report that it is not running" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::NOT_RUNNING_MESSAGE)
      end

      xit "should try to run dnsmasq" do
        # TODO: do it
      end
    end
  end

  context "when dnsmasq is running" do
    let(:running) { true }

    context "and no argument is passed" do
      let(:arg) { nil }

      it "should report that it is running" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::RUNNING_MESSAGE)
      end

      xit "should not try to run dnsmasq" do
        # TODO: do it
      end
    end

    context "and the 'fix' argument is passed" do
      let(:arg) { "fix" }

      it "should report that it is running" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::RUNNING_MESSAGE)
      end

      xit "should not try to run dnsmasq" do
        # TODO: do it
      end
    end
  end

  context "when dnsmasq is not running as a different user" do
    let(:running_as_different_user) { false }

    context "and no argument is passed" do
      let(:arg) { nil }

      it "should report that it is not running as a different user" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::NOT_RUNNING_AS_DIFFERENT_USER_MESSAGE)
      end

      xit "should not try to run dnsmasq as a different user" do
        # TODO: do it
      end
    end

    context "and the 'fix' argument is passed" do
      let(:arg) { "fix" }

      it "should report that it is not running as a different user" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::NOT_RUNNING_AS_DIFFERENT_USER_MESSAGE)
      end

      xit "should try to run dnsmasq as a different user" do
        # TODO: do it
      end
    end
  end

  context "when dnsmasq is running as a different user" do
    let(:running_as_different_user) { true }

    context "and no argument is passed" do
      let(:arg) { nil }

      it "should report that it is running as a different user" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::RUNNING_AS_DIFFERENT_USER_MESSAGE)
      end

      xit "should not try to run dnsmasq as a different user" do
        # TODO: do it
      end
    end

    context "and the 'fix' argument is passed" do
      let(:arg) { "fix" }

      it "should report that it is running as a different user" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::RUNNING_AS_DIFFERENT_USER_MESSAGE)
      end

      xit "should not try to run dnsmasq as a different user" do
        # TODO: do it
      end
    end
  end

  context "when dnsmasq resolver has not the right content" do
    let(:right_resolver_content) { false }

    context "and no argument is passed" do
      let(:arg) { nil }

      it "should report that it has not the right resolver content" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::NOT_RIGHT_RESOLVER_CONTENT_MESSAGE)
      end

      xit "should not try to write the right dnsmasq resolver content" do
        # TODO: do it
      end
    end

    context "and the 'fix' argument is passed" do
      let(:arg) { "fix" }

      it "should report that it has not the right resolver content" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::NOT_RIGHT_RESOLVER_CONTENT_MESSAGE)
      end

      xit "should try to write the right dnsmasq resolver content" do
        # TODO: do it
      end
    end
  end

  context "when dnsmasq resolver has the right content" do
    let(:right_resolver_content) { true }

    context "and no argument is passed" do
      let(:arg) { nil }

      it "should report that it has the right resolver content" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::RIGHT_RESOLVER_CONTENT_MESSAGE)
      end

      xit "should not try to write the right dnsmasq resolver content" do
        # TODO: do it
      end
    end

    context "and the 'fix' argument is passed" do
      let(:arg) { "fix" }

      it "should report that it has the right resolver content" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::RIGHT_RESOLVER_CONTENT_MESSAGE)
      end

      xit "should not try to write the right dnsmasq resolver content" do
        # TODO: do it
      end
    end
  end
end
