require "thor"

require_relative "./commands/build"
require_relative "./commands/compose"
require_relative "./commands/prune"
require_relative "./commands/run"
require_relative "./commands/startup"
require_relative "./commands/doctor"
require_relative "./setup/dnsmasq"
require_relative "./setup/homebrew_dependencies"
require_relative "./setup/repo"

class GovukDocker::CLI < Thor
  # https://github.com/ddollar/foreman/blob/83fd5eeb8c4b522cb84d8e74031080143ea6353b/lib/foreman/cli.rb#L29-L35
  class << self
    # Hackery. Take the run method away from Thor so that we can redefine it.
    def is_thor_reserved_word?(word, type)
      return false if word == "run"

      super
    end

    def exit_on_failure?
      true
    end
  end

  package_name "govuk-docker"

  class_option :service, type: :string, default: nil, desc: "The service, defaults to the name of the current working directory (for example `government-frontend`)"
  class_option :stack, type: :string, default: "lite", desc: "The stack of the service (for example `lite`)"
  class_option :verbose, type: :boolean, default: false, desc: "If verbose, the docker-compose arguments will be displayed in full"

  desc "build", "Build the containers for the service, equivalent to running `make` in the `govuk-docker` directory"
  long_desc <<~LONGDESC
    By default, it builds the service in the current directory.
    It can build a different service if specified (e.g. `govuk-docker build --service static`).
  LONGDESC
  def build
    GovukDocker::Commands::Build.new(options).call
  end

  desc "compose ARGS", "Run `docker-compose` with ARGS in the `govuk-docker` environment"
  long_desc <<-LONGDESC
    List all stacks across all apps:

    > govuk-docker compose ps --services

    Stop all containers

    > govuk-docker compose stop
  LONGDESC
  def compose(*args)
    GovukDocker::Commands::Compose.new(options).call(args)
  end

  desc "doctor [FIX]", "Various tests to help diagnose issues when running `govuk-docker`. "
  def doctor(fix = nil)
    GovukDocker::Commands::Doctor.new(options).call(fix)
  end

  desc "prune", "Remove all docker containers, volumes and images"
  def prune
    GovukDocker::Commands::Prune.new(options).call
  end

  desc "run [ARGS]", "Run the container for a service, with option arguments"
  long_desc <<~LONGDESC
    By default, it runs the service in the current directory with the `lite` stack.
    It can run a different service if specified (e.g. `govuk-docker run --service static`).
    It can run with a different stack if specified (e.g. `govuk-docker run --stack app`).
    These two options can be combined (e.g. `govuk-docker run --service static --stack app`).
  LONGDESC
  def run(*args)
    GovukDocker::Commands::Run.new(options).call(args)
  end

  desc "setup", "Configures and installs the various dependencies necessary to run `govuk-docker` successfully"
  long_desc <<~LONGDESC
    * Docker
    * Docker-compose
    * Dnsmasq
  LONGDESC
  def setup
    GovukDocker::Setup::Repo.new(shell).call
    puts
    GovukDocker::Setup::HomebrewDependencies.new(shell).call
    puts
    GovukDocker::Setup::Dnsmasq.new(shell).call
  end

  desc "be [ARGS]", "Alias for `run bundle exec`"
  def be(*args)
    GovukDocker::Commands::Run.new(options).call(%w[bundle exec] + args)
  end

  desc "startup [VARIATION]", "Run the container for a service in the `app` stack, with optional variations, such as `live` or `draft`"
  def startup(variation = nil)
    GovukDocker::Commands::Startup.new(options).call(variation)
  end
end
