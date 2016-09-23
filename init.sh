sudo cat ./sources.list > /etc/apt/sources.list
sudo apt-get update

mkdir ~/.pip/
cp ./pip.conf ~/.pip/pip.conf
sudo mkdir /root/.pip
sudo cp ~/pip.conf /root/.pip/pip.conf

sudo apt-get -y install python-pip python3-pip python-setuptools python3-setuptools git vim openssh-server fabric

sudo pip install --upgrade pip
sudo pip3 install --upgrade pip
sudo pip install --upgrade os-testr

sudo pip install pyopenssl ndg-httpsclient pyasn1

echo "USER ALL=(ALL)NOPASSWD:ALL" | sudo tee -a /etc/sudoers

cd ~
git clone https://github.com/openstack-dev/devstack -b stable/kilo
git clone https://github.com/cmusatyalab/elijah-openstack

cd devstack
git checkout stable/kilo
cd ~