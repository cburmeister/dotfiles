" Vim syntax file
" Language: TODO
" Last Change: 2012-07-25
" Author: Jesse Dubay <jesse@thefortytwo.net>
" Version: 0.3.0

if exists("b:current_syntax")
finish
endif

syn match todoTopLevel /^[^x\- ].*$/
syn match todoHeaderDelim /^[\-\=]*$/
syn match todoLineItem /^\s*[\-\*] .*$/
syn match todoDoneItem /^\s*x .*$/
syn match todoImportantItem /^\s*! .*$/
syn match todoImportantItem /^\s*[\-\*] .*!.*$/
syn match todoQuestionItem /^\s*[\-\*] .*?.*$/
syn match todoQuestionItem /^\s*? .*$/
syn match todoNoteItem /^\s*\. .*$/
syn match todoInProgressItem /^\s*> .*$/

hi link todoTopLevel Function
hi link todoHeaderDelim Comment
hi link todoLineItem Normal
hi link todoDoneItem Comment
hi link todoImportantItem Title
hi link todoQuestionItem Special
hi link todoNoteItem SpecialComment
hi link todoInProgressItem String

let b:current_syntax = "todo"
