;;; pcmpl-lwp-request.el --- functions for dealing with lwp-request completions

;; Copyright (C) 1999, 2000, 2001, 2002, 2003, 2004,
;;   2005, 2006, 2007, 2008, 2009 Free Software Foundation, Inc.

;; Author: Kensuke Kaneko <kyanny@gmail.com>

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; These functions provide completion rules for the `lwp-request' tool.

;;; Code:

(provide 'pcmpl-lwp-request)

(require 'pcomplete)
(require 'executable)

(defgroup pcmpl-lwp-request nil
  "Functions for dealing with Lwp-Request completions."
  :group 'pcomplete)

;; User Variables:

(defcustom pcmpl-lwp-request-binary (or (executable-find "lwp-request") "lwp-request")
  "The full path of the 'lwp-request' binary."
  :type 'file
  :group 'pcmpl-lwp-request)

(defcustom pcmpl-lwp-request-content-types
  '("application/x-www-form-urlencoded" "text/plain")
  "Set the Content-Type for the request."
  :group 'pcmpl-lwp-request)

(defcustom pcmpl-lwp-request-request-headers
  '("Referer: " "Host: ")
  "Send this HTTP header with each request."
  :group 'pcmpl-lwp-request)

(defcustom pcmpl-lwp-request-output-format
  '("text" "ps" "links" "html" "dump")
  "Process HTML content in various ways before printing it."
  :group 'pcmpl-lwp-request)

;; Variables:

;(defconst pcmpl-lwp-request-opts '("-m" "-f" "-b" "-t" "-i" "-c" "-p" "-P" "-H" "-C" "-u" "-U" "-s" "-S" "-e" "-d" "-o" "-v" "-h" "-a"))

;; Functions:

;;;###autoload
(defun pcomplete/lwp-request ()
  "Completion rules for the `lwp-request' command."
  (let ((pcomplete-help "(lwp-request)Invoking Lwp-Request")
        (pcomplete-ignore-case t))
    (pcomplete-opt "mfbticpPHCuUsSedovha")
    ;(pcomplete-here pcmpl-lwp-request-opts)
    (cond ((pcomplete-test "-m")
           (setq pcomplete-help "(lwp-request)Set which method to use for the request.")
           (pcomplete-here '("GET" "HEAD" "POST" "PUT" "DELETE")))
          ((pcomplete-test "-c")
           (setq pcomplete-help "(lwp-request)Set the Content-Type for the request.")
           (pcomplete-here pcmpl-lwp-request-content-types))
          ((pcomplete-test "-H")
           (setq pcomplete-help "(lwp-request)Send this HTTP header with each request.")
           (pcomplete-here pcmpl-lwp-request-request-headers))
          ((pcomplete-test "-o")
           (setq pcomplete-help "(lwp-request)Process HTML content in various ways before printing it.")
           (pcomplete-here pcmpl-lwp-request-output-format))
          (t
           (while (pcomplete-here (pcomplete-entries)))))))

;; arch-tag: 
;;; pcmpl-lwp-request.el ends here
