module HttpartyHelper
    def post(url, body, headers = nil)
        p url
        p body
        return HTTParty.post(url, :format => :json, :body => body.to_json, :headers => catch_headers(headers))
    end

    def put(url, body, headers = nil)
        return HTTParty.put(url, :format => :json, :body => body.to_json, :headers => catch_headers(headers))
    end

    def get(url, headers = nil)
        return HTTParty.get(url, headers: catch_headers(headers))
    end
    def delete(url,headers = nil)
        return HTTParty.delete(url, :headers => catch_headers(headers))
    end

    def catch_headers(h)
        return h || {"Content-Type" => "application/json", "Accept" => "application/json"}
    end
end