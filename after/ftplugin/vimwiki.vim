augroup vimwiki
  if !exists('g:zettel_synced')
    let g:zettel_synced = 0
  else
    finish
  endif

  " g:zettel_dir is defined by vim_zettel
  if !exists('g:zettel_dir')
    let g:zettel_dir = vimwiki#vars#get_wikilocal('path') "VimwikiGet('path',g:vimwiki_current_idx)
  endif
  " execute vim function. because vimwiki can be started from any directory,
  " we must use pushd and popd commands to execute git commands in wiki root
  " dir. silent is used to disable necessity to press <enter> after each
  " command. the downside is that the command output is not displayed at all.
  " One idea: what about running git asynchronously?
  function! s:git_action(action)
    execute ':silent !pushd ' . g:zettel_dir . "; ". a:action . "; popd"
    " prevent screen artifacts
    redraw!
  endfunction

  function! My_exit_cb(channel,msg )
    echom "Sync done"
    execute 'checktime' 
  endfunction

  function! My_close_cb(channel)
    " it seems this callback is necessary to really pull the repo
  endfunction


  " pull changes from git origin and sync task warrior for taskwiki
  " using asynchronous jobs
  " we should add some error handling
  function! s:pull_changes()
    if g:zettel_synced==0
      let g:zettel_synced = 1
      if has("nvim")
        let gitjob = jobstart("git -C " . g:zettel_dir . " pull origin master", {"exit_cb": "My_exit_cb", "close_cb": "My_close_cb"})
        let taskjob = jobstart("task sync")
      else
        let gitjob = job_start("git -C " . g:zettel_dir . " pull origin master", {"exit_cb": "My_exit_cb", "close_cb": "My_close_cb"})
        let taskjob = job_start("task sync")
      endif
    endif
  endfunction

  " push changes
  " it seems that Vim terminates before it is executed, so it needs to be
  " fixed
  function! s:push_changes()
    if has("nvim")
      let gitjob = jobstart("git -C " . g:zettel_dir . " push origin master")
      let taskjob = jobstart("task sync")
    else
      let gitjob = job_start("git -C " . g:zettel_dir . " push origin master")
      let taskjob = job_start("task sync")
    endif
  endfunction

  " sync changes at the start
  au! VimEnter * call <sid>pull_changes()
  au! BufRead * call <sid>pull_changes()
  " auto commit changes on each file change
  au! BufWritePost * call <sid>git_action("git add .;git commit -m \"Auto commit + push. `date`\"")
  " push changes only on at the end
  au! VimLeave * call <sid>git_action("git push origin master")
  " au! VimLeave * call <sid>push_changes()
augroup END
