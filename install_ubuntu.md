```
### Install from scratch the tools and a workspace on a new ubuntu desktop machine
sudo apt-get update
sudo apt-get install -y git xclip docker

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

#git clone https://github.com/$USER/$USER.github.io
#cd $USER.github.io
```
