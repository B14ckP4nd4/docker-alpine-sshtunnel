docker rm -f ssh_tunnel
docker image rm ssh_tunnel
git-crypt unlock /etc/cvsc/secret
find . -type f -print0 | xargs -0 dos2unix --
docker build -t ssh_tunnel --no-cache --build-arg TUNNEL_USER=tunnel .
# create Container
docker create \
  --cap-add=NET_ADMIN \
  --name=ssh_tunnel \
  --network=cwn \
  --privileged \
  -p 2222:22 \
  --restart unless-stopped \
  ssh_tunnel


docker start ssh_tunnel && docker ps -a && docker logs ssh_tunnel -f