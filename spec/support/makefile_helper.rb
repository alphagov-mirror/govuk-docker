module MakefileHelper
  def self.dependencies(service_name)
    filename = File.join("services", service_name, "Makefile")
    rule = File.readlines(filename).first
    rule.split(":")[1].scan(/[\w\-_]+/)
  end
end
