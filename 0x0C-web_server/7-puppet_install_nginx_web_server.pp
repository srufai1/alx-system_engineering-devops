# File:   7-puppet_install_nginx_web_server.pp
# Author: Suleman Rufai
# email:  <srufai100@gmail.com> or <ruftech24@gmail.com>

# Using Puppet| Install Nginx server, setup and configuration

# Ensure Nginx is installed
package { 'nginx':
  ensure => 'installed',
}

# Ensure Nginx service is running and enabled at boot
service { 'nginx':
  ensure     => running,
  enable     => true,
  require    => Package['nginx'],
  subscribe  => File['/etc/nginx/sites-available/default'],  # Restart if config changes
}

# Create the index.html file with 'Hello World' content
file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World',
  require => Package['nginx'],
}

# Add a 301 redirect in the Nginx default site configuration
file_line { 'redirection-301':
  ensure => present,
  path   => '/etc/nginx/sites-available/default',
  after  => 'listen 80 default_server;',
  line   => 'rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;',
  require => Package['nginx'],
  notify  => Service['nginx'],  # Restart Nginx to apply changes
}
