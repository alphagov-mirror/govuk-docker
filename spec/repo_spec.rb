require "spec_helper"
require "./lib/govuk_docker/repo"

describe GovukDocker::Repo do
  subject { described_class }

  around do |test|
    ClimateControl.modify GOVUK_DOCKER_DIR: "/some/directory" do
      test.run
    end
  end

  context "when the repository is outdated" do
    before do
      expect(subject)
        .to receive(:system)
        .with("git -C /some/directory diff master origin/master --exit-code --quiet")
        .and_return(false)
    end

    context "and no argument is passed" do
      let(:arg) { nil }

      it "should report that it is outdated" do
        binding.pry
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::OUTDATED_MESSAGE)
      end

      xit "should not try to update the repo" do
        # TODO: do it
      end
    end

    context "and the 'fix' argument is passed" do
      let(:arg) { "fix" }

      it "should report that it is outdated" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::OUTDATED_MESSAGE)
      end

      xit "should try to update the repo" do
        # TODO: do it
      end
    end
  end

  context "when the repository is up-to-date" do
    before do
      expect(subject)
        .to receive(:system)
        .with("git -C /some/directory diff master origin/master --exit-code --quiet")
        .and_return(true)
    end

    context "and no argument is passed" do
      let(:arg) { nil }

      it "should report that it is up-to-date" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::UP_TO_DATE_MESSAGE)
      end

      xit "should not try to update the repo" do
        # TODO: do it
      end
    end

    context "and the 'fix' argument is passed" do
      let(:arg) { "fix" }

      it "should report that it is up-to-date" do
        expect(capture { subject.call(arg) }[:stdout]).to include(subject::UP_TO_DATE_MESSAGE)
      end

      xit "should not try to update the repo" do
        # TODO: do it
      end
    end
  end
end
