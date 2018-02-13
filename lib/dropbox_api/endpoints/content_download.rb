module DropboxApi::Endpoints
  class ContentDownload < DropboxApi::Endpoints::Base
    def initialize(builder)
      @connection = builder.build("https://content.dropboxapi.com") do |c|
        c.response :decode_result
      end
    end

    def build_request(params)
      body = nil
      range = params[:range]
      range_param = { "Range": "bytes=#{range.min}-#{range.max}" } if range
      params.delete(:range)
      headers = {
        'Dropbox-API-Arg' => JSON.dump(params),
        'Content-Type' => ''
      }
      headers.merge!(range_param) if range_param
      body, headers
    end

    def perform_request(params)
      response = get_response(params)
      api_result = process_response response

      # TODO: Stream response, current implementation will fail with very large
      #       files.
      yield response.body if block_given?

      api_result
    end
  end
end
# TODO:
#  1. Combine ContentDownload and ContentUpload to share its initialize method.
#  2. Reorganize the methods which create the request.
