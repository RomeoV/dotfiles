;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(map! :map doom-leader-notes-map
      "b" #'citar-open-notes)

;; never use <return> to autocomplete
;; usually I juts want a new line
(after! company
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "TAB") #'company-complete-selection)
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection)
  )

(after! format
  (set-formatter! 'black "black -q --line-length=119 -")
  )

(after! org
  (add-to-list 'org-babel-load-languages '( (emacs-lisp . t) (julia-vterm . t) (julia . t) (jupyter . t)))
  (map! :leader
        (:prefix-map ("t" . "toggle")
         :desc "Preview pdf"     "P" #'org-inline-pdf-mode
         )
        )
  )

(add-hook! org-mode
  ;; (add-to-list 'org-latex-packages-alist '("" "algorithm2e"))
  (setq org-latex-custom-lang-environments
      '(
        (julia "\\begin{%f}
\\begin{minted}[%o]{julia}
%s\\end{minted}
\\caption{%c}
\\label{%l}\\end{%f}")
        (jupyter-julia "\\begin{%f}
\\begin{minted}[%o]{julia}
%s\\end{minted}
\\caption{%c}
\\label{%l}\\end{%f}")
        ))
)


;; (setq org-latex-pdf-process ("latexmk -f --shell-escape -pdf -%latex -interaction=nonstopmode -output-directory=%o %f"))

;; (use-package! org-ref
;;   :after org
;;   :init
;;   :config
;;   )

;; (use-package! org-ref-helm
;;   :config
;;   (setq org-ref-insert-cite-function 'org-ref-cite-insert-helm
;;         org-ref-insert-label-function 'org-ref-insert-label-link
;;         org-ref-insert-ref-function 'org-ref-insert-ref-link
;;         )
;;   )
;; (use-package! org-ref-ivy
;;   :config
;;   (setq org-ref-insert-cite-function 'org-ref-cite-insert-ivy
;;         org-ref-insert-label-function 'org-ref-insert-label-link
;;         org-ref-insert-ref-function 'org-ref-insert-ref-link
;;         )
;;   )

(add-hook! julia-repl-mode
  (map! :leader
        (:prefix-map ("m" . "mode")
         (:desc "Eval buffer" "b" #'julia-repl-send-buffer
          :desc "Eval region or line" "s" #'julia-repl-send-region-or-line
          )))
  )

(after! citar
  (setq! citar-bibliography '("/home/romeo/Zotero/zotero-bibliography.bib"))
  (setq! citar-notes-paths '("/home/romeo/Zotero/Notes"))
  (setq! citar-at-point-function 'embark-act)
  (defun citar-file-open (file)  ;; open pdf in extenral viewer
    "Open FILE."
    (if (member (file-name-extension file) '("html" "pdf"))
        (citar-file-open-external (expand-file-name file))
      (funcall citar-file-open-function (expand-file-name file))))
  (citar-filenotify-setup '(LaTeX-mode-hook org-mode-hook)) ;; autosync .bib file
  )

(after! ox-latex
  :config
  (add-to-list 'org-latex-classes
               '("tufte_algorithms_book"
                  "\\documentclass{tufte_algorithms_book}
                   [NO-DEFAULT-PACKAGES]"
                  ("\\chapter{%s}" . "\\chapter*{%s}")
                  ("\\section{%s}" . "\\section*{%s}")
                  ("\\subsection{%s}" . "\\subsection*{%s}")
                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Romeo Valentin"
      user-mail-address "valentin.romeo@gmail.com")

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "monospace" :size 17))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-gruvbox)

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
