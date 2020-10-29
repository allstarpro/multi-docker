docker build -t allstarpro/multi-client:latest -t allstarpro/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t allstarpro/multi-server:latest -t allstarpro/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t allstarpro/multi-worker:latest -t allstarpro/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push allstarpro/multi-client:latest
docker push allstarpro/multi-server:latest
docker push allstarpro/multi-worker:latest

docker push allstarpro/multi-client:$SHA 
docker push allstarpro/multi-server:$SHA 
docker push allstarpro/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=allstarpro/multi-server:$SHA
kubectl set image deployments/client-deployment server=allstarpro/multi-client:$SHA
kubectl set image deployments/worker-deployment server=allstarpro/multi-worker:$SHA