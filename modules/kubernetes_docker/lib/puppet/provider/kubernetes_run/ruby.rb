Puppet::Type.type(:kubernetes_run).provide(:ruby) do
  desc "support for configuring a kubernetes cluster"	

  mk_resource_methods

  commands :kubectl => "kubectl"
  commands :docker => "docker"

  def interface
    hostname = Socket.gethostname
    IPSocket.getaddress(hostname) 
  end 

  def kube_run
     run = ['run', "#{(resource[:service_name])}", "--image=#{(resource[:image])}", "--port=#{(resource[:port])}"]
   end
   
   def kube_expose
     run = ['expose', 'rc', "#{(resource[:service_name])}", "--port=#{(resource[:port])}", "--external-ip=#{interface}"]
   end

   def exists?
     Puppet.info("checking kubectl if svc #{(resource[:service_name])} is configured")
     begin
       exists_args = ['get', 'svc']
       run = kubectl *exists_args
       run.match("#{(resource[:service_name])}")
     rescue => e 
       return false
      end
   end
 
   def create
     Puppet.info("running #{(resource[:service_name])} on kubernetes cluster")
     begin
       args = ['get', 'nodes'] 
       kubectl *args
     rescue => e
       retry 
     ensure
       kubectl *kube_run
       kubectl *kube_expose
     end
   end

   def destroy
     Puppet.info("removing application")
     destroy_args = ['rm', '-f', "#{(resource[:service_name])}"]
     docker *destroy_args
   end
 end 