require 'avocado/middleware/document_metadata'
require 'avocado/middleware/document_if_configuration'
require 'avocado/middleware/request_serialization'
require 'avocado/middleware/response_serialization'
require 'avocado/middleware/resource_serialization'
require 'avocado/middleware/example_serialization'
require 'avocado/middleware/ignore_xhr_requests'

Avocado::Middleware.configure do |chain|
  chain << Avocado::Middleware::DocumentMetadata
  chain << Avocado::Middleware::DocumentIfConfiguration
  chain << Avocado::Middleware::RequestSerialization
  chain << Avocado::Middleware::ResponseSerialization
  chain << Avocado::Middleware::ResourceSerialization
  chain << Avocado::Middleware::ExampleSerialization
  chain << Avocado::Middleware::IgnoreXhrRequests
end