require_relative "./paths"

class GovukDocker::Repo
  CHECKING_MESSAGE = "Checking govuk-docker".freeze
  UP_TO_DATE_MESSAGE = "✅ govuk-docker is up-to-date".freeze
  OUTDATED_MESSAGE = <<~HEREDOC.freeze
    ❌ govuk-docker is outdated.
    You should pull the latest version from https://github.com/alphagov/govuk-docker/.
  HEREDOC

  def self.call(fix)
    puts CHECKING_MESSAGE
    puts up_to_date? ? UP_TO_DATE_MESSAGE : OUTDATED_MESSAGE
    fix_it if fix
  end

private

  def self.up_to_date?
    system "git -C #{govuk_docker_dir} diff master origin/master --exit-code --quiet"
  end

  def self.fix_it
    # TODO: do it
  end

  def self.govuk_docker_dir
    GovukDocker::Paths.govuk_docker_dir
  end
end
