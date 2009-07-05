require 'aws/s3'

module PictureSafe
  
  class << self
    
    def backup(home_directory)
      puts "Starting Backup!"
      
      pictures = Dir.glob([home_directory, ENV['PHOTO_ROOT'], '**/*.jpg'].join('/'))
      
      changes = pictures - pictures_in_safe
      
            
      changes.each_with_index do |photo, index|
        store photo
        puts "Stored #{photo}"
        puts "Completed #{index + 1} of #{changes.length}"
      end
      "Finished Backup!"
    end
    
    def pictures_in_safe
      get_conn
      pictures = []
      get_bucket.objects.each do |s3object|
        pictures << "/" + s3object.key
      end
      pictures
    end
    
    def store(filename)
      AWS::S3::S3Object.store(filename, open(filename, "rb"), ENV['PHOTO_BUCKET'], :access => :public_read)
    end
    
    def get_conn
      AWS::S3::Base.establish_connection!(
        :access_key_id => ENV['AMAZON_ACCESS_KEY_ID'],
        :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
      )    
    end
    
    
    def get_bucket
      AWS::S3::Bucket.create(ENV['PHOTO_BUCKET'])
      AWS::S3::Bucket.find(ENV['PHOTO_BUCKET'])
    end
    
    def s3_list
      get_conn
      
      old = []

      bucket = AWS::S3::Bucket.find(get_bucket)

      # Get Old List from S3?
      pic_list = bucket.objects

      pic_list.each do |item|
        old << item.value
      end

      old      
    end
    
    def s3_store(filename)
      AWS::S3::S3Object.store(
        file_name,
        open(file_name, "rb"),
        get_bucket,
        :access => :public_read
      )
    end
    
  end
  
end
