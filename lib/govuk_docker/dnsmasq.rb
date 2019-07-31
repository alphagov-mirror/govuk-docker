class GovukDocker::Dnsmasq
  CHECKING_MESSAGE = "\r\nChecking dnsmasq".freeze
  INSTALLED_MESSAGE = "✅ Dnsmasq is installed".freeze
  NOT_INSTALLED_MESSAGE = <<~HEREDOC.freeze
    ❌ Dnsmasq not found.
    You should install it with `brew install dnsmasq`.
    For a manual installation, visit http://www.thekelleys.org.uk/dnsmasq/doc.html
  HEREDOC
  RUNNING_MESSAGE = "✅ Dnsmasq is running".freeze
  NOT_RUNNING_MESSAGE = <<~HEREDOC.freeze
    ❌ Dnsmasq is not running.
    Dnsmasq needs to run as root.
    You should start it with `sudo brew services start dnsmasq`.
  HEREDOC
  RUNNING_AS_DIFFERENT_USER_MESSAGE = "✅ Dnsmasq is running as the correct user".freeze
  NOT_RUNNING_AS_DIFFERENT_USER_MESSAGE = <<~HEREDOC.freeze
    ❌ Dnsmasq is running under your user.
    Dnsmasq needs to run as root.
    You should start it with `sudo brew services start dnsmasq`.
  HEREDOC
  RIGHT_RESOLVER_CONTENT_MESSAGE = "✅ Dnsmasq is resolving DNS requests".freeze
  NOT_RIGHT_RESOLVER_CONTENT_MESSAGE = <<~HEREDOC.freeze
    ❌ Something else (possibly Vagrant-dns) is configured to resolve DNS requests for dev.gov.uk.
      The /etc/resolver/dev.gov.uk file needs to be updated to only contain
      nameserver 127.0.0.1
      port 53
  HEREDOC

  def self.call(fix)
    puts CHECKING_MESSAGE
    puts installed? ? INSTALLED_MESSAGE : NOT_INSTALLED_MESSAGE
    puts running? ? RUNNING_MESSAGE : NOT_RUNNING_MESSAGE
    puts running_as_different_user? ? RUNNING_AS_DIFFERENT_USER_MESSAGE : NOT_RUNNING_AS_DIFFERENT_USER_MESSAGE
    puts right_resolver_content? ? RIGHT_RESOLVER_CONTENT_MESSAGE : NOT_RIGHT_RESOLVER_CONTENT_MESSAGE
    fix_it if fix
  end

private

  def self.installed?
    system "which dnsmasq 1>/dev/null"
  end

  def self.running?
    system "pgrep dnsmasq 1>/dev/null"
  end

  def self.running_as_different_user?
    system "ps aux | grep `pgrep dnsmasq` | grep -v `whoami` 1>/dev/null"
  end

  def self.right_resolver_content?
    File.read("/etc/resolver/dev.gov.uk").strip == "nameserver 127.0.0.1\nport 53"
  end

  def self.fix_it
    # TODO: do it
  end
end
