;;; init -- Summary

;;; Commentary:

;;; Code:
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/config/")

(load "customizations.el")
(load "package-setup.el")
(load "my-functions.el")
(load "themes.el")

(provide 'init)

;;; init.el ends here
