name 'mynginx'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'mynginx::default'

# Specify a custom source for a single cookbook:
cookbook 'mynginx', path: '.'
cookbook 'nginx', '= 9.0.0'