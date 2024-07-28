all:
	love ./

clean:
	rm '/Users/purdy/Library/Application Support/LOVE/lovegame/log.txt'

deepclean:
	rm '/Users/purdy/Library/Application Support/LOVE/lovegame/world.json'
	make clean

images:
	aseprite -b assets/player.aseprite --save-as assets/player.png
	aseprite -b assets/box.aseprite --save-as assets/box.png

serve:
	rm -rf makelove-build
	makelove lovejs
	unzip -o "makelove-build/lovejs/sokoville-lovejs" -d makelove-build/html/
	echo "http://localhost:8000/makelove-build/html/sokoville/"
	python3 -m http.server
