all:
	love ./

clean:
	rm '/Users/purdy/Library/Application Support/LOVE/lovegame/log.txt'

deepclean:
	rm '/Users/purdy/Library/Application Support/LOVE/lovegame/world.json'
	make clean

system:
	cp templates/system.lua systems/$(name)-system.lua

images:
	aseprite -b assets/player.aseprite --save-as assets/player.png
	aseprite -b assets/box.aseprite --save-as assets/box.png
	aseprite -b assets/solid.aseprite --save-as assets/solid.png
	aseprite -b --layer "north" --frame-tag "idle" assets/male-player.aseprite --sheet assets/male-player-idle-north.png
	aseprite -b --layer "south" --frame-tag "idle" assets/male-player.aseprite --sheet assets/male-player-idle-south.png
	aseprite -b --layer "east" --frame-tag "idle" assets/male-player.aseprite --sheet assets/male-player-idle-east.png
	aseprite -b --layer "west" --frame-tag "idle" assets/male-player.aseprite --sheet assets/male-player-idle-west.png
	aseprite -b --layer "north" --frame-tag "walking" assets/male-player.aseprite --sheet assets/male-player-walking-north.png --data assets/male-player-walking-north.json --format json-array
	aseprite -b --layer "south" --frame-tag "walking" assets/male-player.aseprite --sheet assets/male-player-walking-south.png --data assets/male-player-walking-south.json --format json-array
	aseprite -b --layer "east" --frame-tag "walking" assets/male-player.aseprite --sheet assets/male-player-walking-east.png --data assets/male-player-walking-east.json --format json-array
	aseprite -b --layer "west" --frame-tag "walking" assets/male-player.aseprite --sheet assets/male-player-walking-west.png --data assets/male-player-walking-west.json --format json-array

serve:
	rm -rf makelove-build
	makelove lovejs
	unzip -o "makelove-build/lovejs/sokoville-lovejs" -d makelove-build/html/
	echo "http://localhost:8000/makelove-build/html/sokoville/"
	python3 -m http.server
