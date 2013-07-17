all: build

build: elixir
	./elixir build

elixir: elixir.hs
	ghc --make elixir.hs
	./elixir clean

publish: build
	./elixir deploy

preview: build
	./elixir preview -p 9876

check: build
	./elixir check

clean: 
	./elixir clean
	rm -f elixir
	rm -f elixir.hi elixir.o
