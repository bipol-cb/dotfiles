(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/geben-helm-projectile/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/geben_repo/"))

(setq package-enable-at-startup nil)
(package-initialize)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(package-selected-packages
   (quote
    (cider smartparens paredit clojure-mode geben-helm-projectile company-php ac-php php-ext php-mode magit company company-mode auto-complete elm-mode helm-projectile helm evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Thing to allow us to be promted for packages
(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))


(ensure-package-installed 
	'evil
	'helm
	'helm-projectile
	'elm-mode
        'projectile
        'company
        'magit
	'php-mode
	'ac-php
	'company-php
	'clojure-mode
	'smartparens
	'cider
)

;; Require evil mode
(require 'evil)
(evil-mode t)

(require 'helm-config)
(helm-mode 1)

(global-set-key (kbd "C-x C-f") 'helm-find-files)

(require 'helm-projectile)
(setq projectile-enable-caching t)
(projectile-global-mode)
(helm-projectile-on)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(require 'elm-mode)
(setq elm-format-on-save t)
(add-hook 'elm-mode-hook #'elm-oracle-setup-completion)
(add-to-list 'company-backends 'company-elm)

(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

(require 'cl)
(require 'php-mode)
(add-hook 'php-mode-hook
          '(lambda ()
             (require 'company-php)
             (company-mode t)
             (add-to-list 'company-backends 'company-ac-php-backend )))


(setq geben-path-mappings '(("/Users/balam/Repos/careerbuilder/tsr/luceo" "/vagrant")))
(require 'geben)

(require 'geben-helm-projectile)

(require 'clojure-mode)
(add-hook 'clojure-mode-hook #'smartparens-strict-mode)

(require 'cider)
(setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")
