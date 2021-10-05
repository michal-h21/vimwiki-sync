# vimwiki-sync

This plugin:

 - automatically synchronize Vimwiki notes directory on Vimwiki startup and exit using Git.
 - it also synchronizes Task Warrior automatically
 - changed files are auto-committed. 

# Install

Use your Vim plugin manager, for example using Vundle, add this line to your `.vimrc`:

    Plugin 'git@github.com:michal-h21/vimwiki-sync.git'

### vim-plug

    Plug 'michal-h21/vimwiki-sync'

# Usage

This plugin automatically commit changes in Vimwiki directories. You need to initialize 
Git repository in these directories by hand.

Vimwiki directories can be configured using these `g:vimwiki_list` variable in `.vimrc`, 
for example:

    let g:vimwiki_list = [{'path':'$HOME/notes'}]

This configuration declares the `$HOME/notes` as Vimwiki directory. You can initialize 
Git directory using:

    $ cd ~/notes
    $ git init

You can add remote repository for your project. `Vimwiki-sync` will push all changes to your 
remote on Vim exit, and pull changes on Vimwiki startup.

    $ git remote add origin git@github.com:username/repo.git 

