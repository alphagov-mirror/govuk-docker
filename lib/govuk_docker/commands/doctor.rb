require_relative "./base"
require_relative "../repo"
require_relative "../dnsmasq"
require_relative "../docker"

class GovukDocker::Commands::Doctor < GovukDocker::Commands::Base
  def call(fix)
    if fix && fix != "fix"
      puts "Unrecognised argument '#{fix}'. Usage: `govuk-docker doctor [fix]`"
    else
      GovukDocker::Repo.call(fix)
      GovukDocker::Dnsmasq.call(fix)
      GovukDocker::Docker.call(fix)
    end
  end
end
