require 'socket'
require 'resolv'
require 'fileutils'

Puppet::Type.type(:kubectl_config).provide(:ruby) do
  desc "support for configuring a kubernetes cluster"	

  mk_resource_methods

  commands :kubectl => "kubectl"
  
  def interface
    hostname = Socket.gethostname
    IPSocket.getaddress(hostname) 
   end 

   def kube_conf_server
     run = ['config','set-cluster', "#{(resource[:cluster])}", "--server=http://#{interface}:8080", '--insecure-skip-tls-verify=true']
   end
   
   def kube_conf_context 
     run = ['config','set-context', "#{(resource[:kube_context])}", "--cluster=#{(resource[:cluster])}"]
   end

   def kube_conf_use 
     run = ['config','use-context', "#{(resource[:kube_context])}"]
   end

   def exists?
     Puppet.info("checking if kubectl is configured")
     File.exist?('/.kube/config')
   end
 
   def create
     Puppet.info("configuring kubernetes cluster")
     kubectl *kube_conf_server
     kubectl *kube_conf_context
     kubectl *kube_conf_use
     FileUtils.ln_s('/.kube', '/root/.kube')
   end

   def destroy
     Puppet.info("removing kubectl config")
     FileUtils.rm_rf('/.kube')
   end
 end  