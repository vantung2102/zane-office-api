# frozen_string_literal: true

module JSONAPIRender
  extend ActiveSupport::Concern

  included do
    include Pagination
  end

  def render_resource_collection(resources, options = {})
    if resources.instance_of?(Array) && options[:each_serializer].blank?
      raise ArgumentError,
            'must have :each_serializer options for Array collection'
    end

    serializer_options, render_options = extract_options(options, as_collection: true)
    serializer_class = render_options[:each_serializer] || default_resource_collection_seralizer_class(resources)

    render json: serializer_class.render(resources, serializer_options), status: render_options[:status] || :ok
  end

  def render_resource(resource, options = {})
    serializer_options, render_options = extract_options(options)
    serializer_class = render_options[:serializer] || default_resource_seralizer_class(resource)

    render json: serializer_class.render(resource, serializer_options), status: render_options[:status] || :ok
  end

  def render_resource_errors(errors, options = {})
    api_error = APIError::RecordInvalidError.new(errors)
    render json: APIErrorSerializer.new(error), status: options[:status] || api_error.status
  end

  private

  def default_resource_collection_seralizer_class(resources)
    "#{resources.klass}Serializer".constantize
  end

  def default_resource_seralizer_class(resource)
    "#{resource.class}Serializer".constantize
  end

  def extract_options(options, as_collection: false)
    sopts = options.except(*render_options_keys)
    ropts = options.slice(*render_options_keys)

    if as_collection
      sopts[:root] = :data
      sopts[:meta] = (sopts[:meta] || {}).merge(paginate_meta(ropts[:pagy])) if ropts[:pagy]
    end

    [sopts, ropts]
  end

  def accepted_jsonapi_serializer_options
    %i[meta links include params]
  end
end
