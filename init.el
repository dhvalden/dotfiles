
(require 'package)
(setq package-enable-at-startup nil)

;; https://emacs.stackexchange.com/a/2989
(setq package-archives
      '(("elpa"     . "https://elpa.gnu.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa"        . "https://melpa.org/packages/"))
      package-archive-priorities
      '(("melpa-stable" . 10)
        ("elpa"     . 5)
        ("melpa"        . 0)))

(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)


(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-gruvbox t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-yasnippet elpy-module-django elpy-module-sane-defaults)))
 '(package-selected-packages
   (quote
    (doom-modeline all-the-icons elpy rust-mode magit ess solaire-mode use-package doom-themes))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'solaire-mode)

;; Enable solaire-mode anywhere it can be enabled
(solaire-global-mode +1)
;; To enable solaire-mode unconditionally for certain modes:
(add-hook 'ediff-prepare-buffer-hook #'solaire-mode)

;; ...if you use auto-revert-mode, this prevents solaire-mode from turning
;; itself off every time Emacs reverts the file
(add-hook 'after-revert-hook #'turn-on-solaire-mode)

;; highlight the minibuffer when it is activated:
(add-hook 'minibuffer-setup-hook #'solaire-mode-in-minibuffer)

;; if the bright and dark background colors are the wrong way around, use this
;; to switch the backgrounds of the `default` and `solaire-default-face` faces.
;; This should be used *after* you load the active theme!
;;
;; NOTE: This is necessary for themes in the doom-themes package!
(solaire-mode-swap-bg)

;; (require 'doom-modeline)
;; (doom-modeline-mode 1)
;; (setq doom-modeline-bar-width 3)
;; (setq doom-modeline-major-mode-color-icon nil)


(cua-mode t)
(show-paren-mode 1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(global-display-line-numbers-mode)
(setq column-number-mode t)
;;(set-frame-parameter (selected-frame) 'alpha '(90 . 50))
;;(add-to-list 'default-frame-alist '(alpha . (90 . 50)))
(set-frame-font "Source Code Pro Semibold 10" nil t)


;ess-mode configuration
(setq ess-ask-for-ess-directory nil) 
(setq inferior-R-program-name "/usr/bin/R") 
(setq ess-local-process-name "R") 
(setq ansi-color-for-comint-mode 'filter) 
(setq comint-scroll-to-bottom-on-input t) 
(setq comint-scroll-to-bottom-on-output t) 
(setq comint-move-point-for-output t)
(setq ess-eval-visibly-p nil)
(require 'ess-site)

(tooltip-mode -1)
(setq tooltip-use-echo-area t)

(elpy-enable)
(add-hook 'after-init-hook 'global-company-mode)

(setq org-log-done 'time)
(global-set-key (kbd "C-x g") 'magit-status)
