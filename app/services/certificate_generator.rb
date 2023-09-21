require 'openssl'

class CertificateGenerator
  def self.generate_ca_certificate(ca_key_path, ca_cert_path)
    # Generate a CA certificate and key
    ca_key = OpenSSL::PKey::RSA.new(2048)
    ca_cert = OpenSSL::X509::Certificate.new

    ca_cert.version = 2
    ca_cert.serial = 1
    ca_cert.subject = OpenSSL::X509::Name.parse('/CN=MyCA')
    ca_cert.issuer = ca_cert.subject
    ca_cert.public_key = ca_key.public_key
    ca_cert.not_before = Time.now
    ca_cert.not_after = Time.now + 365 * 24 * 60 * 60 # 1 year validity

    ca_extension_factory = OpenSSL::X509::ExtensionFactory.new
    ca_extension_factory.subject_certificate = ca_cert
    ca_extension_factory.issuer_certificate = ca_cert
    ca_cert.add_extension(ca_extension_factory.create_extension('subjectKeyIdentifier', 'hash'))

    ca_cert.sign(ca_key, OpenSSL::Digest::SHA256.new)

    # Save CA certificate and key to files
    File.write(ca_cert_path, ca_cert.to_pem)
    File.write(ca_key_path, ca_key.to_pem)

    # Export CA's public key
    ca_public_key_path = ca_cert_path.to_s.gsub('.crt', '_public.crt')
    File.write(ca_public_key_path, ca_cert.public_key.to_pem)
  end

  def self.generate_server_certificate(server_key_path, server_cert_path, ca_cert_path, ca_key_path)
    # Load the CA certificate and key
    ca_cert = OpenSSL::X509::Certificate.new(File.read(ca_cert_path))
    ca_key = OpenSSL::PKey::RSA.new(File.read(ca_key_path))

    # Generate a server certificate and key
    server_key = OpenSSL::PKey::RSA.new(2048)
    server_cert = OpenSSL::X509::Certificate.new

    server_cert.version = 2
    server_cert.serial = 2
    server_cert.subject = OpenSSL::X509::Name.parse('/CN=MyServer')
    server_cert.issuer = ca_cert.subject
    server_cert.public_key = server_key.public_key
    server_cert.not_before = Time.now
    server_cert.not_after = Time.now + 365 * 24 * 60 * 60 # 1 year validity

    server_extension_factory = OpenSSL::X509::ExtensionFactory.new
    server_extension_factory.subject_certificate = server_cert
    server_extension_factory.issuer_certificate = ca_cert
    server_cert.add_extension(server_extension_factory.create_extension('subjectKeyIdentifier', 'hash'))

    server_cert.sign(ca_key, OpenSSL::Digest::SHA256.new)

    # Save server certificate and key to files
    File.write(server_cert_path, server_cert.to_pem)
    File.write(server_key_path, server_key.to_pem)
  end

end
