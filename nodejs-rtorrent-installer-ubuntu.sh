echo "### Nwgat NodejS-rTorrent Installer ###"

echo "Username (user@domain)"
read user

echo "Password"
read pw

echo "Hostname or domain (no http!)"
read host

add-apt-repository ppa:chris-lea/node.js -y
apt-get update
apt-get install -y python g++ make nodejs rtorrent git supervisor
ufw allow 3000
echo ""
echo "Packages Installed"
echo ""

adduser rtorrent --disabled-password

mkdir /home/rtorrent/rtdl
echo "scgi_port = localhost:5000" >> /home/rtorrent/.rtorrent.rc
echo "directory = /home/rtorrent/rtdl" >> /home/rtorrent/.rtorrent.rc
echo "session = /home/rtorrent/.session/" >> /home/rtorrent/.rtorrent.rc
mkdir /home/rtorrent/.session/
echo ""
echo "rTorrent Configured"
echo ""
git clone https://github.com/roastlechon/nodejs-rtorrent.git /home/rtorrent/nodejs-rtorrent
mv /home/rtorrent/nodejs-rtorrent/src/node/config/config.json /home/rtorrent/nodejs-rtorrent/src/node/config/config.json.bak
curl -o /home/rtorrent/nodejs-rtorrent/src/node/config/config.json 

sed -i 's/userhost/'$host'/g' /home/rtorrent/nodejs-rtorrent/src/node/config/config.json
sed -i 's/useremail/'$user'/g' /home/rtorrent/nodejs-rtorrent/src/node/config/config.json
sed -i 's/userpass/'$pws'/g' /home/rtorrent/nodejs-rtorrent/src/node/config/config.json

chown -R rtorrent:rtorrent /home/rtorrent
su rtorrent -c "cd /home/rtorrent/nodejs-rtorrent && npm install"

echo ""
echo "NodeJS-rTorrent Installed"
echo ""
wget https://raw.githubusercontent.com/nwgat/supervisor-configs/master/rtorrent.conf -o /etc/supervisor/conf.d/rtorrent.conf
wget https://raw.githubusercontent.com/nwgat/supervisor-configs/master/nodejs-rtorrent.conf -o /etc/supervisor/conf.d/njr.conf
echo "chown=rtorrent:rtorrent" >> /etc/supervisor/supervisord.conf
service supervisor start
supervisorctl status

echo "Supervisor Configured"

