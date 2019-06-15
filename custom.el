;;; custom.el --- Emacs Configuration through Custom
;;  Author: Ian Y.E. Pan
;;; Commentary:
;;; Code:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (monokai-pro)))
 '(custom-safe-themes
   (quote
    ("0285789af8d0028dcfeb9eab76cea88368c8acabc6bdf2f94e0131c985c9bf01" default)))
 '(flycheck-display-errors-delay 3.9)
 '(org-capture-templates
   (quote
    (("n" "Note" entry
      (file+headline "~/Dropbox/orgzly/notes.org" "NOTES")
      "* %?
Entered on %U
  %i
  %a")
     ("t" "Task" entry
      (file+headline "~/Dropbox/orgzly/TODO.org" "Tasks")
      "* TODO %?
  %u
  %a")
     ("j" "Journal" entry
      (file+olp+datetree "~/Dropbox/orgzly/journal.org")
      "* %?
Entered on %U
  %i
  %a"))))
 '(package-selected-packages
   (quote
    (evil-magit indent-guide evil-nerd-commenter evil-visualstar treemacs-evil treemacs-projectile treemacs projectile evil-leader org which-key ranger company evil magit smooth-scrolling rainbow-mode org-bullets ido-vertical-mode highlight-operators highlight-numbers highlight-escape-sequences flycheck auto-indent-mode)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 98 :family "Fira Code" :foundry "outline" :slant normal :weight normal :width normal))))
 '(company-preview-common ((t (:foreground unspecified :background "#606b67a67aef"))))
 '(company-scrollbar-bg ((t (:background "#49e94f755e3d"))))
 '(company-scrollbar-fg ((t (:background "#6bab73bf8948"))))
 '(company-tooltip ((t (:inherit default :background "#49e94f755e3d"))))
 '(company-tooltip-common ((t (:inherit font-lock-constant-face))))
 '(company-tooltip-selection ((t (:inherit font-lock-keyword-face)))))


(provide 'custom)
;;; custom.el ends here
