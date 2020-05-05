---
driver:
  name: dokken
  chef_version: latest
  privileged: true
  volumes: [ '/var/lib/docker' ]

transport:
  name: dokken

provisioner:
  name: dokken
  always_update_cookbooks: true


verifier:
  name: inspec

platforms:
  - name: centos-6.7

suites:
  - name: default
    verifier:
      inspec_tests:
        - test/integration/default
    attributes:
