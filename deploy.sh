docker build -t arthursribeiro/multi-client:latest -t arthursribeiro/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arthursribeiro/multi-server:latest -t arthursribeiro/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arthursribeiro/multi-worker:latest -t arthursribeiro/multi-worker:$Sha -f ./worker/Dockerfile ./worker

docker push arthursribeiro/multi-client:latest
docker push arthursribeiro/multi-server:latest
docker push arthursribeiro/multi-worker:latest

docker push arthursribeiro/multi-client:$SHA
docker push arthursribeiro/multi-server:$SHA
docker push arthursribeiro/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=arthursribeiro/multi-server:$SHA
kubectl set image deployments/client-deployment client=arthursribeiro/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=arthursribeiro/multi-worker:$SHA