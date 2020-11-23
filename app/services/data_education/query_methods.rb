# frozen_string_literal: true

module DataEducation
  module QueryMethods
    def _eq(key, value)
      if value.nil?
        _null(key)
      else
        "#exact(#{key}, \"#{value}\")"
      end
    end

    def _null(key)
      "#null(#{key})"
    end

    def _start(key, value)
      "#startswith(#{key}, \"#{value}\")"
    end
  end
end
