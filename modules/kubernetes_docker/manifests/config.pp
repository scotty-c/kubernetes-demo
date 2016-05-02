class kubernetes_docker::config {

  wget::fetch { 'kubectl':
    source      => 'https://storage.googleapis.com/kubernetes-release/release/v1.1.7/bin/linux/amd64/kubectl',
    destination => '/usr/bin/kubectl',
    require     => Class['kubernetes_docker::install']
    } ->

  file { '/usr/bin/kubectl':
  	mode   => '0777',
    } ->

   kubectl_config {'default-cluster':
     cluster      => 'kubernetes',
     kube_context => 'puppet',
     }
}
