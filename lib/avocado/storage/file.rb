module Avocado
  module Storage
    class File
      def initialize(dir)
        @dir = dir
      end

      def read
        files.map { |filename| ::File.read filename }
      end

      def write(data, upload_id)
        filename = @dir.join "avocado-#{Time.current.to_s(:nsec)}-#{upload_id}.json"
        ::File.open(filename, 'w+') { |f| f.write data }
      end

      def purge_old(upload_id)
        old_files = files.reject { |fn| fn.end_with? "-#{upload_id}.json" }
        ::File.delete(*old_files)
      end

      private
        def files
          Dir.glob @dir.join('avocado*.json')
        end
    end
  end
end
