;;; flycheck-checkstyle.el --- checkstyle checker for flycheck

;; Author: Lee Adams <lee@4d4ms.com>
;; Created 16 October 2015
;; Version: 0.1
;; Package-Requires: ((flycheck "0.20"))
;; Keywords: flycheck checkstyle
;; X-URL: https://github.com/leeaustinadams/flycheck-checkstyle

;;; Commentary:

;;; Code:

(require 'flycheck)

(flycheck-def-config-file-var flycheck-checkstylerc checkstyle nil
  :safe #'stringp
  :package-version '(flycheck . "0.20"))

(flycheck-def-option-var flycheck-checkstyle-jar nil checkstyle
  "The JAR file which implements checkstyle"
  :type '(file :must-match t)
  :safe #'stringp
  :package-version '(flycheck . "0.20"))

(flycheck-def-option-var flycheck-checkstyle-propertiesrc nil checkstyle
  "The JAR file which implements checkstyle"
  :type '(file :must-match t)
  :safe #'stringp
  :package-version '(flycheck . "0.20"))

(flycheck-def-option-var flycheck-checkstyle-args-list nil checkstyle
  "A list of command line arguments for checkstyle.

The value of this variable is a list of strings, where each
string is a commandline argument to checkstyle."
  :type '(repeat (string :tag "Argument"))
  :safe #'flycheck-string-list-p
  :package-version '(flycheck . "0.20"))

(flycheck-define-checker checkstyle
  "A checkstyle checker.

See URL `http://checkstyle.sourceforge.net'."
  :command ("java"
            ;;            (option-list "-D" flycheck-checkstyle-args-list concat)
            (option "-jar" flycheck-checkstyle-jar)
            (config-file "-c" flycheck-checkstylerc)
            (config-file "-p" flycheck-checkstyle-propertiesrc)
            source)
  :error-patterns ((warning line-start (file-name) ":" line ":" (optional column) (message) line-end))
  :modes java-mode
  :predicate
  ;; Inhibit this syntax checker if the JAR or the configuration are unset or
  ;; missing
  (lambda () (and flycheck-checkstyle-jar flycheck-checkstylerc
                  (file-exists-p flycheck-checkstyle-jar)
                  (file-exists-p (flycheck-locate-config-file
                                  flycheck-checkstylerc 'checkstyle)))))


(provide 'flycheck-checkstyle)

;;; flycheck-checkstyle.el ends here
