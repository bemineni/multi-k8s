docker build -t bemineni/multi-client:latest -t bemineni/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bemineni/multi-server:latest -t bemineni/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bemineni/multi-worker:latest -t bemineni/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bemineni/multi-client
docker push bemineni/multi-server
docker push bemineni/multi-worker

docker push bemineni/multi-client:$SHA
docker push bemineni/multi-server:$SHA
docker push bemineni/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=bemineni/multi-client:$SHA
kubectl set image deployments/server-deployment server=bemineni/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=bemineni/multi-worker:$SHA