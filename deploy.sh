docker build -t timlavrysen/multi-client:latest -t timlavrysen/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t timlavrysen/multi-server:latest -t timlavrysen/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t timlavrysen/multi-worker:latest -t timlavrysen/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push timlavrysen/multi-client:latest
docker push timlavrysen/multi-server:latest
docker push timlavrysen/multi-worker:latest

docker push timlavrysen/multi-client:$SHA
docker push timlavrysen/multi-server:$SHA
docker push timlavrysen/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=timlavrysen/multi-client:$SHA
kubectl set image deployments/server-deployment server=timlavrysen/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=timlavrysen/multi-worker:$SHA
