require_relative "../paths"

module GovukDocker::Doctor
  class Checkup
    def initialize(service_name:, checkups:, messages:)
      @checkups = checkups
      @service_name = service_name
      @messages = messages
      @return_messages = []
    end

    def call(fix = nil)
      # puts "Checking govuk-docker"
      # GovukDocker::Doctor::Checkup.new(
      #   service_name: "govuk-docker",
      #   checkups: %i(up_to_date),
      #   messages: GovukDocker::Doctor.messages[:govuk_docker]
      # ).call(fix)
      # puts "\r\nChecking dnsmasq"
      # GovukDocker::Doctor::Checkup.new(
      #   service_name: "dnsmasq",
      #   checkups: %i(installed running dnsmasq_resolver running_as_different_user),
      #   messages: GovukDocker::Doctor.messages[:dnsmasq]
      # ).call(fix)
      # puts "\r\nChecking docker"
      # GovukDocker::Doctor::Checkup.new(
      #   service_name: "docker",
      #   checkups: %i(installed running),
      #   messages: GovukDocker::Doctor.messages[:docker]
      # ).call(fix)
      puts "\r\nChecking docker-compose"
      GovukDocker::Doctor::Checkup.new(
        service_name: "docker-compose",
        checkups: %i(installed),
        messages: GovukDocker::Doctor.messages[:docker_compose]
      ).call(fix)
    end

    def call(fix = nil)
      case fix
      when nil then diagnose
      when "fix" then diagnose_and_cure
      else raise("This shouldn't happen")
      end
    end

  private

    attr_reader :checkups, :service_name, :messages
    attr_accessor :return_messages

    def diagnose
      generate_return_messages
      puts return_messages.join("\r\n")
    end

    def diagnose_and_cure
      diagnose
      cure
    end

    def cure
      GovukDocker::Setup::Repo.new(shell).call if return_messages.include?(messages[:outdated])
      # something if return_messages.include?(messages[:not_installed])
      # something if return_messages.include?(messages[:not_running])
      # something if return_messages.include?(messages[:not_running_as_different_user])
      GovukDocker::Setup::Dnsmasq.new(shell).call if return_messages.include?(messages[:not_dnsmasq_resolver])
    end

    def generate_return_messages
      up_to_date_state_message if checkups.include?(:up_to_date)
      install_state_message if checkups.include?(:installed)
      run_state_message if checkups.include?(:running)
      running_user_message if checkups.include?(:running_as_different_user)
      dnsmasq_resolver_message if checkups.include?(:dnsmasq_resolver)
    end

    def up_to_date_state_message
      return_messages << if up_to_date?
                          messages[:up_to_date]
                        else
                          messages[:outdated]
                        end
    end

    def install_state_message
      return_messages << if installed?
                          messages[:installed]
                        else
                          messages[:not_installed]
                        end
    end

    def run_state_message
      return_messages << if running?
                          messages[:running]
                        else
                          messages[:not_running]
                        end
    end

    def running_user_message
      return_messages << if running_as_different_user?
                          messages[:running_as_different_user]
                        else
                          messages[:not_running_as_different_user]
                        end
    end

    def dnsmasq_resolver_message
      return_messages << if dnsmasq_resolver?
                          messages[:dnsmasq_resolver]
                        else
                          messages[:not_dnsmasq_resolver]
                        end
    end

    def up_to_date?
      @up_to_date ||= system "git -C #{GovukDocker::Paths.govuk_docker_dir} diff master origin/master --exit-code --quiet"
    end

    def installed?
      # some people don't have /usr/local/sbin in their PATH
      @installed ||= system("which #{service_name} 1>/dev/null") \
                       || File.exist?("/usr/local/sbin/#{service_name}")
    end

    def running?
      @running ||= system "pgrep #{service_name} 1>/dev/null"
    end

    def running_as_different_user?
      @running_as_different_user ||= system "ps aux | grep `pgrep #{service_name}` | grep -v `whoami` 1>/dev/null"
    end

    def dnsmasq_resolver?
      File.read("/etc/resolver/dev.gov.uk") == File.read(GovukDocker::Paths.dnsmasq_conf)
    end
  end
end
