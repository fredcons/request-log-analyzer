module RequestLogAnalyzer::Filter

  # Filter to remove path params: everything looking liked a mixed literal / numeric chain in the path will be replaced with <param>
  class RemovePathParams < Base

    def looks_like_param(path_element)
      return path_element =~ /\d/ || (path_element.length > 0 && path_element.upcase == path_element)
    end

    def remove_path_params(value)
      path = value.partition("?").first
      query_string = value.partition("?").last
      path_elements = path.split('/')
      return_path_elements = []
      path_elements.each { | path_element |
        return_path_elements << (looks_like_param(path_element) ? '{param}' : path_element)
      }
      return_path = return_path_elements.join('/')
      return_path = return_path.length > 0 ? return_path : '/'
      return query_string.length > 0 ? return_path + "?" + query_string : return_path
    end

    def filter(request)
      request.attributes.each do |key, value|
        if key == :path
          request.attributes[key] = remove_path_params(value)
        end
      end
      return request
    end
  end

end
