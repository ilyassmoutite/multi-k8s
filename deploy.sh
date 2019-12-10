docker build -t ilyassmt/multi-client:latest -t ilyassmt/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ilyassmt/multi-server:latest -t ilyassmt/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ilyassmt/multi-worker:latest -t ilyassmt/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ilyassmt/multi-client:latest
docker push ilyassmt/multi-server:latest
docker push ilyassmt/multi-worker:latest

docker push ilyassmt/multi-client:$SHA
docker push ilyassmt/multi-server:$SHA
docker push ilyassmt/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ilyassmt/multi-server:$SHA
kubectl set image deployments/client-deployment client=ilyassmt/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ilyassmt/multi-worker:$SHA
