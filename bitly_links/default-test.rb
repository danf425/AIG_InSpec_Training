describe http('http://localhost', enable_remote_worker: true) do 
    its('status')  { should cmp 200 }  
    its('body')  { should cmp 'Inspec Jumpstart' }
    its('headers.Content-Type')  { should cmp 'text/html' }
  end
  