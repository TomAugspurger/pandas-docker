pandas3 :
	docker build -f "./docker32.dockerfile" .


pandas32:
	docker build -t pandas-32 -f "docker32-64.dockerfile"  .

