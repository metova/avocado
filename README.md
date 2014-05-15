== Avocado

Avocado hooks into your Rails specs and generates a YAML file containing useful information. It sends
that YAML file to a configurable URL where you can do whatever you want with it, such as display API
documentation for your mobile team.

== Installation

Use bundler to install Avocado by adding this line to your Gemfile:

  gem "avocado", github: "metova/avocado"

Install the gem:

  bundle install

== RSpec

Add this line to the top of +spec/spec_helper.rb+:

  require 'avocado/rspec'

Avocado will attach an ```after_action``` to your controllers that will store information about your requests
if they response is JSON.

== Configuration

You can configure Avocado using the `Avocado::Config.configure` block, here are the options with defaults:

  Avocado::Config.configure do |c|
    c.url = nil
    c.headers = []
    c.document_if = -> { true }
  end

`c.url` MUST be set to a valid URL. This is the URL that Avocado will POST the yaml file to.

`c.headers` is an array of headers that Avocado should document if they exist (for example `['Authorization'])

`c.document_if` is a lambda (or any `call`able object) that determines whether or not Avocado will
document a spec. You may find it useful to only run Avocado in certain environments (continuous integration for example)

== Usage

Avocado will automatically attach itself to all JSON requests in the test environment. If you would like
to disable documentation for a particular spec, you can set your spec's `document` metadata to false:

  it 'will not document with Avocado', document: false do
    # ...
  end

== Middleware

On each JSON request, Avocado runs through a suite of middleware to generate the YAML information, check
configuration options, etc. Avocado middleware responds to `call` and accepts three arguments: the RSpec
example object, the controller request, and the controller response.

If the middleware yields `false`, the spec is not documented. For example, here is an excerpt from the
`DocumentMetadata` middleware:

  def call(example, *)
    if example.metadata[:document] == false
      yield false
    else
      yield
    end
  end

You can add middleware like this:

  Avocado::Middleware.configure do |chain|
    chain << YourClassHere
  end
