Puppet::Type.newtype(:kubectl_config) do
    @doc = "configures kubernetes cluster"

    ensurable do
      defaultvalues
      defaultto :present
    end

    newparam(:name, :namevar => true) do
      desc "resource name"
    end  

    newparam(:cluster) do
      desc "cluster nickname"
    end 

    newparam(:kube_context) do
      desc "the context to add to the cluster"
    end 
 end  