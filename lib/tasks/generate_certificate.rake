namespace :certificates do
    desc 'Generate CA certificate'
    task generate_ca: :environment do
      CertificateGenerator.generate_ca_certificate(
        Rails.root.join('config', 'ca.key'),
        Rails.root.join('config', 'ca.crt')
      )
  
      puts 'CA certificate and keys generated successfully.'
    end
end
