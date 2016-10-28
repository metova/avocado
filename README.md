Avocado
=======

Avocado hooks into your Rails specs and generates a JSON file containing useful information. It sends
that JSON file to a configurable URL where you can do whatever you want with it, such as display API
documentation for your mobile team.

By default, Avocado comes with an Angular API viewer within `Avocado::Engine`.

### Installation

```
gem "avocado-docs"
bundle
```

### RSpec

Add this line to the top of `spec/spec_helper.rb`:

```ruby
require 'avocado/rspec'
```

Avocado will not document specs that are tagged with `document: false` in the metadata.

### Minitest

Add this line to your `test/test_helper.rb`:

```ruby
require 'avocado/minitest'
```

### Cucumber

Add this line to your `env.rb`:

```ruby
require 'avocado/cucumber'
```

Avocado will not document scenarios that are tagged with `@nodoc`.

### Configuration

You can configure Avocado using the `Avocado.configure` block, here are the options with defaults (further explanation below):

```ruby
Avocado.configure do |config|
  config.url = nil
  config.headers = []
  config.json_path = ::Rails.root
  config.upload_id = proc { SecureRandom.uuid }
  config.document_if = proc { |_request, _response| true }
  config.ignored_params = %w(controller action format)
  config.uploader = Avocado::Uploader.instance
end
```

`url` must be set to a valid URL. Avocado will POST the JSON file to this endpoint. If using the default `Avocado::Engine`, set it to the mounted engine URL at `/specs`, for example: "my-server.com/avocado/specs" if you mounted the engine at "/avocado".

`headers` is an array of headers that Avocado should document if they exist (for example, you may want to document the 'Authorization' header). By default, all headers are ignored because the documentation can be very messy.

`json_path` is the directory will be saved. If using Capistrano, you may want to change this to `Rails.root.join('..', '..', 'shared')` so that it is saved across deployments.

`upload_id` is an identifier that can tie multiple JSON file uploads to a single test run. This can be useful if you have two different test suites (Cucumber and RSpec for example) or if you are running your tests in parallel. On Jenkins, you can set this to `ENV['BUILD_NUMBER']`. By default, the value is randomized so multiple uploads are effectively disabled.

`document_if` is a proc that determines whether or not Avocado will document a spec. This can be useful if you want to set environment variables on CI servers so that only those servers are performing the JSON upload.

`ignored_params` is a list of params that are ignored during documentation. By default, the 'controller', 'action', and 'format' params that Rails sends with every request are ignored. You can add to this array via `<<`, or override it entirely with `=`.

`uploader` is the object that will perform the upload at the end of the test run. If you need some extremely custom behavior, you can override this if you'd like.

### Usage

Avocado will automatically attach itself to all JSON requests in the test environment. It does this by monkeypatching `ActionController::Base` with an `around_action`. If the response is a blank 204 or JSON parseable, the details will be logged and eventually uploaded as JSON.

Avocado comes with a default documentation viewer you can mount as a Rails engine:

```ruby
mount Avocado::Engine, at: '/avocado'
```

It will read the avocado JSON and show a decent looking documentation page.
