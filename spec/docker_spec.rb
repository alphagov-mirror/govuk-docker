require "spec_helper"
require "./lib/govuk_docker/docker"

describe GovukDocker::Docker do
  subject { described_class }

  let(:installed_check) { "which docker 1>/dev/null" }
  let(:running_check) { "pgrep docker 1>/dev/null" }
  let(:docker_file) { "/usr/local/sbin/docker" }

  let(:file_in_path) { false }
  let(:file_present) { false }
  let(:running) { false }

  before do
    expect(subject).to receive(:system).with(installed_check)
      .and_return(file_in_path)
    expect(File).to receive(:exist?).with(docker_file)
      .and_return(file_present)
    expect(subject).to receive(:system).with(running_check)
      .and_return(running)
  end

  context "when docker is not installed" do
    let(:file_in_path) { false }
    let(:file_present) { false }

    context "and no argument is passed" do
      let(:arg) { nil }

      it "should report that it is not installed" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::NOT_INSTALLED_MESSAGE)
      end

      xit "should not try to install docker" do
        # TODO: do it
      end
    end

    context "and the 'fix' argument is passed" do
      let(:arg) { "fix" }

      it "should report that it is not installed" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::NOT_INSTALLED_MESSAGE)
      end

      xit "should try to install docker" do
        # TODO: do it
      end
    end
  end

  context "when docker is installed" do
    let(:file_in_path) { true }
    let(:file_present) { true }

    context "and no argument is passed" do
      let(:arg) { nil }

      it "should report that it is installed" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::INSTALLED_MESSAGE)
      end

      xit "should not try to install docker" do
        # TODO: do it
      end
    end

    context "and the 'fix' argument is passed" do
      let(:arg) { "fix" }

      it "should report that it is installed" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::INSTALLED_MESSAGE)
      end

      xit "should not try to install docker" do
        # TODO: do it
      end
    end
  end

  context "when docker is not running" do
    let(:running) { false }

    context "and no argument is passed" do
      let(:arg) { nil }

      it "should report that it is not running" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::NOT_RUNNING_MESSAGE)
      end

      xit "should not try to install docker" do
        # TODO: do it
      end
    end

    context "and the 'fix' argument is passed" do
      let(:arg) { "fix" }

      it "should report that it is not running" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::NOT_RUNNING_MESSAGE)
      end

      xit "should try to install docker" do
        # TODO: do it
      end
    end
  end

  context "when docker is running" do
    let(:running) { true }

    context "and no argument is passed" do
      let(:arg) { nil }

      it "should report that it is running" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::RUNNING_MESSAGE)
      end

      xit "should not try to install docker" do
        # TODO: do it
      end
    end

    context "and the 'fix' argument is passed" do
      let(:arg) { "fix" }

      it "should report that it is running" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::RUNNING_MESSAGE)
      end

      xit "should not try to install docker" do
        # TODO: do it
      end
    end
  end
end
