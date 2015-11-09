
set -x
set -e

# Configuration variable:
SCRATCH=/home/scratch

# Install from scratch the tools and a workspace on a new ubuntu desktop machine
sudo apt-get update
sudo apt-get -y upgrade

# Install docker. See: http://docs.docker.com/engine/installation/ubuntulinux/
sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo bash -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-$(lsb_release -sc) main" > /etc/apt/sources.list.d/docker.list'
sudo apt-get purge lxc-docker*   # Purge the old repo if it exists.
sudo apt-get update
apt-cache policy docker-engine   # Verify that apt is pulling from the right repository.
sudo apt-get install -y docker-engine
sudo usermod -aG docker $USER
newgrp docker; newgrp $USER # Hack to force adding the docker group without logout

 

##sudo apt-get install -y git xclip openssh-server
##sudo apt-get install -y nvidia-346-uvm


# Install google-chrome
cd /tmp; wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb; sudo dpkg -i google-chrome*.deb
google-chrome http://jguiraudet.github.io/install_ubuntu.md &

### Create a scratch directory
set +e
sudo mkdir -p  $SCRATCH
sudo chgrp adm $SCRATCH
sudo chmod g+rwx $SCRATCH
set -e
cd $SCRATCH

### Create new SSH keys
ssh-keygen -b 2048 -t rsa -f $HOME/.ssh/id_rsa -q -N ""
echo "Public key for this machine. Please add it to bitbucket or github: "
cat $HOME/.ssh/id_rsa.pub

### Install and configure git
sudo apt-get install -y git curl
git config --global user.email "$USER@gmail.com"
git config --global user.name "$(getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1)"
git config --global color.ui auto
mkdir ~/bin
PATH=~/bin:$PATH
echo PATH=~/bin:$PATH >> ~/.bashrc
source ~/.bashrc
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

### Publish the machine key
xclip -sel clip < $HOME/.ssh/id_rsa.pub
read -p "Press any key to continue... " -n1 -s
cat $HOME/.ssh/id_rsa.pub
echo "Click <Add key> and paste the public key which is in the clipboard and close the chrome window..."
google-chrome https://bitbucket.org/account/user/$USER/ssh-keys/
google-chrome https://github.com/settings/ssh

### Clone source code

# add github.com and bitbucket.org as known host
echo |1|QR7SLgkxZ25jMJwwfGzJHB9OWvE=|SBS6qFdEwgDXd9ltGFEh6nDK33E= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ== >> ~/.ssh/known_hosts
echo |1|W9gQc+LTMT/YM0sT6TYS6vedXSM=|5XRdshn3+HitISBpzjOsD4teRZk= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ== >> ~/.ssh/known_hosts
echo |1|Mb79VGuKqeNMRG4HHSgLCDZF07s=|etmq1+UuAa6otRVP5GtYL+/dT2k= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ== >> ~/.ssh/known_hosts
sort -u ~/.ssh/known_hosts -o ~/.ssh/known_hosts

cd $SCRATCH
git clone https://github.com/jguiraudet/jguiraudet.github.io
mkdir $SCRATCH/ws; cd $SCRATCH/ws
repo init -u git@bitbucket.org:jguiraudet/manifests.git
repo sync -qj8

### Update aliases
echo 'alias gp="git push bitbucket HEAD:master"' >> ~/.bash_aliases

newgrp docker; newgrp $USER # Hack to force adding the docker group without logout
echo "Done. Please logout."

