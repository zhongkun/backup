 (setq shell-file-name "/bin/zsh") 
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t) 
 (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t) 
