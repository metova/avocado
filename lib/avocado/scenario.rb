module Avocado
  # Extension methods for "normal" scenarios (no outline)
  module Scenario
    attr_accessor :resource, :request, :response

    def heading
      title
    end

    def steps
      expr = to_sexp
      invocations = expr.select { |e| e.kind_of?(Array) && e.first.eql?(:step_invocation) }

      # Combine the predicate and the step into one string.
      #   s[2] is "Given ", "When ", etc.
      #   s[3] is the rest of the step definition
      # Joining by a new line is so that they show up correctly in the HTML, since they are placed
      # in a <pre> tag with `white-space: pre-wrap` (so the lines will wrap on new lines, as in Terminal)
      invocations.map { |s| s[2] + s[3] }.join "\n"
    end
  end
end