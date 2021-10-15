docker build -t delchan/multi-client:latest  -t delchan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t delchan/multi-server:latest  -t delchan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t delchan/multi-worker:latest  -t delchan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push delchan/multi-client:latest
docker push delchan/multi-client:$SHA
docker push delchan/multi-server:latest
docker push delchan/multi-server:$SHA
docker push delchan/multi-worker:latest
docker push delchan/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployment/server-deployment server=delchan/multi-server:$SHA
kubectl set image deployment/client-deployment client=delchan/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=delchan/multi-worker:$SHA