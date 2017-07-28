module FV
  class HasManyAssociation
    def initialize(from_resource, to_resource_class, relationship_name)
      @from_resource = from_resource
      @to_resource_class = to_resource_class
      @relationship_name = relationship_name
      clean
    end

    def <<(object)
      object_hash = { id: object.id, type: object.class.resource_type }
      return self if @unsaved_related_resource_hashes.include?(object_hash)

      @unsaved_related_resource_hashes.append(object_hash)
      dirty
      self
    end

    def modified?
      @modified
    end

    def save
      return self unless modified?
      response = @from_resource
        .class
        .client
        .request(:post, relationship_path, body: serialized)
      return self unless response.successful?
      clean
      self
    rescue FV::RelationExistsError
      clean
      self
    end

    def method_missing(method, *args, &block)
      related_resources.public_send(method, *args, &block) || super
    end

    def respond_to_missing?(*args)
      related_resources.respond_to?(*args) || super
    end

    private

    def related_resources
      @related_resources ||= begin
        data = @from_resource
          .class
          .client
          .request(:get, related_path)
          .data
        data.map { |obj| @to_resource_class.new(obj) }
      end
    end

    def dirty
      @modified = true
    end

    def clean
      @unsaved_related_resource_hashes = []
      @modified = false
    end

    def serialized
      {
        data: @unsaved_related_resource_hashes
      }.to_json
    end

    def relationship_path
      "#{@from_resource.path}/relationships/#{@relationship_name}"
    end

    def related_path
      "#{@from_resource.path}/#{@relationship_name}"
    end
  end
end
