
set -x
set -e

# Configuration variable:
SCRATCH=/home/scratch

# Install from scratch the tools and a workspace on a new ubuntu desktop machine
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y git xclip openssh-server
sudo apt-get install -y nvidia-346-uvm

# Install docker
curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker $USER
sudo service docker start

# Install google-chrome
cd /tmp; wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb; sudo dpkg -i google-chrome*.deb
google-chrome http://jguiraudet.github.io/install_ubuntu.md &

### Create a scratch directory
sudo mkdir -p  $SCRATCH
sudo chgrp adm $SCRATCH
sudo chmod g+rwx $SCRATCH
cd $SCRATCH

### Create new SSH keys
ssh-keygen -b 2048 -t rsa -f $HOME/.ssh/id_rsa -q -N ""
echo "Public key for this machine. Please add it to bitbucket or github: "
cat $HOME/.ssh/id_rsa.pub

### Default git configuration
git config --global user.email "$USER@gmail.com"
git config --global user.name "$(getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1)"
git config --global color.ui auto
mkdir ~/bin
PATH=~/bin:$PATH
echo PATH=~/bin:$PATH >> ~/.bashrc
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
ssh -T git@github.com 
ssh -T git@bitbucket.org 
cd $SCRATCH
git clone https://github.com/jguiraudet/jguiraudet.github.io
mkdir $SCRATCH/ws; cd $SCRATCH/ws
repo init -u git@bitbucket.org:jguiraudet/manifests.git
repo sync -qj8

### Update aliases
echo 'alias gp="git push bitbucket HEAD:master"' >> ~/.bash_aliases

newgrp docker; newgrp $USER # Hack to force adding the docker group without logout
echo "Done. Please logout."

