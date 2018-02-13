module DropboxApi::Endpoints::Files
  class Download < DropboxApi::Endpoints::ContentDownload
    Method      = :post
    Path        = "/2/files/download".freeze
    ResultType  = DropboxApi::Metadata::File
    ErrorType   = DropboxApi::Errors::DownloadError

    # Download a file from a user's Dropbox.
    #
    # @param path [String] The path of the file to download.
    add_endpoint :download do |path, range = nil, &block|
      options = { path: path }
      puts "Range: #{range}"
      options.merge!({ range: range }) if range
      puts "Options: #{options}"
      perform_request(options, &block)
    end
  end
end
