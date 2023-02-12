docker build -t cakitomakito/multi-client:latest -t cakitomakito/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cakitomakito/multi-server:latest -t cakitomakito/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cakitomakito/multi-worker:latest -f cakitomakito/multi-worker:$SHA -t ./worker/Dockerfile ./worker
docker push cakitomakito/multi-client:latest
docker push cakitomakito/multi-client:$SHA  
docker push cakitomakito/multi-server:latest
docker push cakitomakito/multi-server:$SHA 
docker push cakitomakito/multi-worker:latest
docker push cakitomakito/multi-worker:$SHA 
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cakitomakito/multi-server:$SHA
kubectl set image deployments/client-deployment client=cakitomakito/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cakitomakito/multi-worker:$SHA


