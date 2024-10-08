;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.

;; See https://libreddit.romeov.me/r/emacs/comments/1118o25/doom_emacs_error_running_hook_globalgitcommitmode/
;; (package! transient :pin "c2bdf7e12c530eb85476d3aef317eb2941ab9440")
;; (package! with-editor :pin "bbc60f68ac190f02da8a100b6fb67cf1c27c53ab")

;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
                                        ;(package! some-package)
(package! org-inline-pdf)

;; (package! org-ref)
;;
;; (package! helm)
;; (package! helm-bibtex)
;; (package! ivy-bibtex)
(package! org-attach-screenshot)

(package! dirvish)

(package! agenix
  ;; :recipe (:host github :repo "RomeoV/agenix.el"))
  :recipe (:local-repo "/home/romeo/Documents/github/agenix.el"))

(package! copilot
  :recipe (:host github :repo "copilot-emacs/copilot.el" :files ("*.el")))
;; (package! copilot
;;   :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))
;; (package! copilot
;;   :recipe (:host github :repo "RomeoV/emacs-copilot" :branch "enable-ssh))
;; (package! org-tufte
;;   :recipe (:host github :repo "Zilong-Li/org-tufte"))
(package! org-tufte
  :recipe (:local-repo "/home/romeo/Documents/github/org-tufte"))
;; (package! ox-tufte)

;;(package! difftastic
;;  :recipe (:host github :repo pkryger/difftastic.el"))

(package! gptel)
(package! modus-themes)

;; (package! eat)

;; (package! julia-mode)
;; (package! julia-vterm)
;; (package! ob-julia-vterm)
;; (package! tree-sitter-langs)
;; (package! tree-sitter-julia
;;   :recipe (:host github :repo "tree-sitter/tree-sitter-julia"))

;; (package! julia-ts-mode)

;; (package! evil-textobj-tree-sitter)
;; (package! evil-textobj-tree-sitter
;;   :recipe (:host github
;;            :repo "meain/evil-textobj-tree-sitter"
;;            :files (:defaults "queries" "treesit-queries")
;;            :branch "treesit"))
;; (package! evil-ts :recipe (:host github :repo "foxfriday/evil-ts"))
;; (package! combombulate
;;   :recipe (:host github :repo "mickeynp/combobulate"))
;; (package! eglot-jl :ignore t)
;;
;; From https://discord.com/channels/406534637242810369/1078228006176301087/1078228432057536562
;; (package! eglot :built-in 'prefer)
;; (package! treesit :built-in 'prefer)

;; (package! ts-movement
;;   :recipe (:host github :repo "haritkapadia/ts-movement"))

;; (package! nano-emacs
;;   :recipe (:host github :repo "rougier/nano-emacs"))
;;
                                        ; (package! magit :pin "f44f6c14500476d918e9c01de8449edb20af4113")
                                        ; (package! forge :pin "ecedeaf641f3c06ac72db57837d15bdb02ac198b")

(package! eglot-booster
  :recipe (:host github :repo "jdtsmith/eglot-booster"))

(package! engrave-faces)
;; (package! ob-julia :recipe (:local-repo "lisp/ob-julia" :files ("*.el" "julia")))
                                        ; (package! magit-delta)

(package! git-link)

(package! typst-ts-mode
  :recipe (:type git :host sourcehut :repo "meow_king/typst-ts-mode" :files (:defaults "*.el")))


;; (package! org-caldav)

                                        ; (package! nickel-mode)
                                        ; (package! org-appear)

;; There's some new bug related to org-loaddefs...
(package! ox-latex-subfigure
  :recipe (:host github :repo "RomeoV/ox-latex-subfigure"))
;; (package!  powerthesaurus
;;   :recipe (:host github :repo "SavchenkoValeriy/emacs-powerthesaurus"))
;; (package!  define-word
;;   :recipe (:host github :repo "abo-abo/define-word"))
                                        ; (package!  symex
                                        ;   :recipe (:host github :repo "drym-org/symex.el" :branch 2.0-integration))
;; (package! combobulate)

;; (package! straight :pin "3eca39d")  ;; see https://github.com/doomemacs/doomemacs/issues/6960#issuecomment-1327514660

;; (package! direnv)
(package! isend-mode)                   ;; <- this is the real game changer :)
                                        ; (package! org-transclusion)

                                        ; (package! crdt)
(package! org-ai)


(package! org-modern)
(package! org-modern-indent
  :recipe (:host github :repo "jdtsmith/org-modern-indent"))
;; (package! openwith)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
                                        ;(package! another-package
                                        ;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
                                        ;(package! this-package
                                        ;  :recipe (:host github :repo "username/repo"
                                        ;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
                                        ;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
                                        ;(package! builtin-package :recipe (:nonrecursive t))
                                        ;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
                                        ;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
                                        ;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
                                        ;(unpin! pinned-package)
;; ...or multiple packages
                                        ;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
                                        ;(unpin! t)
