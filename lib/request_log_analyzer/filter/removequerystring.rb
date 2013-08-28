module RequestLogAnalyzer::Filter

  # Filter to remove query strings : everything after a '?' in pthe path will be eplaced with <query>
  class RemoveQueryString < Base

    def remove_query_string(value)
      return value.gsub(/(.*)\?.*/, "\\1?<query>")
    end

    def filter(request)
      request.attributes.each do |key, value|
        if key == :path
          request.attributes[key] = remove_query_string(value)
        end
      end
      return request
    end
  end

end
