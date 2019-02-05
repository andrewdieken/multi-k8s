docker build -t dieke102/multi-client:latest -t dieke102/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dieke102/multi-server:latest -t dieke102/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dieke102/multi-worker:latest -t dieke102/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dieke102/multi-client:latest
docker push dieke102/multi-client:$SHA
docker push dieke102/multi-server:latest
docker push dieke102/multi-server:$SHA
docker push dieke102/multi-worker:latest
docker push dieke102/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dieke102/multi-server:$SHA
kubectl set image deployments/client-deployment client=dieke102/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dieke102/multi-worker:$SHA
