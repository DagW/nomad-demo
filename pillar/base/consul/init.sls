# vim: set softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent syntax=yaml:

consul:
  # Start Consul agent service and enable it at boot time
  service: True

  # Set user and group for Consul config files and running service
  user: consul
  group: consul

  version: 1.4.3
  download_host: releases.hashicorp.com

  config:
    server: False
    bind_addr: 0.0.0.0
    advertise_addr: "{%- for interface, ips in grains['ip4_interfaces'].items()
                           if interface not in ['lo', 'cni0', 'docker0'] and
                           not interface.startswith('veth') and
                           ips|length > 0 %}
                           {%- if loop.first %}
                             {{- ips[0] -}}
                           {%- endif %}
                     {%- endfor %}"

    enable_debug: True
    datacenter: vagrant
    encrypt: "RIxqpNlOXqtr/j4BgvIMEw=="
    retry_interval: 15s
    retry_join:
      - 10.10.10.10
      - 10.10.10.11
      - 10.10.10.12
    ui: False
    log_level: info
    data_dir: /var/consul
    connect:
      enabled: True
