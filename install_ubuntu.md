
``` bash
set -e
# Install from scratch the tools and a workspace on a new ubuntu desktop machine

sudo apt-get update
sudo apt-get install -y git xclip 
curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker $USER
sudo service docker start
newgrp docker; newgrp $USER # Hack to force adding the docker group without logout

# Install google-chrome
cd /tmp; wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb; sudo dpkg -i google-chrome*.deb

### Create a scratch directory
SCRATCH=/home/scratch
sudo chgrp adm $SCRATCH
sudo chmod g+rwx $SCRATCH
cd $SCRATCH

### Create new SSH keys
ssh-keygen -b 2048 -t rsa -f $HOME/.ssh/id_rsa -q -N ""
echo "Public key for this machine. Please add it to bitbucket or github: "
cat $HOME/.ssh/id_rsa.pub
xclip -sel clip < $HOME/.ssh/id_rsa.pub
sensible-browser https://bitbucket.org/account/user/$USER/ssh-keys/
echo "Click <Add key> and paste the public key which is in the clipboard"

### Default git configuration
git config --global user.email "$USER@gmail.com"
git config --global user.name "$(getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1)"
git config --global color.ui auto
mkdir ~/bin
PATH=~/bin:$PATH
echo PATH=~/bin:$PATH >> ~/.bashrc
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

### Clone source code
git clone https://github.com/jguiraudet/jguiraudet.github.io
mkdir ws; cd ws
repo init -u git@bitbucket.org:jguiraudet/manifests.git
repo sync -qj8

### Update aliases
echo 'alias gp="git push bitbucket HEAD:master"' >> ~/.bash_aliases


```
