; installed packages:
; (forge md4rd tuareg evil-magit git github-review ein org-babel-eval-in-repl elpygen bbdb smart-compile
;	ac-emoji emojify nyan-mode evil-tabs realgud smooth-scrolling evil elpy)

(toggle-frame-maximized)

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
  (when (< emacs-major-version 24)
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(elpy-enable)

(add-to-list 'load-path "~/.emacs.d/lisp/")

;;; [#] general configs
(menu-bar-mode -1)
(tool-bar-mode -1)

(global-eldoc-mode -1)

(setq x-select-enable-clipboard t)

(global-set-key (kbd "C-.") #'other-window)
(global-set-key (kbd "C-,") #'prev-window)

(defun prev-window ()
  (interactive)
    (other-window -1))

(setq savehist-additional-variables
	'(search-ring regexp-search-ring))
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)

(add-hook 'emacs-lisp-mode-hook 'ielm-auto-complete)

(setq explicit-shell-file-name "/bin/zsh")
(setq tramp-shell-prompt-pattern "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*")

(require 'evil)
(evil-mode t)
(setq-default evil-search-module 'evil-search)
;(global-evil-tabs-mode t)

; evil stuff for TABS & programming
; if something starts getting fucked up on indendation side, just comment out this whole block!
(add-hook 'python-mode-hook
	(lambda ()
		;(global-set-key (kbd "TAB") 'self-insert-command)
		(setq indent-tabs-mode t)
		(setq python-indent-offset 4)
		(setq tab-width 4)))

(require 'smart-compile)

(require 'ido)
(ido-mode 1)
(setq ido-ignore-buffers '("^ " "*Completions*" "*Shell Command Output*"
		"*Messages*" "*scratch*" "Async Shell Command"))

(setq backup-directory-alist `((".*" . "~/.emacs.d/saves")))
(setq auto-save-file-name-transforms
	`((".*" "~/.emacs.d/saves")))

;(load-file "~/.emacs.d/undo-tree.el")
(global-undo-tree-mode)
(setq undo-tree-auto-save-history t)
(save-place-mode 1)

(setq inhibit-startup-screen t)
(setq initial-scratch-message "")
(setq initial-major-mode 'text-mode)

(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
; (setq smooth-scroll-margin 5)

(set-default-font "Hack 13")
(global-display-line-numbers-mode)
(column-number-mode)

;(add-hook 'after-init-hook 'global-color-identifiers-mode)

(setq
 org-default-todo-file "~/org/todo.org"
 initial-buffer-choice org-default-todo-file)

;;; [#] org-mode
(require 'org)
(setq org-tag-faces '(("important" . (:foreground "red"))
					 ("revisit" . (:foreground "white"))))

;; Reset the global variable to nil, just in case org-mode has already been used
;;(when org-tags-special-faces re
;;	(setq org-tags-special-faces-re nil))

(require 'ox-beamer)
(require 'ox-latex)
(setq org-export-allow-bind-keywords t)
(setq org-latex-listings 'minted)
(add-to-list 'org-latex-packages-alist '("" "minted"))
;(org-babel-do-load-languages 'org-babel-load-languages '((sh . t) (python . t) (C . t) (ruby . t) (js . t)))
(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(setq org-hide-emphasis-markers t)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode)) ;; activate org-mode agenda view
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-log-done 'time)
(setq org-agenda-log-mode-items '(state))
(setq org-todo-keywords
	'((sequence "TODO(t)" "IN PROGRESS(i)" "REVIEW(r)" "PROJECT" "REPEATING" "WAITING(w@/!)" "PAUSED(p)" "|" "DONE(d!)" "CANCELLED(c@)")))
(setq org-todo-keyword-faces
	'(("IN PROGRESS" . "DarkOrange") ("WAITING" . "magenta") ("CANCELLED" . "red") ("DONE" . "green") ("PAUSED" . "orchid"))
 )

(setq org-priority-faces '((65 :foreground "cyan") ; :background "color"
						   (66 :foreground "deep sky blue")
						   (67 . "royal blue")))

(setq org-agenda-use-time-grid t)
(setq org-agenda-time-grid
	(quote
		((daily today remove-match)
		(1000 1200 1400 1600 1800 2000)
		"......" "----------------")))

(setq org-cycle-separator-lines 1)
(add-hook 'org-mode-hook 'visual-line-mode)

;;; [#] latex things
(setq org-format-latex-options (plist-put org-format-latex-options :scale 4.0))

;;; [#] custom random shit
;;; https://lists.gnu.org/archive/html/emacs-orgmode/2016-06/msg00484.html
;;; http://kitchingroup.cheme.cmu.edu/blog/2016/11/04/New-link-features-in-org-9/
(org-link-set-parameters
  "red"
  :face '(:foreground "red"))
(org-link-set-parameters
  "green"
  :face '(:foreground "green"))
(org-link-set-parameters
  "cyan"
  :face '(:foreground "cyan"))

;;; ivy mode config
;(ivy-mode 1)
;(setq ivy-use-virtual-buffers t)
;(setq enable-recursive-minibuffers t)
;;; enable this if you want `swiper' to use it
;;; (setq search-default-mode #'char-fold-to-regexp)
;(global-set-key "\C-s" 'swiper)
;(global-set-key (kbd "C-c C-r") 'ivy-resume)
;(global-set-key (kbd "<f6>") 'ivy-resume)
;(global-set-key (kbd "M-x") 'counsel-M-x)
;(global-set-key (kbd "C-x C-f") 'counsel-find-file)
;(global-set-key (kbd "<f1> f") 'counsel-describe-function)
;(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;(global-set-key (kbd "<f1> l") 'counsel-find-library)
;(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;(global-set-key (kbd "C-c g") 'counsel-git)
;(global-set-key (kbd "C-c j") 'counsel-git-grep)
;(global-set-key (kbd "C-c k") 'counsel-ag)
;(global-set-key (kbd "C-x l") 'counsel-locate)
;(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
;(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;;; emacs auto things
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(ein:jupyter-default-server-command "/usr/bin/jupyter")
 '(ein:polymode t)
 '(org-agenda-files (quote ("~/org/todo.org")))
 '(org-export-preserve-breaks nil)
 '(org-preview-latex-image-directory "~/org/")
 '(org-preview-latex-process-alist
   (quote
    ((dvipng :programs
	     ("latex" "dvipng")
	     :description "dvi > png" :message "you need to install the programs: latex and dvipng." :image-input-type "dvi" :image-output-type "png" :image-size-adjust
	     (1.0 . 1.0)
	     :latex-compiler
	     ("latex -interaction nonstopmode -output-directory %o %f")
	     :image-converter
	     ("dvipng -fg %F -bg %B -D %D -T tight -o %O %f"))
     (dvisvgm :programs
	      ("latex" "dvisvgm")
	      :description "dvi > svg" :message "you need to install the programs: latex and dvisvgm." :use-xcolor t :image-input-type "dvi" :image-output-type "svg" :image-size-adjust
	      (1.7 . 1.5)
	      :latex-compiler
	      ("latex -interaction nonstopmode -output-directory %o %f")
	      :image-converter
	      ("dvisvgm %f -n -b min -c %S -o %O"))
     (imagemagick :programs
		  ("latex" "convert")
		  :description "pdf > png" :message "you need to install the programs: latex and imagemagick." :use-xcolor t :image-input-type "pdf" :image-output-type "png" :image-size-adjust
		  (1.0 . 1.0)
		  :latex-compiler
		  ("pdflatex -interaction nonstopmode -output-directory %o %f")
		  :image-converter
		  ("convert -density %D -trim -antialias %f -quality 100 %O")))))
 '(package-selected-packages
   (quote
    (python-mode magit keychain-environment counsel exec-path-from-shell ssh-agency forge md4rd tuareg evil-magit git github-review ein org-babel-eval-in-repl elpygen bbdb smart-compile ac-emoji emojify nyan-mode evil-tabs realgud smooth-scrolling evil elpy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
