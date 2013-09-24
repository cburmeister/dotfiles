install:
	@echo "Initializing Submodules"
	git submodule init
	git submodule update

	@echo "Removing Old Files"
	rm -rf ~/bin
	rm -f ~/.vimrc
	rm -f ~/.vim
	rm -f ~/.ackrc
	rm -f ~/.zshrc
	rm -f ~/.tmux.conf
	rm -f ~/.gitconfig
	rm -f ~/.pythonrc.py
	rm -f ~/.editrc
	rm -f ~/.my.cnf
	rm -f ~/.inputrc
	rm -f ~/.screenrc
	rm -rf ~/.mongo-hacker/
	
	@echo "Linking New Files"
	ln -s ~/.dotfiles/bin ~/bin
	ln -s ~/.dotfiles/vimrc ~/.vimrc
	ln -s ~/.dotfiles/vim ~/.vim
	ln -s ~/.dotfiles/ackrc ~/.ackrc
	ln -s ~/.dotfiles/zshrc ~/.zshrc
	ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
	ln -s ~/.dotfiles/gitconfig ~/.gitconfig
	ln -s ~/.dotfiles/pythonrc.py ~/.pythonrc.py
	ln -s ~/.dotfiles/editrc ~/.editrc
	ln -s ~/.dotfiles/my.cnf ~/.my.cnf
	ln -s ~/.dotfiles/inputrc ~/.inputrc
	ln -s ~/.dotfiles/screenrc ~/.screenrc
	ln -s ~/.dotfiles/mongo-hacker/mongo_hacker.js ~/.mongorc.js

	@echo "Updating submodules"
	git submodule foreach git pull origin master --recurse-submodules
