(setq evil-want-C-u-scroll t)  ; use C-u to scroll up half a page
(evil-mode 1)
(evil-ex-define-cmd "q" 'kill-this-buffer) ; prevent accidentally killing the frame

(defun ian/save-and-kill-this-buffer ()
  (interactive)
  (save-buffer)
  (kill-this-buffer))
(evil-ex-define-cmd "wq" 'ian/save-and-kill-this-buffer)

(add-hook 'prog-mode-hook 'company-mode)
(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))

(require 'color)
(let ((bg (face-attribute 'default :background))
      (ac (face-attribute 'match :foreground)))
  (custom-set-faces
   `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 15)))))
   `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 15)))))
   `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 30)))))
   `(company-tooltip-selection ((t (:inherit font-lock-keyword-face))))
   `(company-tooltip-common ((t (:inherit font-lock-constant-face))))
   `(company-preview-common ((t (:foreground ,ac :background ,(color-lighten-name bg 25)))))))

(add-hook 'after-init-hook 'global-flycheck-mode)
(setq ispell-program-name "/usr/local/bin/aspell")

;; Core Ido
(ido-mode 1)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-vertical-define-keys 'C-n-C-p-up-and-down)

;; Vertical (for better visibility)
(ido-vertical-mode 1)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq js-indent-level 2)
(setq c-default-style
      '((java-mode . "java")
        (awk-mode . "awk")
        (other . "k&r")))
(setq-default c-basic-offset 4)

(defun ian/newline-and-push-brace ()
  "`newline-and-indent', but bracket aware."
  (interactive)
  (insert "\n")
  (when (looking-at "}")
    (insert "\n")
    (indent-according-to-mode)
    (forward-line -1))
  (indent-according-to-mode))
(global-set-key (kbd "RET") 'ian/newline-and-push-brace)

;; In order for 'pdflatex' to work. Also had to export PATH from .zshrc
;; export PATH="$PATH:/Library/TeX/texbin"
(setenv "PATH" (concat "/usr/texbin:/Library/TeX/texbin:" (getenv "PATH")))
(setq exec-path (append '("/usr/texbin" "/Library/TeX/texbin") exec-path))

;; Colourful Org LaTeX Code Blocks
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)
(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
(setq org-latex-minted-options '(("linenos=true")))

(setq org-highlight-latex-and-related (quote (latex)))
(setq org-latex-classes
      (quote
       (("article" "\\documentclass[12pt, a4paper]{article}"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))))

(defun ian/load-init()
  "Reload .emacs.d/init.el"
  (interactive)
  (load-file "~/.emacs.d/init.el"))

(global-set-key (kbd "C-x g") 'magit-status)

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-hook 'org-mode-hook 'visual-line-mode)

(set-register ?e '(file . "~/.emacs.d/init.el"))
(set-register ?o '(file . "~/.emacs.d/config.org"))
(set-register ?c '(file . "~/.emacs.d/custom.el"))

(smooth-scrolling-mode 1)
(setq scroll-margin 1
      smooth-scroll-margin 1
      scroll-conservatively 0
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)
(setq-default scroll-up-aggressively 0.01
              scroll-down-aggressively 0.01)

(add-hook 'prog-mode-hook 'electric-pair-mode)

(setq inhibit-splash-screen t)
(setq ring-bell-function 'ignore)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode t)
(setq blink-cursor-blinks 0) ;; blink forever
(setq-default indicate-empty-lines t)
(setq-default line-spacing 3)
(setq frame-title-format '("Emacs"))
(add-hook 'prog-mode-hook 'highlight-numbers-mode)
(add-hook 'prog-mode-hook 'highlight-operators-mode)
(add-hook 'prog-mode-hook 'hes-mode)    ;; highlight escape sequences

(setq make-backup-files nil)

(setq show-paren-delay 0)
(show-paren-mode 1)

(setq initial-scratch-message nil)
(setq initial-major-mode 'org-mode)

(defun ian/toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ;; Also handle undocumented (<active> <inactive>) form.
                    ((numberp (cadr alpha)) (cadr alpha)))
              100)
         '(85 . 85) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'ian/toggle-transparency)

(defun ian/split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'ian/split-and-follow-horizontally)
(defun ian/split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'ian/split-and-follow-vertically)

(which-key-mode t)
(setq which-key-idle-delay 0.5)
(setq which-key-idle-secondary-delay 0.5)

(add-hook 'before-save-hook 'whitespace-cleanup)

(add-hook 'python-mode-hook 'hs-minor-mode)
  (global-evil-leader-mode)
  (evil-leader/set-leader "SPC")
  (evil-leader/set-key
    "e" 'find-file
    "bb" 'switch-to-buffer
    "bn" 'next-buffer
    "bp" 'previous-buffer
    "bk" 'kill-buffer
    "k" 'kill-buffer
    "gs" 'magit-status
    "oc" 'org-capture
    "oa" 'org-archive-subtree
    "pp" 'projectile-switch-project
    "pf" 'projectile-find-file
    "pt" 'treemacs
    "ci" 'evilnc-comment-or-uncomment-lines
    "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
    "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
    "cc" 'evilnc-copy-and-comment-lines
    "cp" 'evilnc-comment-or-uncomment-paragraphs
    "cr" 'comment-or-uncomment-region
    "cv" 'evilnc-toggle-invert-comment-line-by-line
    "."  'evilnc-copy-and-comment-operator
    "\\" 'evilnc-comment-operator ; if you prefer backslash key
)
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-indexing-method 'alien)
  ;;; esc quits
  (defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
  In Delete Selection mode, if the mark is active, just deactivate it;
  then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
      (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
      (abort-recursive-edit)))
  (define-key evil-insert-state-map "jk" 'evil-normal-state)
  (define-key evil-normal-state-map [escape] 'keyboard-quit)
  (define-key evil-visual-state-map [escape] 'keyboard-quit)
  (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
  (global-evil-visualstar-mode)
  (indent-guide-global-mode)
  (setq indent-guide-delay 0.1)
  (setq evil-emacs-state-modes nil)
  (setq evil-insert-state-modes nil)
  (setq evil-motion-state-modes nil)
  (setq evil-normal-state-modes
        (append evil-emacs-state-modes
                evil-insert-state-modes
                evil-normal-state-modes
                evil-motion-state-modes))
  (define-key evil-normal-state-map "j" 'evil-next-visual-line)
  (define-key evil-normal-state-map "k" 'evil-previous-visual-line)
  (define-key evil-visual-state-map "j" 'evil-next-visual-line)
  (define-key evil-visual-state-map "k" 'evil-previous-visual-line)
  (define-key evil-normal-state-map (kbd "C-j") 'move-text-down)
  (define-key evil-normal-state-map (kbd "C-k") 'move-text-up)
  (evil-global-set-key 'normal "H" 'evil-first-non-blank)
  (evil-global-set-key 'visual "H" 'evil-first-non-blank)
  (evil-global-set-key 'motion "H" 'evil-first-non-blank)
  (evil-global-set-key 'normal "L" (lambda () (interactive) (evil-end-of-line)))
  (evil-global-set-key 'visual "L" (lambda () (interactive) (evil-end-of-line)))
  (evil-global-set-key 'motion "L" (lambda () (interactive) (evil-end-of-line)))
  (define-key evil-motion-state-map "gl" 'evil-avy-goto-line)
  (define-key evil-normal-state-map "gl" 'evil-avy-goto-line)
  (define-key evil-motion-state-map "go" 'evil-avy-goto-char-2)
  (define-key evil-normal-state-map "go" 'evil-avy-goto-char-2)
