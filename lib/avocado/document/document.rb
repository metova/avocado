module Avocado
  # Representation of a partial for this Engine. The documentation is split
  # up into two parts: _sidebar.html.erb and _documentation.html.erb, each
  # having a Document object that handles I/O
  class Document
    # Remember this file's path when initialized, so it can be saved later
    # Since all of the write actions are performed at once, the document
    # can be emptied when initialized
    def initialize(filepath)
        @filepath = Avocado::Engine.root.join filepath
        @doc = ""
      end

    # Save the file :)
    def save!
      File.open(@filepath, File::WRONLY|File::CREAT) do |f|
        f.write @doc
      end
    end

protected

    # Append the html given to the document. As each document is just a string,
    # this is just a simple `concat`, but this method is available if the
    # document objects change to some sort of object like a Nokogiri::HTML::Document
    # or something (which I was using earlier... too messy though)
    def append(html)
      @doc.concat html
    end

    def doc
      @doc
    end

    # Convenience method to return a new Builder object for constructing HTML elements
    def html_builder
      ::Builder::XmlMarkup.new
    end
  end
end