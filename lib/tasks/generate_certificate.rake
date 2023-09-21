namespace :certificates do
  desc 'Generate CA and Server certificates'
  task generate_certificates: :environment do
    ca_cert_path = Rails.root.join('config', 'ca.crt')
    ca_key_path = Rails.root.join('config', 'ca.key')
    server_cert_path = Rails.root.join('config', 'server.crt')
    server_key_path = Rails.root.join('config', 'server.key')

    # Generate CA certificate and key
    CertificateGenerator.generate_ca_certificate(ca_key_path, ca_cert_path)
    puts 'CA certificate generated successfully.'

    # Generate server certificate and key
    CertificateGenerator.generate_server_certificate(server_key_path, server_cert_path, ca_cert_path, ca_key_path)
    puts 'Server certificate generated successfully.'
  end
end
