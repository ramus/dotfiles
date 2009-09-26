;; Don't use tabs, ever
(setq-default indent-tabs-mode nil)

;; Color theme
(require 'color-theme)
(color-theme-dark-laptop)

;; Menu bar in terminal mode, great idea
(menu-bar-mode 0)
(column-number-mode 1)

;; paredit mode
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)

(add-hook 'lisp-mode-hook (lambda ()
                            (paredit-mode +1)
                            (auto-fill-mode t)
                            (set-fill-column 80)))

(eval-after-load "paredit"
  '(progn
     (define-key paredit-mode-map (kbd "[") 'insert-parentheses)
     (define-key paredit-mode-map (kbd "]") 'paredit-close-parenthesis)
     (define-key paredit-mode-map (kbd "M-]") 'move-past-close-and-reindent)
     (define-key paredit-mode-map (kbd "(")
       (lambda () (interactive) (insert "[")))
     (define-key paredit-mode-map (kbd ")")
       (lambda () (interactive) (insert "]")))
     (define-key paredit-mode-map (kbd "C-c ;") 'slime-insert-balanced-comments)
     (define-key paredit-mode-map (kbd "C-c M-;") 'slime-remove-balanced-comments)
     (define-key paredit-mode-map (kbd "\"") 'paredit-doublequote)
     (define-key paredit-mode-map (kbd "\\") 'paredit-backslash)
     (define-key paredit-mode-map (kbd "RET") 'paredit-newline)
     (define-key paredit-mode-map (kbd "<return>") 'paredit-newline)
     (define-key paredit-mode-map (kbd "C-j") 'newline)))

;; w3m
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

;; dumb stuff
(setq make-backup-files nil)
(setq ring-bell-function 'ignore)

;; Local copy of the hyperspec
(setq common-lisp-hyperspec-root
      "/usr/share/doc/hyperspec/")

;;; Slime
;; possibly controversial as a global default, but shipping a lisp
;; that dies trying to talk to slime is stupid, so:
(set-language-environment "UTF-8")
(setq slime-net-coding-system 'utf-8-unix)

;; load slime:
(setq load-path (cons "~/lib/clbuild/source/slime" load-path))
(setq load-path (cons "~/lib/clbuild/source/slime/contrib" load-path))
(setq slime-backend "~/lib/clbuild/.swank-loader.lisp")
(setq inhibit-splash-screen t)
(load "~/lib/clbuild/source/slime/slime")
(setq inferior-lisp-program "~/lib/clbuild/clbuild --implementation sbcl preloaded")
(setq slime-use-autodoc-mode t)
(slime-setup '(slime-fancy slime-tramp slime-asdf))
(slime-require :swank-listener-hooks)
(slime)