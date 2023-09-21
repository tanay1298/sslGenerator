require 'net/http'
require 'openssl'
require 'json'

class CertificateChecker
  def self.verify_certificate
    ca_cert_path = File.join(__dir__, 'config', 'ca.crt')

    # Create a custom SSL context with your CA certificate
    ssl_context = OpenSSL::SSL::SSLContext.new
    ssl_context.verify_mode = OpenSSL::SSL::VERIFY_PEER
    ssl_context.cert_store = OpenSSL::X509::Store.new
    ssl_context.cert_store.add_file(ca_cert_path)

    api_url = 'https://localhost:443/certificate_info/expiration_date'

    begin
      uri = URI.parse(api_url)

      # Create a new Net::HTTP object and set the custom SSL context
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      http.cert_store = ssl_context.cert_store

      request = Net::HTTP::Get.new(uri.request_uri)

      response = http.request(request)

      data = JSON.parse(response.body)
      expiration_date = data['expiration_date']
      puts "Server SSL certificate expires on: #{expiration_date}"
    rescue Net::HTTPServerException => e
      puts "Error: #{e.message}"
      raise e
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
      raise e
    end
  end
end
