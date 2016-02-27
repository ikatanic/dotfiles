(set-face-attribute 'default nil :height 140)

(show-paren-mode 1)
(tool-bar-mode 0)
(windmove-default-keybindings 'meta)
(setq-default indent-tabs-mode nil)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(load-theme 'wombat)
(setq tramp-default-method "ssh")

(defun get-compile-command (prefix)
  (if (= prefix 1)
      (concat "g++ " (buffer-name) " -std=c++0x -DLOKALNO -Wno-unused-result -O2 -Wall -o " (file-name-sans-extension (buffer-name)))
  )
)

(defun save-and-quick-compile (prefix) (interactive "p")
  (save-buffer 0)
  (compile (get-compile-command prefix))
)

(defun zuza-quick-run () (interactive)
  (if (file-readable-p "makefile")
      (async-shell-command (concat "make run " make-run-command) )
      (async-shell-command (concat "./" (file-name-sans-extension (buffer-name))))
      )
)

(defun zuza-tc-run-0 () (interactive)
  (async-shell-command (concat "./" (file-name-sans-extension (buffer-name)) " 0"))
)
(defun zuza-tc-run-1 () (interactive)
  (async-shell-command (concat "./" (file-name-sans-extension (buffer-name)) " 1"))
)
(defun zuza-tc-run-2 () (interactive)
  (async-shell-command (concat "./" (file-name-sans-extension (buffer-name)) " 2"))
)
(defun zuza-tc-run-3 () (interactive)
  (async-shell-command (concat "./" (file-name-sans-extension (buffer-name)) " 3"))
)
(defun zuza-tc-run-4 () (interactive)
  (async-shell-command (concat "./" (file-name-sans-extension (buffer-name)) " 4"))
)
(defun zuza-tc-run-5 () (interactive)
  (async-shell-command (concat "./" (file-name-sans-extension (buffer-name)) " 5"))
)
(defun zuza-tc-run-6 () (interactive)
  (async-shell-command (concat "./" (file-name-sans-extension (buffer-name)) " 6"))
)

(defun zuza-c++-mode-hook ()
  (local-set-key "\M-2" 'save-and-quick-compile)
  (local-set-key "\M-3" 'zuza-quick-run)
  (local-set-key "\M-n" 'next-error)
  (local-set-key "\M-p" 'previous-error)
  (local-set-key "\M-4" 'zuza-tc-run-0)
  (local-set-key "\M-5" 'zuza-tc-run-1)
  (local-set-key "\M-6" 'zuza-tc-run-2)
  (local-set-key "\M-7" 'zuza-tc-run-3)
  (local-set-key "\M-8" 'zuza-tc-run-4)
  (local-set-key "\M-9" 'zuza-tc-run-5)
  (local-set-key "\M-0" 'zuza-tc-run-6)
)

(add-hook 'c++-mode-hook 'zuza-c++-mode-hook)

(c-add-style "zuza" 
  '("gnu"
    (c-offsets-alist
     ;; for the full list check the doc for (describe-variable 'c-offsets-alist))
     ;; also, C-x C-o is helpful for quickly tracking the indentation rules
     (arglist-intro . +)
     (arglist-close . 0)
    )
   )
)

(setq c-default-style "zuza")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inverse-video t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(put 'downcase-region 'disabled nil)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") 1)
(package-initialize)

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(require 'ycmd)
(add-hook 'c++-mode-hook 'ycmd-mode)

(require 'company)

(set-variable 'ycmd-server-command '("python" "/home/kale/ycmd/ycmd"))
(require 'company-ycmd)
(company-ycmd-setup)

(set-variable 'ycmd-extra-conf-whitelist '("~/*"))
(add-hook 'after-init-hook 'global-company-mode)


(load "/home/kale/.opam/system/share/emacs/site-lisp/tuareg-site-file")
(add-to-list 'load-path "/home/kale/.opam/system/share/emacs/site-lisp/")


;; Add opam emacs directory to the load-path
(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
;; Load merlin-mode
(require 'merlin)
;; Start merlin on ocaml files
(add-hook 'tuareg-mode-hook 'merlin-mode t)
(add-hook 'caml-mode-hook 'merlin-mode t)
;; Enable auto-complete
(setq merlin-use-auto-complete-mode 'easy)
;; Use opam switch to lookup ocamlmerlin binary
(setq merlin-command 'opam)

