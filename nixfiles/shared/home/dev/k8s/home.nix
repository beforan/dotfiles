# This is the BASE module for system-level Kubernetes Dev Stuff
#
# It may be imported by more specific system configurations e.g. `./linux.nix`
# Use the most specific system configuration modules you can in your Host configuration
#
{pkgs, ...}: {
  home.packages = with pkgs; [
    minikube
    kubectl
    kubernetes-helm
    k9s
  ];
}
