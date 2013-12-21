install:
	@echo "Linking New Files"
	ln -s ~/dotfiles/zsh ~/.zsh
	ln -s ~/dotfiles/bin ~/bin
	ln -s ~/dotfiles/config ~/.config
	ln -s ~/dotfiles/vimrc ~/.vimrc
	ln -s ~/dotfiles/ackrc ~/.ackrc
	ln -s ~/dotfiles/zshrc ~/.zshrc
	ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
	ln -s ~/dotfiles/gitconfig ~/.gitconfig
	ln -s ~/dotfiles/pythonrc.py ~/.pythonrc.py
	ln -s ~/dotfiles/editrc ~/.editrc
	ln -s ~/dotfiles/screenrc ~/.screenrc

uninstall:
	@echo "Removing Linked Files"
	rm -rf ~/.zsh
	rm -rf ~/bin
	rm -rf ~/.config
	rm -f ~/.vimrc
	rm -f ~/.ackrc
	rm -f ~/.zshrc
	rm -f ~/.tmux.conf
	rm -f ~/.gitconfig
	rm -f ~/.pythonrc.py
	rm -f ~/.editrc
	rm -f ~/.screenrc
