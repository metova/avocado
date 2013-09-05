require 'avocado/example'
require 'erb'

module Avocado
  @examples = []

  def self.store(example)
    @examples << example
  end

  # Generate the documentation from the stored scenarios
  def self.document!
    @resources = @examples.map(&:resource).uniq.sort
    documentation = ERB.new(documentation_template).result binding

    File.open documentation_destination_path, 'w+' do |f|
      f.write documentation
    end
  end

  private

    def self.documentation_template
      IO.read(File.join(root, 'lib', 'avocado', 'views', 'documentation.html.erb'))
    end

    def self.documentation_destination_path
      Rails.root.join('public', 'api-docs.html')
    end

    def self.root
      File.expand_path '../..', __FILE__
    end

end
