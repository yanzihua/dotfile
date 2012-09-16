
;; load-path を追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf" "public_repos")


;; http://coderepos.org/share/browser/lang/elisp/init-loader/init-loader.el
(require 'init-loader)
(init-loader-load "~/.emacs.d/conf") ;設定ファイルがあるディレクトリを指定

;; Macだけに読み込ませる内容を書く
(when (eq system-type 'darwin)
  ;; MacのEmacsでファイル名を正しく扱うための設定
  (require 'ucs-normalize)
  (setq file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))

;; ターミナル以外ではツールバー、スクロールバーを表示
(when window-system
  ;; tool-barを非表示
  (tool-bar-mode 0)
  ;; scroll-barを非表示
  (scroll-bar-mode 0))

;; CocoaEmacs以外はメニューバーを非表示
(unless (eq window-system 'ns)
  ;; menu-barを非表示
  (menu-bar-mode 0))

;; Emacs 23より前のバージョンを利用する場合は
;; user-emacs-directory変数が未定義のため次の設定を追加

(when (> emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d"))

;; clパッケージを読み込む
(require 'cl)

;; phpモードを読み込み
;;(when (require 'php-mode nil t)
  ;; 読み込みに成功した場合のみ、拡張子.ctpをphp-modeで実行する
  ;;(add-to-list 'auto-mode-alist '("¥¥.ctp$" . php-mode)))

;; gitコマンドが見つかった場合のみ評価する
(when (excutable-find "git")
  (require 'egg nil t))
