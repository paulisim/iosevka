#!/usr/bin/env bash

# https://typeof.net/Iosevka/customizer

if [[ ! $(docker images --quiet fontcc) ]]; then
	git clone --depth=1 https://github.com/be5invis/Iosevka.git fontcc

	(cd fontcc/docker && docker build --tag fontcc:latest .)

	rm --force --recursive fontcc
fi

docker run --interactive --name fontcc --rm --tty --user $(id -u):$(id -g) --volume $(pwd):/work fontcc ttf::Iosevka

rsync --delete-after --recursive dist/Iosevka/TTF/ ~/.local/share/fonts/Iosevka/

rm --force --recursive dist

fc-cache --force
