install:
	@echo "Initializing Submodules"
	git submodule init
	git submodule update

	@echo "Removing Old Files"
	rm -r ~/bin
	rm ~/.vimrc
	rm ~/.vim
	rm ~/.ackrc
	rm ~/.zshrc
	rm ~/.tmux.conf
	rm ~/.gitconfig
	rm ~/.pythonrc.py
	rm ~/.editrc
	rm ~/.my.cnf
	rm ~/.inputrc
	rm ~/.screenrc
	
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

	@echo "Updating submodules"
	git submodule foreach git pull origin master --recurse-submodules
