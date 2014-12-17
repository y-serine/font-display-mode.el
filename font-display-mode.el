;;; font-display-mode.el --- Show font names written on buffers in those fonts

;; Copyright (C) 2014 y-serine
;; Author: y-serine <email-address-here>
;; Keywords: faces 
;; Version: 0.1
;; Homepage: https://github.com/y-serine/font-display-mode.el

;; This file is part of GNU Emacs.

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
;;
;; Font-display-mode provides a minor mode that shows font names
;; written on buffers in those fonts (e.g. a word "Times New Roman"
;; is displayed in Times New Roman).
;;

;;; Code:

(eval-when-compile
  (require 'cl))

(require 'regexp-opt)
(require 'faces)

(defgroup font-display nil
  "Show font names written on the buffer in those fonts"
  :tag "font-display"
  :group 'help)

(defvar font-display-font-lock-keywords
  `((,(regexp-opt  (font-family-list) ) 
     (0 (font-display-by-name)))) "fonts to display" )

(defun font-display-by-name ()
  (add-face-text-property
   (match-beginning 0) (match-end 0)
   (list :family (match-string-no-properties 0))))
 
(defun font-display-turn-on ()
  "Turn on font-display-mode."
  (font-lock-add-keywords nil
                          font-display-font-lock-keywords))

(defun font-display-turn-off ()
  "Turn off font-display-mode."
  (font-lock-remove-keywords nil
                             `(,@font-display-font-lock-keywords)))

;;;###autoload
(define-minor-mode font-display-mode
  "Show font names written on the buffer in those fonts"
  :lighter " Font"
  (progn
    (if font-display-mode
        (font-display-turn-on)
      (font-display-turn-off))))

(provide 'font-display-mode)

;;; font-display-mode.el ends here
