### Avocado

Avocado hooks into your Rails specs and generates a YAML file containing useful information. It sends
that YAML file to a configurable URL where you can do whatever you want with it, such as display API
documentation for your mobile team.

If a URL is not configured, it will generate the YAML file locally. The file will be read by the
Avocado::Engine whenever you visit it's mount point.

### Installation

Use bundler to install Avocado by adding this line to your Gemfile:
```
gem "avocado", github: "metova/avocado"
```

Install the gem:
```
bundle install
```

### RSpec

Add this line to the top of `spec/spec_helper.rb`:

```ruby
require 'avocado/rspec'
```

Avocado will attach an `after_action` to your controllers that will store information about your requests
if they respond with JSON.

### Configuration

You can configure Avocado using the `Avocado::Config.configure` block, here are the options with defaults:

```ruby
Avocado::Config.configure do |c|
  c.url = nil
  c.headers = []
  c.document_if = -> { true }
  c.yaml_path = Rails.root
end
```

`c.url` can be set to a valid URL. This is the URL that Avocado will POST the yaml file to. This is useful when you
want to run the documentation off of a CI server for example.

`c.headers` is an array of headers that Avocado should document if they exist (for example `['Authorization']`)

`c.document_if` is a lambda (or any `call`able object) that determines whether or not Avocado will
document a spec. You may find it useful to only run Avocado in certain environments (CI, for example), so you can check environment variables here or whatever else you need.

`c.yaml_path` is the directory where the YAML file should be stored. It might be nice to change this, for example
if you are using Capistrano you could use the shared dir, setting it `Rails.root.join('..', '..', 'shared')`.

### Usage

Avocado will automatically attach itself to all JSON requests in the test environment. If you would like
to disable documentation for a particular spec, you can set your spec's `document` metadata to false:

```ruby
it 'will not document with Avocado', document: false do
  # ...
end
```

Avocado comes with a default documentation viewer you can mount.

```ruby
mount Avocado::Engine, at: '/avocado'
```

It will read avocado.yml and show a decent looking documentation page. If your URL is configured, the engine will
accept the YAML via POST and store it on the server's file system for use. If your URL is not configured, the avocado.yml
file will be generated anyway and will still be used on localhost.

### Middleware

On each JSON request, Avocado runs through a suite of middleware to generate the YAML information, check
configuration options, etc. Avocado middleware responds to `call` and accepts three arguments: the RSpec
example object, the controller request, and the controller response.

If the middleware yields `false`, the spec is not documented. For example, here is an excerpt from the
`DocumentMetadata` middleware:

```ruby
def call(example, *)
  if example.metadata[:document] == false
    yield false
  else
    yield
  end
end
```

You can add middleware like this:

```ruby
  Avocado::Middleware.configure do |chain|
    chain << YourClassHere
  end
```
