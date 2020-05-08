control 'mynginx-01' do
    title 'Functional Tests'
    desc 'Ensuring the web server is functioning correctly'
    describe http('http://localhost', enable_remote_worker: true) do
        its('status')  { should cmp 200 }
        its('body')  { should cmp 'Inspec Jumpstart' }
        its('headers.Content-Type')  { should cmp 'text/html' }
    end
end
  
control 'mynginx-02' do
    title 'Nginx Version'
    desc 'Checking Nginx Version'
    describe nginx do
      its('version') { should cmp >= '1.10.2' }
    end
end
  
control 'mynginx-03' do
    title 'Mandatory modules'
    desc 'Checking mandatory modules'
    describe nginx do
      its('modules') { should include 'http_ssl' }
      its('modules') { should include 'stream_ssl' }
      its('modules') { should include 'mail_ssl' }
    end
end
  
  
control 'mynginx-04' do
    title 'nginx-http-sysguard check'
    desc 'Checking for nginx-http-sysguard '
    describe nginx do
      its('modules') { should include 'nginx-http-sysguard ' }
    end
  
    only_if { os.debian? }
  
end

control 'mynginx-05' do
    title 'Auth module'
    desc 'Checking for an auth module'
    describe.one do
      describe nginx do
        its('modules') { should include 'http_auth_request' }
      end
  
      describe nginx do
        its('modules') { should include 'nginx-auth-ldap' }
      end
    end
end
  