;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;; (add-hook 'python-mode-hook
;;         (lambda ()
;;             (setq flycheck-python-flake8-executable "/home/rv/miniconda3/bin/flake8")
;;             (setq flycheck-python-pylint-executable "/home/rv/miniconda3/bin/pylint")
;;             (setq flycheck-python-pycompile-executable "/home/rv/miniconda3/bin/python")
;;             (setq flycheck-pylintrc "/home/rv/.pylintrc")
;;             (setq flycheck-python-mypy-executable "/home/rv/miniconda3/bin/mypy")
;;          )
;; )

;;(transient-append-suffix 'magit-dispatch "e" (transient-define-suffix "v" :description "vdiff (dwim)" :command 'vdiff-magit-dwim)
(require 'vdiff)
(define-key vdiff-mode-map (kbd "C-c") vdiff-mode-prefix-map)
(require 'vdiff-magit)
(transient-append-suffix 'magit-dispatch "*" '("v" "vdiff (dwim)" vdiff-magit-dwim))
(transient-append-suffix 'magit-dispatch "v" '("V" "vdiff" vdiff-magit))

;; Bibtex stuff
(setq
 org_notes (concat (getenv "HOME") "/literature/notes")
 zot_bib (concat (getenv "HOME") "/literature/zotero-references.bib")
 org-directory org_notes
 deft-directory org_notes
 org-roam-directory org_notes
 )

(setq reftex-default-bibliography '("/home/rv/literature/zotero-references.bib"))

;; Don't put stupid braces for me in latex mode
(defun my-after-load-cdlatex ()
  (define-key cdlatex-mode-map "_" nil)
  t)
(eval-after-load "cdlatex" '(my-after-load-cdlatex))

;; see org-ref for use of these variables
(use-package org-ref
  :config
  (setq
   org-ref-completion-library 'org-ref-ivy-cite
   org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
   org-ref-default-bibliography (list "/home/rv/literature/zotero-references.bib")
   org-ref-bibliography-notes "/home/rv/literature/bibnotes.org"
   org-ref-note-title-format "* TODO %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n :END:\n\n"
   org-ref-notes-directory "/home/rv/literature/notes"
   org-ref-notes-function 'orb-edit-notes
   ))

(after! org-ref
  (setq bibtex-completion-bibliography "/home/rv/literature/zotero-references.bib"
        bibtex-completion-pdf-field "file"
        bibtex-completion-notes-path "/home/rv/literature/notes/"
        bibtex-completion-notes-template-multiple-files
        (concat
         "#${title}\n"
         "#+ROAM_KEY: cite:${=key=}\n"
         "* TODO Notes\n"
         ":PROPERTIES:\n"
         ":Custom_ID: ${=key=}\n"
         ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
         ":AUTHOR: ${author-abbrev}\n"
         ":JOURNAL: ${journaltitle}\n"
         ":DATE: ${date}\n"
         ":YEAR: ${year}\n"
         ":DOI: ${doi}\n"
         ":URL: ${url}\n"
         ":END:\n\n"
         )
        )
  )

(use-package org-roam
  :hook (org-load . org-roam-mode)
  :commands (org-roam-buffer-toggle-display
             org-roam-find-file
             org-roam-graph
             org-roam-insert
             org-roam-switch-to-buffer
             org-roam-dailies-date
             org-roam-dailies-today
             org-roam-dailies-tomorrow
             org-roam-dailies-yesterday)
  :preface
  ;; Set this to nil so we can later detect whether the user has set a custom
  ;; directory for it, and default to `org-directory' if they haven't.
  (defvar org-roam-directory nil)
  :init
  :config
  (setq org-roam-directory (expand-file-name (or org-roam-directory "roam")
                                             org-directory)
        org-roam-verbose nil  ; https://youtu.be/fn4jIlFwuLU
        org-roam-buffer-no-delete-other-windows t ; make org-roam buffer sticky
        org-roam-completion-system 'default
        )
  )

;; Normally, the org-roam buffer doesn't open until you explicitly call
;; `org-roam'. If `+org-roam-open-buffer-on-find-file' is non-nil, the
;; org-roam buffer will be opened for you when you use `org-roam-find-file'
;; (but not `find-file', to limit the scope of this behavior).
;; (add-hook 'find-file-hook
;;           (defun +org-roam-open-buffer-maybe-h ()
;;             (and +org-roam-open-buffer-on-find-file
;;                  (memq 'org-roam-buffer--update-maybe post-command-hook)
;;                  (not (window-parameter nil 'window-side)) ; don't proc for popups
;;                  (not (eq 'visible (org-roam-buffer--visibility)))
;;                  (with-current-buffer (window-buffer)
;;                    (org-roam-buffer--get-create)))))

;; Hide the mode line in the org-roam buffer, since it serves no purpose. This
;; makes it easier to distinguish among other org buffers.
(add-hook 'org-roam-buffer-prepare-hook #'hide-mode-line-mode)

(use-package company-org-roam
  :after org-roam
  :config
  (set-company-backend! 'org-mode '(company-org-roam company-yasnippet company-dabbrev)))

(use-package org-roam-bibtex
  :after (org-roam)
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (setq org-roam-bibtex-preformat-keywords
        '("=key=" "title" "url" "file" "author-or-editor" "keywords"))
  (setq orb-templates
        '(("r" "ref" plain (function org-roam-capture--get-point)
           ""
           :file-name "${slug}"
           :head "#+TITLE: ${=key=}: ${title}\n#+ROAM_KEY: ${ref}

- tags ::
- keywords :: ${keywords}

\n* ${title}\n  :PROPERTIES:\n  :Custom_ID: ${=key=}\n  :URL: ${url}\n  :AUTHOR: ${author-or-editor}\n  :NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n  :NOTER_PAGE: \n  :END:\n\n"

           :unnarrowed t))))

(use-package org-noter
  :after (:any org pdf-view)
  :config
  (setq
   ;; The WM can handle splits
   org-noter-notes-window-location 'other-frame
   ;; Please stop opening frames
   org-noter-always-create-frame nil
   ;; I want to see the whole file
   org-noter-hide-other nil
   ;; Everything is relative to the main notes file
   org-noter-notes-search-path (list org_notes)
   )
)


(setq imenu-list-focus-after-activation t)
(add-hook 'imenu-list-after-jump-hook #'imenu-list-smart-toggle)
(map! :leader
      :desc "Toggle imenu-list" "t i"
      #'imenu-list-smart-toggle)

;; (define-key magit-mode-map "v" 'vdiff-magit-dwim)
;; (define-key magit-mode-map "E" 'vdiff-magit)
;; (transient-suffix-put 'magit-dispatch "v" :description "vdiff (dwim)")
;; (transient-suffix-put 'magit-dispatch "v" :command 'vdiff-magit-dwim)
;; (transient-suffix-put 'magit-dispatch "E" :description "vdiff")
;; (transient-suffix-put 'magit-dispatch "E" :command 'vdiff-magit)

(after! format
  (set-formatter! 'black "black -q --line-length=119 -")
  )

(setq lsp-clients-clangd-executable "/home/rv/.nix-profile/bin/clangd")
(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

;;(setq projectile-globally-ignored-directories (append projectile-globally-ignored-directories '("~/Documents/bazel-bin" "~/Documents/bazel-Documents" "~/Documents/bazel-out" "~/Documents/bazel-testlogs")))
(after! projectile
  (setq projectile-globally-ignored-directories (append '("/home/rv/Documents/bazel-bin" "/home/rv/Documents/bazel-Documents" "/home/rv/Documents/bazel-out" "/home/rv/Documents/bazel-testlogs") projectile-globally-ignored-directories))
  )

;; workaround to hopefully make projectile not slow down emacs
;; (setq projectile-mode-line
;;          '(:eval (format " Projectile[%s]"
;;                         (projectile-project-name))))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Romeo Valentin"
      user-mail-address "rv@daedalean.ai")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 14 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
