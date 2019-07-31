class GovukDocker::Docker
  CHECKING_MESSAGE = "\r\nChecking docker".freeze
  INSTALLED_MESSAGE = "✅ Docker is installed".freeze
  NOT_INSTALLED_MESSAGE = <<~HEREDOC.freeze
    ❌ Docker not found.
    You should install Docker by grabbing the latest image from https://docs.docker.com/docker-for-mac/release-notes/.
    For manual installation, visit https://docs.docker.com/install/.
  HEREDOC
  RUNNING_MESSAGE = "✅ Docker is running".freeze
  NOT_RUNNING_MESSAGE = <<~HEREDOC.freeze
    ❌ Docker is not running.
    Please make sure Docker is running before using govuk-docker.
  HEREDOC

  def self.call(fix)
    puts CHECKING_MESSAGE
    puts installed? ? INSTALLED_MESSAGE : NOT_INSTALLED_MESSAGE
    puts running? ? RUNNING_MESSAGE : NOT_RUNNING_MESSAGE
    fix_it if fix
  end

private

  def self.installed?
    system "which docker 1>/dev/null" || File.exist?("/usr/local/sbin/docker")
  end

  def self.running?
    system "pgrep docker 1>/dev/null"
  end

  def self.fix_it
    # TODO: do it
  end
end
