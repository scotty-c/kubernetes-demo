Puppet::Type.newtype(:kubernetes_run) do
    @doc = "configures kubernetes applications to run on our cluster"

    ensurable do
      defaultvalues
      defaultto :present
    end

    newparam(:service_name, :namevar => true) do
      desc "resource name"
    end  

    newparam(:image) do
      desc "the docker image to use"
    end 

    newparam(:port) do
      desc "the port to expose"
    end 
 end  