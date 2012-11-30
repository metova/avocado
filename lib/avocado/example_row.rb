module Avocado
  # Extension methods for scenario outlines (Cucumber passes each example row as an
  # ExampleRow object, which is a child of ScenarioOutline (accessible through scenario_outline)
  module ExampleRow
    attr_accessor :resource, :request, :response

    def heading
      "#{scenario_outline.title} with #{format_name(name)}"
    end

    def steps
      expr = scenario_outline.to_sexp
      invocations = expr.select { |e| e.kind_of?(Array) && e.first.eql?(:step) }

      # Combine the predicate and the step into one string.
      #   s[2] is "Given ", "When ", etc.
      #   s[3] is the rest of the step definition
      # Joining by a new line is so that they show up correctly in the HTML, since they are placed
      # in a <pre> tag with `white-space: pre-wrap` (so the lines will wrap on new lines, as in Terminal)
      invocations.map { |s| s[2] + s[3] }.join "\n"
    end

  protected

    # The name returned for an ExampleRow is ugly:
    #    | key | value |
    # This method makes it much nicer for display in the documentaion:
    #    key: value
    # Probably doesn't work as well for tables with more than 2 columns...
    def format_name(name)
      name[2..-2].humanize.downcase.gsub ' | ', ': '
    end
  end
end