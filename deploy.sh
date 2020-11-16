docker build -t waqas86/multi-client:latest -t waqas86/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t waqas86/multi-server:latest -t waqas86/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t waqas86/multi-worker:latest -t waqas86/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push waqas86/multi-client:latest
docker push waqas86/multi-server:latest
docker push waqas86/multi-worker:latest

docker push waqas86/multi-client:$SHA
docker push waqas86/multi-server:$SHA
docker push waqas86/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=waqas86/multi-server:$SHA
kubectl set image deployments/client-deployment client=waqas86/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=waqas86/multi-worker:$SHA