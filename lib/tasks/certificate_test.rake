namespace :certificate_test do
    desc 'Test SSL certificate verification'
    task test: :environment do
      require_relative '../../certificate_checker.rb'
  
      begin
        CertificateChecker.verify_certificate
        puts 'Certificate verification test passed.'
      rescue StandardError => e
        puts "Certificate verification test failed: #{e.message}"
      end
    end
end
  