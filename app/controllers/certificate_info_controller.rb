class CertificateInfoController < ApplicationController
    def expiration_date
      cert = OpenSSL::X509::Certificate.new(File.read(Rails.root.join('config', 'server.crt')))
      expiration_date = cert.not_after.strftime('%Y-%m-%d %H:%M:%S')
      render json: { expiration_date: expiration_date }
    end
end
