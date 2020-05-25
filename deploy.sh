docker build -t tosolveit/multi-client:latest -t tosolveit/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tosolveit/multi-server:latest -t tosolveit/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tosolveit/multi-worker:latest -t tosolveit/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tosolveit/multi-client:latest
docker push tosolveit/multi-server:latest
docker push tosolveit/multi-worker:latest

docker push tosolveit/multi-client:$SHA
docker push tosolveit/multi-server:$SHA
docker push tosolveit/multi-worker:$SHA



kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tosolveit/multi-server:$SHA
kubectl set image deployments/client-deployment client=tosolveit/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tosolveit/multi-worker:$SHA

