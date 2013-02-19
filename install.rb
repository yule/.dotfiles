`find . -type f \\( -not -iname \"README\" -and -not -iname \"install.rb\" \\) -maxdepth 1 -execdir cp -r '{}' ~ \\;`
`cp -R .vim ~/.vim`
`ln -s ~/.vim/janus/vim/vimrc ~/.vimrc`
