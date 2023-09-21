# SSL Certificate Generator and Verification
This guide provides quick instructions to set up and test SSL certificate verification in your Ruby project.

### Step 1: Generate SSL Certificates
Generate self-signed SSL certificates for a Certificate Authority (CA) and a server. These certificates are used for SSL verification.
#### Command
```bash
rake certificates:generate_certificates
```

### Step 2: Start the Rails and Puma server with SSL enabled
Configure and start the Puma web server with SSL enabled using the generated certificates.

#### Command
```bash
bundle exec rails s
```

### Step 3: Run the SSL Certificate Verification Test
Test the SSL certificate verification by running a Rake task.
#### Command
```bash
rake certificate_test:test
```