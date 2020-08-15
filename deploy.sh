docker build -t xdcc/multi-client:latest -t xdcc/multo-client:$SHA -f ./client/Dockerfile ./client
docker build -t xdcc/multi-server:latest -t xdcc/multo-server:$SHA -f ./server/Dockerfile ./server
docker build -t xdcc/multi-worker:latest -t xdcc/multo-worker:$SHA -f ./worker/Dockerfile ./worker

docker push xdcc/multi-client:latest
docker push xdcc/multi-server:latest
docker push xdcc/multi-worker:latest

docker push xdcc/multi-client:$SHA
docker push xdcc/multi-server:$SHA
docker push xdcc/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=xdcc/multi-client:$SHA
kubectl set image deployments/server-deployment server=xdcc/multi-server:$SHA
kubectl set image deployments/server-deployment server=xdcc/multi-worker:$SHA