vimstaller
==========

VIM automatic plugin installer. Install your vim configuration anywhere!

### How it works
[Short video](http://www.youtube.com/watch?v=l0-yuJYAjog) showing how the whole thing works.

### How to use it
Linux:
```bash
wget https://raw.github.com/mateuszgachowski/vimstaller/master/vimstall.sh
chmod a+x vimstall.sh
./vimstall.sh
```
Mac:
```bash
curl -O https://raw.github.com/mateuszgachowski/vimstaller/master/vimstall.sh
chmod a+x vimstall.sh
./vimstall.sh
```

And answer some questions! ;)

- - -

If you want (of course) use your plugins list and your .vimrc just change first few lines in the vimstall.sh file:

```bash
# Sources
# URL to your plugins file, check this one to know the syntax
PLUGINS_URL="https://raw.github.com/mateuszgachowski/vimstaller/master/plugins.txt"
# You can leave this - this is the newest version of pathogen
PATHOGEN_URL="https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim"
# Feel free to change it to any .vimrc file
VIMRC_URL="https://raw.github.com/mateuszgachowski/vimstaller/master/.vimrc"
```

### Requirements

- vim (of course ;))
- curl
- git

### Tested

Vimstaller has been tested on Mac and Ubuntu Linux.

If you can test it on other platforms and will find any bugs, please report them.
