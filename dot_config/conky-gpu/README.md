# conky set up

This conky set up isn't necessarily very robust and might require some tweaking to be ported onto other machines.

In particular, the specific network interfaces my computer has, the mount points of my disks, and the entire GPU row may need to be changed.

For drawing shapes in conky without the hassle, I use [`conky-draw`](https://github.com/fisadev/conky-draw.git), a lua script that offers boilerplate, parametrized code for general shapes such as bar/ring/ellipse graphs.

Note the location of this directory - any `lua_load` calls or import statements in lua scripts should be updated to use it rather than the default `~/.conky`.

## usage

I don't expect this rc will be used elsewhere very much, but to use it make sure to download `./conky_draw.lua` from the `conky-draw` repo and place it here.

After that, adding `conky -c $HOME/.config/conky-gpu/conkyrc` should be sufficient. If not, the error messages may point towards missing import of lua or script files.
