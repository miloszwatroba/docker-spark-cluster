# Docker Spark cluster
Easily scalable Docker based Spark Standalone Cluster created for testing and educational purposes. Inspired by Marco Villarreal's article on [Medium](https://medium.com/@marcovillarreal_40011/creating-a-spark-standalone-cluster-with-docker-and-docker-compose-ba9d743a157f).

## Getting started
#### Build images
```docker build -t spark:2.4.2 .```

#### Start cluster
```docker-compose up -d```

## Scale cluster
```docker-compose up -d --scale spark-worker=4```

## Submit a job using a driver instance
```
docker run --network spark-network \
spark:2.4.2 \
/spark/bin/run-example SparkPi 10
```

## Share files between host and containers
Create a directory called `spark-data` next to your `docker-compose.yml` - the contents of that directory will be available in `/spark-data` on your containers.
