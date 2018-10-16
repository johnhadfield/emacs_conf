(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))
(add-to-list 'package-archives
             '("MELPA Stable" . "https://stable.melpa.org/packages/") t)

;; Load elpy Python package
(package-initialize)
(elpy-enable)

;;Adding path for elpy
(setenv "PATH" (concat (getenv "PATH") ":~/.local/bin/"))
(add-to-list 'exec-path "~/.local/bin/")

;;Fix common Mac issues: http://www.flycheck.org/en/latest/user/installation.html#syntax-checking-tools
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


;; Add visual regexp
(require 'visual-regexp)
(define-key global-map (kbd "C-c r") 'vr/replace)
(define-key global-map (kbd "C-c q") 'vr/query-replace)
;; if you use multiple-cursors, this is for you:
(define-key global-map (kbd "C-c m") 'vr/mc-mark)


;; Load Solaris theme stored in source: https://github.com/sellout/emacs-color-theme-solarized
(add-to-list 'load-path "~/.emacs.d/solarized-color-theme")
(load-theme 'solarized t)

;; Keyboard hook for Magit
(global-set-key (kbd "C-x g") 'magit-status)


(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))
(global-set-key [home] 'smart-beginning-of-line)
(global-set-key "\C-a" 'smart-beginning-of-line)
(put 'erase-buffer 'disabled nil)

;; Set directory for temp auto-save files to be the user emacs directory so they don't clutter up our source folders
(setq auto-save-file-name-transforms
          `((".*" ,(concat user-emacs-directory "auto-save/") t))) 

;; Same for the backups
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups/")))))
