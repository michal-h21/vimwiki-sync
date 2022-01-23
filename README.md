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

# Configuration

## Git branch

By default, we push and pull from the current branch of the remove Git
repository. You can set the `g:vimwiki_sync_branch` to select specific branch:

    let g:vimwiki_sync_branch = "main"

## Commit message

You can change the commig message using `g:vimwiki_sync_commit_message` variable. It uses the
[strftime](https://renenyffenegger.ch/notes/development/vim/script/vimscript/functions/strftime)
function for the formatting, so it supports insertion of time stamps. The default value is 
following:

    let g:vimwiki_sync_commit_message = 'Auto commit + push. %c'

# Taskwiki support

Vimwiki-sync automatically synchronize [Taskwiki](https://github.com/tools-life/taskwiki) 
using [Taskwarrior](https://taskwarrior.org/). To disable it, set the following variable:


    let g:sync_taskwarrior = 0
