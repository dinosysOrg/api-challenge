module SerializableResource
  def parse_json object
    Oj.dump ActiveModelSerializers::SerializableResource.new(object)
  end
end