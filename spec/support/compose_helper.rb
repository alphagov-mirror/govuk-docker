module ComposeHelper
  def self.app_services
    @app_services ||= all_services.select do |service_name, _service|
      service_name =~ /app(-\w+)?$/
    end
  end

  def self.rails_services
    app_services.select do |_service_name, service|
      service["command"] =~ /rails/
    end
  end

  def self.lite_services
    @lite_services ||= all_services.select do |service_name, _service|
      service_name =~ /lite$/
    end
  end

  def self.all_services
    @all_services ||= begin
                        Dir.glob("services/**/docker-compose.yml")
                          .map { |filename| YAML.load_file(filename) }
                          .reduce({}) { |memo, config| memo.merge(config["services"]) }
                      end
  end

  def self.services(name)
    filename = File.join("services", name, "docker-compose.yml")
    YAML.load_file(filename)["services"]
  end
end
