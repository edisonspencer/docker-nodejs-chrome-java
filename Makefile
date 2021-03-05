build: clean
	docker build --progress=plain .

clean:
	yes | docker system prune

validate:
	cat -e -t -v Makefile
