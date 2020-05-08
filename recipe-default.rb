include_recipe 'nginx::repo'

package 'nginx' do
  action :install
end

file '/usr/share/nginx/html/index.html' do
  content 'InSpec Jumpstart'
end

service 'nginx' do
  supports status:  true, restart: true, reload: true
  action [ :enable, :start ]
end
