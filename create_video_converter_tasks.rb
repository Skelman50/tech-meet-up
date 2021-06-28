module Converter
  class CreateJob
    attr_reader :file_key, :input_format

    def initialize(file_key, input_format)
      @file_key = file_key
      @input_format = input_format
    end
    
    def call
      create_job = ::Typhoeus::Request.new(
          ENV['CLOUD_CONVERT_JOB'],
          method: :post,
          body: payload,
          headers: { Accept: "application/json", Authorization: ENV['CLOUD_CONVERT_TOKEN'] }
        )
      create_job.run
      JSON.parse(create_job.response.response_body)
    end

    def payload
      {
        tasks: {
          'import': {
            operation: 'import/s3',
            bucket: ENV['AWS_VIDEO_BUCKET_NAME'],
            region: ENV['AWS_REGION'],
            access_key_id: ENV['AWS_ACCESS_KEY_ID'],
            secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
            key: "video_cache/#{file_key}"
          },
          'convert': {
            operation: 'convert',
            input_format: input_format,
            output_format: 'mp4',
            input: ['import-1'],
            preset: 'ultrafast',
            timeout: 600,
            fps: 30,
            crf: 28,
          },
          'export': {
            operation: 'export/s3',
            input: ['task-1'],
            bucket: ENV['AWS_VIDEO_BUCKET_NAME'],
            region: ENV['AWS_REGION'],
            access_key_id: ENV['AWS_ACCESS_KEY_ID'],
            secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
            key: "video_cache/#{file_key}"
          },
        },
      }      
    end

  end
end
