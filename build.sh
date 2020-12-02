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
  --publish=444:22/tcp \
  --privileged \
  --restart unless-stopped \
  ssh_tunnel

docker start ssh_tunnel && docker logs ssh_tunnel -f